#!/usr/bin/swift
//
//  main.swift
//  carthage-cache
//
//  Created by Soheil on 7/12/16.
//  Copyright © 2016 soheilbm. All rights reserved.
//

import Foundation

// Constants
let kCartfile         = "Cartfile"
let kCarthage         = "Carthage"
let kCartfileResolved = "Cartfile.resolved"
let kCarthageCacheDir = "carthage-cache"

struct Debugger {
    enum PrintType: String {
        case standard = "\u{001B}[0;37m"
        case error    = "\u{001B}[0;31m"
        case warning  = "\u{001B}[0;33m"
        case success  = "\u{001B}[0;32m"
    }
    
    static func printout(_ str: String, type: Debugger.PrintType = Debugger.PrintType.standard) {
        print(type.rawValue + str)
    }
}

struct Command {
    @discardableResult static func run(launchPath: String = "/usr/bin/env", verbose: Bool = false, args : String...) -> (output: [String], error: [String], exitCode: Int32) {
        var output : [String] = []
        var error : [String] = []
        
        let task = Process()
        task.launchPath = launchPath
        task.arguments = args
        
        let outpipe = Pipe()
        task.standardOutput = outpipe
        let errorPipe = Pipe()
        task.standardError = errorPipe
        
        let outHandle = outpipe.fileHandleForReading
        outHandle.waitForDataInBackgroundAndNotify()
        
        let errorHandle = errorPipe.fileHandleForReading
        errorHandle.waitForDataInBackgroundAndNotify()
        
        var outObject : NSObjectProtocol!
        outObject = NotificationCenter.default.addObserver(forName: NSNotification.Name.NSFileHandleDataAvailable,
                                                           object: outHandle, queue: nil) {  notification -> Void in
                                                            let data = outHandle.availableData
                                                            if data.count > 0 {
                                                                if let str = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                                                                    if verbose { Debugger.printout(str as String)}
                                                                    let string = str.trimmingCharacters(in: .newlines)
                                                                    output.append(string)
                                                                }
                                                                outHandle.waitForDataInBackgroundAndNotify()
                                                            } else {
                                                                NotificationCenter.default.removeObserver(outObject)
                                                            }
        }
        
        var errorObject : NSObjectProtocol!
        errorObject = NotificationCenter.default.addObserver(forName: NSNotification.Name.NSFileHandleDataAvailable,
                                                             object: errorHandle, queue: nil) {  notification -> Void in
                                                                let data = errorHandle.availableData
                                                                if data.count > 0 {
                                                                    if let str = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                                                                        if verbose { Debugger.printout(str as String, type: .error) }
                                                                        let string = str.trimmingCharacters(in: .newlines)
                                                                        error.append(string)
                                                                    }
                                                                    outHandle.waitForDataInBackgroundAndNotify()
                                                                } else {
                                                                    NotificationCenter.default.removeObserver(errorObject)
                                                                }
        }
        
        task.launch()
        task.waitUntilExit()
        let status = task.terminationStatus
        return (output, error, status)
    }
}

struct File {
    static func createDir(_ dataPath: URL) -> Bool {
        do {
            try FileManager.default.createDirectory(atPath: dataPath.path, withIntermediateDirectories: true, attributes: nil)
            return true
        } catch let error as NSError {
            Debugger.printout("Error creating directory: \(error.localizedDescription)", type: Debugger.PrintType.error)
            return false
        }
    }
    
    static func createDir(_ dataPath: String) -> Bool {
        do {
            try FileManager.default.createDirectory(atPath: dataPath, withIntermediateDirectories: true, attributes: nil)
            return true
        } catch let error as NSError {
            Debugger.printout("Error creating directory: \(error.localizedDescription)", type: Debugger.PrintType.error)
            return false
        }
    }
    
    static func exists (path: String) -> Bool {
        return FileManager.default.fileExists(atPath: path)
    }
    
    static func read (path: String, encoding: String.Encoding = String.Encoding.utf8) -> String? {
        if File.exists(path: path) {
            return try? String.init(contentsOfFile: path, encoding: encoding)
        }
        
        return nil
    }
    
    static func write (path: String, content: String, encoding: String.Encoding = String.Encoding.utf8) -> Bool {
        return ((try? content.write(toFile: path, atomically: true, encoding: encoding)) != nil) ?true :false
    }
    
    static func remove (path: String) {
        try? FileManager.default.removeItem(atPath: path)
    }
    
    static func copy (path: String, toPath: String) -> Bool {
        do {
            try FileManager.default.moveItem(atPath: path, toPath: toPath)
            return true
        } catch let error as NSError {
            Debugger.printout("Error copying : \(error.localizedDescription)", type: Debugger.PrintType.error)
            return false
        }
    }
}

struct Library: Hashable {
    let name: String
    let version: String
    
    var hashValue: Int {
        return name.hashValue ^ version.hashValue
    }
    
    static func == (lhs: Library, rhs: Library) -> Bool {
        return lhs.name == rhs.name && lhs.version == rhs.version
    }
}

