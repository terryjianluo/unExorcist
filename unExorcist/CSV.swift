//
//  CSV.swift
//  dataHelper
//
//  Created by jianluo on 16/1/5.
//  Copyright © 2016年 jianluo. All rights reserved.
//

import Foundation

public class CSV {
    public var headers: [String] = []
    public var rows: [Dictionary<String, String>] = []
    public var columns = Dictionary<String, [String]>()
    var delimiter = CharacterSet(charactersIn: ",")
    
    public init?(contentsOfFile file: String, delimiter: CharacterSet, encoding: UInt, error: NSErrorPointer) {
        let csvString : String
        do {
            csvString = try String(contentsOfFile: file);
            let csvStringToParse = csvString
            self.delimiter = delimiter
            
            let newline = CharacterSet.newlines
            var lines: [String] = []
            csvStringToParse.trimmingCharacters(in: newline).enumerateLines { line, stop in lines.append(line) }
            
            self.headers = self.parseHeaders(fromLines: lines)
            self.rows = self.parseRows(fromLines: lines)
            self.columns = self.parseColumns(fromLines: lines)
        }
        catch {
            csvString = ""
        }
        
    }
    
    public convenience init?(contentsOfFile file: String, error: NSErrorPointer) {
        let comma = CharacterSet(charactersIn: ",")
        self.init(contentsOfFile: file, delimiter: comma, encoding: String.Encoding.utf8.rawValue, error: error)
    }
    
    public convenience init?(contentsOfURL file: String, encoding: UInt, error: NSErrorPointer) {
        let comma = CharacterSet(charactersIn: ",")
        self.init(contentsOfFile: file, delimiter: comma, encoding: encoding, error: error)
    }
    
    func parseHeaders(fromLines lines: [String]) -> [String] {
        return lines[0].components(separatedBy: self.delimiter)
    }
    
    func parseRows(fromLines lines: [String]) -> [Dictionary<String, String>] {
        var rows: [Dictionary<String, String>] = []
        
        for (lineNumber, line) in lines.enumerated() {
            if lineNumber == 0 {
                continue
            }
            
            var row = Dictionary<String, String>()
            let values = line.components(separatedBy: self.delimiter)
            for (index, header) in self.headers.enumerated() {
                if index < values.count {
                    row[header] = values[index]
                } else {
                    row[header] = ""
                }
            }
            rows.append(row)
        }
        
        return rows
    }
    
    func parseColumns(fromLines lines: [String]) -> Dictionary<String, [String]> {
        var columns = Dictionary<String, [String]>()
        
        for header in self.headers {
            let column = self.rows.map { row in row[header] != nil ? row[header]! : "" }
            columns[header] = column
        }
        
        return columns
    }
}
