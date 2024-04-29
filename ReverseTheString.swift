//
//  StringStuff.swift
//
//  Created by Van
//  Created on 2024-04-20
//  Version 1.0
//  Copyright (c) 2024 Van Nguyen. All rights reserved.
//
//  Reverses Strings

import Foundation

// Function to reverse a string using recursion
func reverseString(inputString: String) -> String {
    // Base case: if the input string is empty, return it
    if inputString.isEmpty {
        return inputString
    }
    
    // Get the index of the last character in the input string
    let lastIndex = inputString.index(before: inputString.endIndex)
    
    // Extract the last character of the input string
    let lastCharacter = String(inputString[lastIndex])
    
    // Extract the substring excluding the last character
    let substring = String(inputString[inputString.startIndex..<lastIndex])
    
    // Recursively reverse the substring and append the last character
    return lastCharacter + reverseString(inputString: substring)
}

// Read from input file, reverse strings, and write to output file
do {
    // Input and output file paths
    let inputPath = "./input.txt"
    let outputPath = "./output.txt"
    
    // Get input file content
    let content = try String(contentsOfFile: inputPath, encoding: .utf8)
    
    // Split content into lines
    let lines = content.components(separatedBy: .newlines)
    
    // Open output file for writing
    guard let outputStream = OutputStream(toFileAtPath: outputPath, append: false) else {
        print("Error opening output file")
        exit(1)
    }
    outputStream.open()
    
    // Process each line
    for line in lines {
        let trimmedLine = line.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmedLine.isEmpty {
            let reversedString = reverseString(inputString: trimmedLine)
            let output = "Original String: \(trimmedLine)\nReversed String: \(reversedString)\n\n"
            if let data = output.data(using: .utf8) {
                let buffer = [UInt8](data)
                let bytesWritten = outputStream.write(buffer, maxLength: buffer.count)
                if bytesWritten < 0 {
                    print("Error writing to output file")
                    outputStream.close()
                    exit(1)
                }
            }
            print(output)
        }
    }
    
    // Close output stream
    outputStream.close()
} catch {
    print("Error: \(error)")
}
