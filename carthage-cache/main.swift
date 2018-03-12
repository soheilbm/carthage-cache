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
let kVersion          = "v0.1.11"

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
    
    static func directoryConstainsFile(path: String) -> Bool {
        do {
            let contents = try FileManager.default.contentsOfDirectory(atPath: path)
                .filter{ $0 != ".DS_Store" && $0 != "" }
            return contents.count > 0
        } catch {
            return false
        }
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
    var useSSH: Bool = true
    var carthagePath: String
    var xcodeVersion: String = {
        let command = Command.run(args: "llvm-gcc", "-v")
        var output = command.output.first
        if output == nil  { output = command.error.first }
        
        if let output = output {
            let firstString = output.components(separatedBy: "\n")[0]
            let strArray = firstString.components(separatedBy: " ")
            let version = strArray[3]
            return version
        }
        return ""
    }()
    
    var swiftVersion: String = {
        let command = Command.run(args: "xcrun", "swift", "-version")
        var output = command.output.first
        if output == nil  { output = command.error.first }
        
        if let output = output {
            let firstString = output.components(separatedBy: "\n")[0]
            let strArray = firstString.components(separatedBy: " ")
            let version = strArray[3]
            return version
        }
        return ""
    }()
    
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
            
            let version = "Current version: \(kVersion)\n"
            Debugger.printout(version, type: Debugger.PrintType.success)
            
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
        
        if let i = newArgs.index(of: "-u") {
            useSSH = true
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
            
            if let last = path.last, last == "/" {
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
        
        if let index = newArgs.index(of: "-p"), let i = newArgs.index(index, offsetBy: 1, limitedBy: 1) {
            platform = newArgs[i]
            newArgs.remove(at: i)
            newArgs.remove(at: index)
        }
        
        if Arguments.cartfileExist(path: carthagePath) == false {
            Arguments.updateAllLibraries()
        }
        
        if Arguments.cacheDirExist(platform,swiftVersion: swiftVersion, xcodeVersion: xcodeVersion) == false {
            Debugger.printout("Cannot create cache directory", type: .error)
            return nil
        }
    }
    
    static func updateAllLibraries() {
        Command.run(args: "carthage", "update","--platform")
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

                            if array.count >= 2 && File.directoryConstainsFile(path: name.path) {
                                libraries.append(Library(name: array[0], version: array[1]))
                            }
                        }
                    }
                }
            }
        }
        
        return libraries
    }
    
    func updateCartfileResolved() {
        Command.run(launchPath: shellEnvironment, verbose: verbose, args: "carthage", "update","--no-build", useSSH == true ? "--use-ssh" : "")
    }
    
    func copyToCache(_ libraries: Set<Library>) {
        for i in libraries {
            let newPath = carthagePath + "/\(kCarthage)/Build/\(platform)"
            File.remove(path: newPath)
            
            Debugger.printout("Building library \(i.name)")
            Command.run(launchPath: shellEnvironment, verbose: verbose, args: "carthage", "bootstrap","\(i.name)","--verbose","--platform", platform, useSSH == true ? "--use-ssh" : "")
    
            let documentsDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
            let path = kCarthageCacheDir + "/" + "X\(xcodeVersion)_S\(swiftVersion)" + "/" + platform + "/" + i.name
            let dataPath = documentsDirectory.appendingPathComponent(path)
            let pathWithVersion = dataPath.appendingPathComponent(i.version).absoluteString.replacingOccurrences(of: "file://", with: "")
            
            let _ = File.createDir(dataPath.absoluteString.replacingOccurrences(of: "file://", with: ""))
            let _ = File.remove(path: pathWithVersion)
            
            if File.copy(path: newPath, toPath: pathWithVersion) == false {
                let _ = File.createDir(pathWithVersion)
            }
        }
    }
    
    func copyFromCacheToCarthage(_ libraries: Set<Library>) {
        let newPath = carthagePath + "/\(kCarthage)/Build/\(platform)"
        File.remove(path: newPath)
        let _ = File.createDir(newPath)
        
        for i in libraries {
            Debugger.printout("Copying library \(i.name) from cache")
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
    
    static func cartfileExist(path: String) -> Bool {
        let newPath = path + "/\(kCartfile)"
        if File.exists(path: newPath) == false {
            Debugger.printout("Wrong path to \(kCartfile)!\n", type: .error)
            return false
        }
        
        return true
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
        Debugger.printout("  build         Copy framework from cache or build a new one from Cartfile.Resolve if doesn't exist")
        Debugger.printout("  version       Display current version\n")
        
        Debugger.printout("Options:", type: .success)
        Debugger.printout("  -r            Path to directory where \(kCartfileResolved) exists (by default uses current directory).")
        Debugger.printout("  -x            XCode version (by default uses `llvm-gcc -v`). e.g 8.0.0")
        Debugger.printout("  -l            Swift version (by default uses `xcrun swift -version`). e.g 3.0")
        Debugger.printout("  -s            Shell environment (by default will use /usr/bin/env)")
        Debugger.printout("  -f            Force to rebuild and copy to caching directory")
        Debugger.printout("  -p            platform (by default uses iOS). Supported Type are iOS, Mac, tvOS, watchOS.")
        Debugger.printout("  -n            Not Use --use-ssh option(Default yes)")
        Debugger.printout("  -v            Verbose mode\n")
    }
}

struct main {
    init(args:Array<String>) {
        guard let arguments = Arguments(args) else {return}
        arguments.updateCartfileResolved()
        let cartFiles = Set(arguments.getLibrariesFromCartfileResolve())
        let cacheFiles = Set(arguments.getLibraryFromCache())
        
        let missingCachFiles = cartFiles.subtracting(cacheFiles)
        
        if arguments.force {
            Debugger.printout("Force Building and copying Libraries to cache 🛠 \n", type: .standard)
            arguments.copyToCache(cartFiles)
        } else {
            if missingCachFiles.count > 0 {
                Debugger.printout("Building and copying Libraries to cache 🛠 \n", type: .standard)
                arguments.copyToCache(missingCachFiles)
            }
        }
        
        Debugger.printout("Copying framework from cache to carthage build 💾", type: .standard)
        arguments.copyFromCacheToCarthage(cartFiles)
        Debugger.printout("Done! 🍻", type: .success)
    }
}


_ = main(args: CommandLine.arguments)
