//
//  SauceLog.swift
//  SauceLog
//
//  Created by ๊น์นํฌ on 2022/06/14.
//

import Foundation
import os.log

public enum LogType: String {
    case Normal = "SAUCELog ๐งก Normal"
    case Info = "SAUCELog โ๏ธ Info"
    case Network = "SAUCELog ๐ Network"
    case Error = "SAUCELog โ๏ธ Error"
}

public class SauceLog: NSObject {
    
    private static var FORCE_LOG: Bool {
        
        guard let forceLog = Bundle.main.infoDictionary?["ForceLog"] as? Bool else {
            return false
        }
        
        return forceLog
    }
    
    
    public static func print(output: Any?, logType: LogType = .Normal) {
        
        var filename: NSString = #file as NSString
        filename = filename.lastPathComponent as NSString
        
        if FORCE_LOG {
            if let output = output as? CVarArg {
                NSLog("[%@] %@ (Line %i) || %@", logType.rawValue, filename, #line, output)
            }
        } else {
            #if DEBUG
            saucePrint(output: output, osLogType: .default, logType: logType, filename: filename, line: #line)
            #endif
        }
    }
    
    public static func print(output: Any?, logType: LogType = .Normal, osLogType: OSLogType = .default, file: String = #file, line: Int = #line) {
        
        var filename: NSString = file as NSString
        filename = filename.lastPathComponent as NSString
        
        if FORCE_LOG {
            if let output = output as? CVarArg {
                NSLog("[%@] %@ (Line %i) || %@", logType.rawValue, filename, #line, output)
            }
        } else {
            #if DEBUG
            saucePrint(output: output, osLogType: osLogType, logType: logType, filename: filename, line: line)
            #endif
        }
    }
    
    private static func saucePrint(output: Any?, osLogType: OSLogType, logType: LogType, filename: NSString, line: Int) {
        
        let log = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: logType.rawValue)
        
        if #available(iOS 12.0, *) {
            if let output = output as? CVarArg {
                os_log(osLogType, log: log, "%@ (Line %i) : %@", filename, line, output)
            }
        } else {
            Swift.print("[SAUCE LOG] \(filename) (Line \(line)) : \(output ?? "")")
        }
        
    }
}
