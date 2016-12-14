#!/usr/bin/swift
//  PropertyGuru PGNetworkSDK
//  Created by Soheil B.Marvasti on 26/4/16.
//
import Foundation


@discardableResult func run(args: String...) -> String? {
    let task = Process()
    task.launchPath = "/usr/bin/env"
    task.arguments = args
    
    let pipe = Pipe()
    task.standardOutput = pipe
    task.launch()
    task.waitUntilExit()
    
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    return String(data: data, encoding: String.Encoding.utf8)
}

class File {
    class func exists (path: String) -> Bool {
        return FileManager.default.fileExists(atPath: path)
    }
    
    class func read (path: String, encoding: String.Encoding = String.Encoding.utf8) -> String? {
        if File.exists(path: path) {
            return try? String.init(contentsOfFile: path, encoding: encoding)
        }
        
        return nil
    }
    
    class func write (path: String, content: String, encoding: String.Encoding = String.Encoding.utf8) -> Bool {
        return ((try? content.write(toFile: path, atomically: true, encoding: encoding)) != nil) ?true :false
    }
}

class Main {
    lazy var key: String = {
        return "O8Lunljkenrgi2u3y4829y349werfbu"
    }()
    
    let fileManager = FileManager.default
    let template: String = "import Foundation\n" +
    "\n" +
    "struct NetworkPlistConfiguration {\n" +
    "  static var key: String = {\n" +
    "    return \"{KEY}\"\n" +
    "  }()\n" +
    "}\n"

    private var argument:Array<String> = []
    
    func generateKey() {
        let output = FileManager.default.currentDirectoryPath
        let content = template.replacingOccurrences(of: "{KEY}", with: key)
        let _ = File.write(path: output + "/Source/SDKConfiguration/NetworkPlistConfiguration.swift", content: content )
    }
    
    init(commands:Array<String>) {
        
        if let _ = commands.index(of: "install") {
            install()
            return
        }
        
        if let index =  commands.index(of: "encrypt") {
            argument = Array(commands[index..<commands.count])
            encryption()
            generateKey()
            return
        }
        
        if let index =  commands.index(of: "decrypt") {
            argument = Array(commands[index..<commands.count])
            decrypt()
            return
        }
        
        if let index =  commands.index(of: "test") {
            argument = Array(commands[index..<commands.count])
            unitTest()
            return
        }
        
        if let _ = commands.index(of: "which") {
            print(run(args: "which", "swift")!)
        }
        
        showDefaultHelp()
    }
    
    private func install() {
        run(args: "carthage", "update")
    }
    
    private func encryption()  {
        if let passcode = getParam(arg: "-p") {
            key = passcode
        }
        
        guard let filePath = getParam(arg: "-f") else {
            showEncryptionHelp()
            return
        }
        
        guard let outputName = getParam(arg: "-n") else {
            showEncryptionHelp()
            return
        }
        
        let path = filePath.components(separatedBy: "/")
        var outputPath: String = getParam(arg: "-o") ?? filePath.replacingOccurrences(of: path.last!, with: "")
        outputPath = "\(outputPath)"+"/"+"\(outputName)"
        
        // using 256-bit AES in CBC mode
        run(args: "./Scripts/AES256Encrypter", "-e", "\(key)", "\(filePath)", "\(outputPath)")
    }
    
    private func decrypt()  {
        guard let passcode = getParam(arg: "-p") else {
            showDecryptionHelp()
            return
        }
        
        guard let filePath = getParam(arg: "-f") else {
            showDecryptionHelp()
            return
        }
        
        guard let outputName = getParam(arg: "-n") else {
            showDecryptionHelp()
            return
        }
        
        let path = filePath.components(separatedBy: "/")
        var outputPath: String = getParam(arg: "-o") ?? filePath.replacingOccurrences(of: path.last!, with: "")
        outputPath = "\(outputPath)"+"/"+"\(outputName)"
        
        // using 256-bit AES in CBC mode
        run(args: "./Scripts/AES256Encrypter", "-d", "\(passcode)", "\(filePath)", "\(outputPath)")
    }
    
    private func unitTest()  {
        var scriptHasExecuted = false
        if let _ = argument.index(of: "-u") {
            run(args: "xcodebuild", "test","-scheme","PGNetworkSDK","-destination","platform=iOS Simulator,name=iPhone 6,OS=10.0")
            scriptHasExecuted = true
        }
        
        if let _ = argument.index(of: "-x") {
            run(args: "slather", "coverage", "-x", "--scheme", "PGNetworkSDK", "--workspace", "PGNetworkSDK.xcworkspace", "PGNetworkSDK.xcodeproj")
            scriptHasExecuted = true
        }
        
        if let _ = argument.index(of: "-t") {
            if let _ = argument.index(of: "-s") {
                run(args: "slather", "coverage", "--show", "--html", "--scheme", "PGNetworkSDK", "--workspace", "PGNetworkSDK.xcworkspace", "PGNetworkSDK.xcodeproj")
            }else{
                run(args: "slather", "coverage", "--html", "--scheme", "PGNetworkSDK", "--workspace", "PGNetworkSDK.xcworkspace", "PGNetworkSDK.xcodeproj")
            }
            
            scriptHasExecuted = true
        }
        
        if scriptHasExecuted == false {
            showTestHelp()
        }
    }
    
    private func getParam(arg:String) -> String? {
        if let pathIndex = argument.index(of: arg) {
            if pathIndex + 1 < argument.count {
                return argument[pathIndex+1]
            }
        }
        
        return nil
    }
    
    private func showTestHelp() {
        print("####### PGNetworkSDK Unit Test Help ######")
        print("Usage of PGNetworkSDK unitTests: ")
        print(" -u  Run unit test. By default this does not runs xcode build test.")
        print(" -x  Generate cobertura XML output for coverage")
        print(" -t  Generate HTML output for coverage")
        print(" -s  Display The generated HTML output. This only applies when -t is also provided.")
    }
    
    private func showEncryptionHelp() {
        print("####### Encryption Help ######");
        print(" Note: Make sure the output folder has enough permision to write a new file.")
        print(" -p    PassCode. You can name anything to ecnrypt your file ")
        print(" -f    File path to be encrypted. e.g. ~/Desktop/info.plist ")
        print(" -n    Output Name. e.g example.data")
        print(" -o    Output directory. e.g ~/Desktop")
    }
    
    private func showDecryptionHelp() {
        print("####### Decryption Help ######")
        print(" Note: Make sure the output folder has enough permision to write a new file.")
        print(" -p    PassCode. You can name anything to ecnrypt your file ")
        print(" -f    File path to be encrypted. e.g. ~/Desktop/info.data ")
        print(" -n    Output Name. e.g example.plist")
        print(" -o    Output directory. e.g ~/Desktop")
    }
    
    private func showDefaultHelp() {
        print("####### PGNetworkSDK Main script ######")
        print(" install       Installation Script")
        print(" encrypt      Encryption scripts")
        print(" decrypt      Decryption scripts")
        print(" test         Run Unit test")
        print(" [COMMAND] -h  to get help for each command")
    }
}

/// Run Main Script
let _ = Main(commands: CommandLine.arguments)
