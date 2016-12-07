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
    var carthagePath: String?
    var cachePath: String?
    
    
}

class main {
    @discardableResult func run(args : String..., verbose: Bool = false) -> (output: [String], error: [String], exitCode: Int32) {
        var output : [String] = []
        var error : [String] = []
        
        let task = Process()
        task.launchPath = "/usr/bin/env"
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
        
    }
}

let me = main(args: CommandLine.arguments)
me.run(args: "ls","-la")
print("\u{001B}[0;31myellow")
//me.run(args: "carthage","update","--project-directory","Test")
