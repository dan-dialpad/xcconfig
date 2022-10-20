//
//  XCConfigReader.swift
//  XCConfig
//
//  Created by Javier Cicchelli on 01/10/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

import Foundation

struct XCConfigReader {}

// MARK: - XCConfigDataReader

extension XCConfigReader: XCConfigDataReader {
    
    // MARK: Functions
    
    func callAsFunction(_ data: Data) async throws -> [String] {
        guard let dataAsString = String(data: data, encoding: .utf8) else {
            throw XCConfigReaderError.dataNotConvertedToStrings
        }
        
        let contents: String = {
            dataAsString == .newline
                ? String.Patterns.spaceWithNewline
                : dataAsString.replacingOccurrences(
                    of: String.Patterns.twoNewlines,
                    with: String.Patterns.twoNewlinesWithSpaceInBetween
                )
        }()
        
        return contents
            .split(separator: .newline)
            .map(String.init)
            .map { $0 == .space ? .empty : $0 }
            .map { $0.appending(String.newline) }
    }
    
}

// MARK: - Error

enum XCConfigReaderError: Error {
    case dataNotConvertedToStrings
}

// MARK: - String+Patterns

private extension String {
    
    enum Patterns {
        static let spaceWithNewline = .space + .newline
        static let twoNewlines = .newline + .newline
        static let twoNewlinesWithSpaceInBetween = .newline + .space + .newline
    }

}