struct Arguments {
    var verbose: Bool = false
    var force: Bool = false
    var carthagePath: String
    var xcodeVersion: String = "8.0.0"
    var swiftVersion: String = "3.0"
    var platform: String = "iOS"
    var shellEnvironment: String = "/usr/bin/env"
    var libraries: [Library]?
    
    init?(_ args:Array<String>) {
        var newArgs = args.dropFirst()
        if let _ = newArgs.index(of: "help") {
            Arguments.showHelp();
            return nil
        }
        
        if let _ = newArgs.index(of: "version") {
            let (v,_,_) = Command.run(args: "git","describe", "--abbrev=0", "--tags")
            
            if let gitVersion = v.first {
                let version = "Current version: \(gitVersion)\n"
                Debugger.printout(version, type: Debugger.PrintType.success)
            }else{
                Debugger.printout("Something went wrong!", type: Debugger.PrintType.error)
            }
            
            return nil
        }
    
        guard let _ = newArgs.index(of: "build") else {
            Arguments.invalidArgument()
            return nil
        }
        
        if let index = newArgs.index(of: "-s"), let i = newArgs.index(index, offsetBy: 1, limitedBy: 1) {
            shellEnvironment = newArgs[i]
            newArgs.remove(at: i)
            newArgs.remove(at: index)
        }
        
        if let i = newArgs.index(of: "-v") {
            verbose = true
            newArgs.remove(at: i)
        }
        
        if let i = newArgs.index(of: "-f") {
            force = true
            newArgs.remove(at: i)
        }
        
        if let index = newArgs.index(of: "-r"), let i = newArgs.index(index, offsetBy: 1, limitedBy: 1) {
            var path = newArgs[i]
            
            if let last = path.components(separatedBy: kCartfileResolved).first {
                path = last
            }
            
            if let last = path.characters.last, last == "/" {
                path = path.substring(to: path.index(before: path.endIndex))
            }
            
            carthagePath = path
            newArgs.remove(at: i)
            newArgs.remove(at: index)
        }else {
            carthagePath = Command.run(launchPath: shellEnvironment, args: "pwd").output.first ?? ""
        }
        
        if let index = newArgs.index(of: "-x"), let i = newArgs.index(index, offsetBy: 1, limitedBy: 1) {
            xcodeVersion = newArgs[i]
            newArgs.remove(at: i)
            newArgs.remove(at: index)
        }
        
        if let index = newArgs.index(of: "-l"), let i = newArgs.index(index, offsetBy: 1, limitedBy: 1) {
            swiftVersion = newArgs[i]
            newArgs.remove(at: i)
            newArgs.remove(at: index)
        }
        
        
        if Arguments.resolveFileExist(path: carthagePath) == false {
            Arguments.updateAllLibraries()
        }
        
        if Arguments.cacheDirExist("iOS",swiftVersion: "3.0", xcodeVersion: "8.0.0") == false {
            return nil
        }
    }
    
    static func updateAllLibraries() {
        Command.run(args: "carthage", "update","--platform","ios")
    }
    
