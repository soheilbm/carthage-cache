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
        case error =  "\u{001B}[0;31m"
        case warning = "\u{001B}[0;33m"
        case success = "\u{001B}[0;32m"
    }
    
    static func printout(str: String, type: Debugger.PrintType = Debugger.PrintType.standard) {
        print(type.rawValue + str)
    }
}

struct Arguments {
    var help: Bool = true
    var verbose: Bool = false
    var carthagePath: String?
    var cachePath: String?
    var xcodeVersion: String?
    var swiftVersion: String?
    var shellEnvironment: String?
    
    init?(_ args:Array<String>) {
        if let _ = args.index(of: "help") {
            Arguments.showHelp() ;
        }
        
        if let _ = args.index(of: "version") {
            
        }
        
        return nil
    }
    
    static func invalidArgument() {
        Debugger.printout(str: "Unrecognized command: \(CommandLine.arguments.dropFirst().joined())", type: .error)
    }
    
    static func showHelp() {
        Debugger.printout(str: "Available Commands:", type: .success)
        Debugger.printout(str: "  help          Display general build commands and options")
        Debugger.printout(str: "  build         Copy framework from cache or build a new one if doesn't exist")
        Debugger.printout(str: "  version       Display current version\n")
        
        Debugger.printout(str: "Options:", type: .success)
        Debugger.printout(str: "  -r            Path to Carthage resolve file (by default uses current directory).")
        Debugger.printout(str: "  -c            Path to caching directory (by default it will store into ~/Library/Caches/carthage-cache).")
        Debugger.printout(str: "  -x            XCode version (by default uses `gcc --version`)")
        Debugger.printout(str: "  -l            Swift version (by default uses `swift -v`)")
        Debugger.printout(str: "  -s            Shell environment (by default will use /usr/bin/env)")
        Debugger.printout(str: "  -f            Force to rebuild and copy to caching directory")
        Debugger.printout(str: "  -v            Verbose mode\n")
    }
}

struct main {
    @discardableResult func run(launchPath: String = "/usr/bin/env", verbose: Bool = true, args : String...) -> (output: [String], error: [String], exitCode: Int32) {
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
                                                                                if verbose { print("output: \(str)")}
                                                                                let string = str.trimmingCharacters(in: .newlines)
                                                                                output.append(string)
                                                                            }
                                                                            outHandle.waitForDataInBackgroundAndNotify()
                                                                        } else {
                                                                            print("EOF on stdout from process")
                                                                            NotificationCenter.default.removeObserver(outObject)
                                                                        }
        }
        
        var errorObject : NSObjectProtocol!
        errorObject = NotificationCenter.default.addObserver(forName: NSNotification.Name.NSFileHandleDataAvailable,
                                                      object: errorHandle, queue: nil) {  notification -> Void in
                                                        let data = errorHandle.availableData
                                                        if data.count > 0 {
                                                            if let str = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                                                                if verbose { print("output: \(str)")}
                                                                let string = str.trimmingCharacters(in: .newlines)
                                                                error.append(string)
                                                            }
                                                            outHandle.waitForDataInBackgroundAndNotify()
                                                        } else {
                                                            print("EOF on stdout from process")
                                                            NotificationCenter.default.removeObserver(errorObject)
                                                        }
        }
        
        task.launch()
        task.waitUntilExit()
        let status = task.terminationStatus
        return (output, error, status)
    }
    
    init(args:Array<String>) {
        guard let _ = Arguments(args) else {
            Arguments.invalidArgument()
            return
        }
        
        print("C")
    }
}

_ = main(args: CommandLine.arguments)
