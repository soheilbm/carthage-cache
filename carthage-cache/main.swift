#!/usr/bin/swift
//
//  main.swift
//  carthage-cache
//
//  Created by Soheil on 7/12/16.
//  Copyright © 2016 soheilbm. All rights reserved.
//

import Foundation

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
}

struct Arguments {
    var verbose: Bool = false
    var force: Bool = false
    var carthagePath: String
    var xcodeVersion: String?
    var swiftVersion: String?
    var shellEnvironment: String = "/usr/bin/env"
    
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
            
            if let last = path.components(separatedBy: "Cartfile.resolved").first {
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
        
        guard Arguments.resolveFileExist(path: carthagePath) == true,
            Arguments.cacheDirExist() else {
            return nil
        }
        
    }
    
    static func cacheDirExist() -> Bool {
        let documentsDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let dataPath = documentsDirectory.appendingPathComponent("carthage-cache")
        
        return File.createDir(dataPath)
    }
    
    static func checkCarthagebuildExist() -> Bool {
        return false
    }
    
    static func resolveFileExist(path: String) -> Bool {
        let newPath = path + "/Cartfile.resolved"

        if File.exists(path: newPath) == false {
            Debugger.printout("Wrong path to Cartfile.resolve!\n", type: .error)
            return false
        }
        
        return true
    }
    
    static func invalidArgument() {
        Debugger.printout("Unrecognized command: \(CommandLine.arguments.dropFirst().joined())\n", type: .error)
    }
    
    static func showHelp() {
        Debugger.printout("Available Commands:", type: .success)
        Debugger.printout("  help          Display general build commands and options")
        Debugger.printout("  build         Copy framework from cache or build a new one if doesn't exist")
        Debugger.printout("  version       Display current version\n")
        
        Debugger.printout("Options:", type: .success)
        Debugger.printout("  -r            Path to directory where Cartfile.resolved exists (by default uses current directory).")
        Debugger.printout("  -x            XCode version (by default uses `gcc --version`)")
        Debugger.printout("  -l            Swift version (by default uses `xcrun swift -version`)")
        Debugger.printout("  -s            Shell environment (by default will use /usr/bin/env)")
        Debugger.printout("  -f            Force to rebuild and copy to caching directory")
        Debugger.printout("  -v            Verbose mode\n")
    }
}

struct main {
    init(args:Array<String>) {
        guard let _ = Arguments(args) else {return}
        
//        Command.run(launchPath: newArgument.shellEnvironment, verbose: newArgument.verbose, args: "carthage","update")
    }
}

_ = main(args: CommandLine.arguments)