    func getLibrariesFromCartfileResolve() -> [Library] {
        let newPath = carthagePath + "/\(kCartfileResolved)"
        
        if let file = File.read(path: newPath){
            let lines = file.components(separatedBy: "\n")
            
            
            return lines.flatMap {
                let options = $0.components(separatedBy: " ")
                guard options.count == 3 else { return nil }
                let paths = options[1].components(separatedBy: ":")
                let repoPath = paths.count == 2 ? paths[1] : paths[0]
                var name = repoPath.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: ".git", with: "")
                let tag = options[2].replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: ".git", with: "")
                
                name = name.components(separatedBy: "/")[1]
                
                return Library.init(name: name, version: tag)
            }
        }
        
        return []
    }

    func getLibrariesNameFromCartfile() -> [String] {
        let newPath = carthagePath + "/\(kCartfile)"
        
        if let file = File.read(path: newPath){
            let lines = file.components(separatedBy: "\n")
            
            
            return lines.flatMap {
                let options = $0.components(separatedBy: " ")
                guard options.count >= 2 else { return nil }
                let paths = options[1].components(separatedBy: ":")
                let repoPath = paths.count == 2 ? paths[1] : paths[0]
                var name = repoPath.replacingOccurrences(of: "\"", with: "")
                
                name = name.replacingOccurrences(of: ".git", with: "")
                name = name.replacingOccurrences(of: "//", with: "")
                name = name.replacingOccurrences(of: "github.com/", with: "")
                name = name.components(separatedBy: "/")[1]
                
                return name
            }
        }
        
        return []
    }

    
    func getLibraryFromCache() -> [Library] {
        let documentsDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let packagePath = "X\(xcodeVersion)_S\(swiftVersion)" + "/" + platform
        let path = kCarthageCacheDir + "/" + packagePath
        let dataPath = documentsDirectory.appendingPathComponent(path)
        var libraries = [Library]()
        
        if let e = FileManager.default.enumerator(at: dataPath, includingPropertiesForKeys: [kCFURLIsDirectoryKey as URLResourceKey], options: FileManager.DirectoryEnumerationOptions.skipsSubdirectoryDescendants, errorHandler: nil) {
            
            for i in e {
                if let m = FileManager.default.enumerator(at: i as! URL, includingPropertiesForKeys: [kCFURLIsDirectoryKey as URLResourceKey], options: FileManager.DirectoryEnumerationOptions.skipsSubdirectoryDescendants, errorHandler: nil) {
                    for x in m {
                        if let name = x as? URL {
                            let options = name.absoluteString.components(separatedBy: packagePath + "/")[1]
                            var array = options.components(separatedBy: "/")
                            
                            if let index = array.index(of: "") { array.remove(at: index) }
                            if let index = array.index(of: ".DS_Store") { array.remove(at: index) }
                            
                            if array.count >= 2 {
                                libraries.append(Library(name: array[0], version: array[1]))
                            }
                        }
                    }
                }
            }
        }
        
        return libraries
    }
    
    func fetchGitLibraries() {
        Command.run(launchPath: shellEnvironment, verbose: verbose, args: "carthage","checkout")
    }
    
    func copyToCache(_ libraries: Set<Library>) {
        for i in libraries {
            let newPath = carthagePath + "/\(kCarthage)/Build/iOS"
            File.remove(path: newPath)
            
            Debugger.printout("Building library \(i.name)")
            Command.run(launchPath: shellEnvironment, verbose: verbose, args: "carthage", "build","\(i.name)","--no-use-binaries","--platform","ios")
    
            let documentsDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
            let path = kCarthageCacheDir + "/" + "X\(xcodeVersion)_S\(swiftVersion)" + "/" + platform + "/" + i.name
            let dataPath = documentsDirectory.appendingPathComponent(path)
            let pathWithVersion = dataPath.appendingPathComponent(i.version).absoluteString.replacingOccurrences(of: "file://", with: "")
            
            let _ = File.remove(path: pathWithVersion)
            let _ = File.createDir(dataPath)
            
            let _ = File.copy(path: newPath, toPath: pathWithVersion)
        }
    }
    
    func copyFromCacheToCarthage(_ libraries: Set<Library>) {
        let newPath = carthagePath + "/\(kCarthage)/Build/iOS"
        File.remove(path: newPath)
        let _ = File.createDir(newPath)
        
        for i in libraries {
            let documentsDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
            let path = kCarthageCacheDir + "/" + "X\(xcodeVersion)_S\(swiftVersion)" + "/" + platform + "/" + i.name + "/" + i.version + "/."
            let dataPath = documentsDirectory.appendingPathComponent(path)
            let pathWithVersion = dataPath.absoluteString.replacingOccurrences(of: "file://", with: "")
            
            Command.run(launchPath: shellEnvironment, verbose: verbose, args: "cp","-rf",pathWithVersion,newPath)
        }
    }
    
    static func cacheDirExist(_ platform: String, swiftVersion: String, xcodeVersion: String) -> Bool {
        let documentsDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let path = kCarthageCacheDir + "/" + "X\(xcodeVersion)_S\(swiftVersion)" + "/" + platform
        let dataPath = documentsDirectory.appendingPathComponent(path)
        
        return File.createDir(dataPath)
    }
    
    static func resolveFileExist(path: String) -> Bool {
        let newPath = path + "/\(kCartfileResolved)"

        if File.exists(path: newPath) == false {
            Debugger.printout("Wrong path to \(kCartfileResolved)!\n", type: .error)
            return false
        }
        
        return true
    }
    
    static func invalidArgument() {
        Debugger.printout("Unrecognized command: \(CommandLine.arguments.dropFirst().joined())", type: .error)
        Debugger.printout("Use `help` to show available commands.", type: .standard)
    }
    
    static func showHelp() {
        Debugger.printout("Available Commands:", type: .success)
        Debugger.printout("  help          Display general build commands and options")
        Debugger.printout("  build         Copy framework from cache or build a new one if doesn't exist")
        Debugger.printout("  version       Display current version\n")
        
        Debugger.printout("Options:", type: .success)
        Debugger.printout("  -r            Path to directory where \(kCartfileResolved) exists (by default uses current directory).")
        Debugger.printout("  -x            XCode version (by default uses `llvm-gcc -v`). e.g 8.0.0")
        Debugger.printout("  -l            Swift version (by default uses `xcrun swift -version`). e.g 3.0")
        Debugger.printout("  -s            Shell environment (by default will use /usr/bin/env)")
        Debugger.printout("  -f            Force to rebuild and copy to caching directory")
        Debugger.printout("  -v            Verbose mode\n")
    }
}

struct main {
    init(args:Array<String>) {
        guard let arguments = Arguments(args) else {return}
        let cartFiles = Set(arguments.getLibrariesFromCartfileResolve())
        let cacheFiles = Set(arguments.getLibraryFromCache())

        let missingCachFiles = cartFiles.subtracting(cacheFiles)
        
        if missingCachFiles.count > 0 {
            arguments.fetchGitLibraries()
            arguments.copyToCache(missingCachFiles)
        }
        
        arguments.copyFromCacheToCarthage(cartFiles)
    }
}

_ = main(args: CommandLine.arguments)
