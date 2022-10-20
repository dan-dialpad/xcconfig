//
//  XCConfigConverter.swift
//  XCConfig
//
//  Created by Javier Cicchelli on 02/10/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

import Foundation

struct XCConfigConverter {}

// MARK: - XCConfigDataConverter

extension XCConfigConverter: XCConfigDataConverter {

    // MARK: Functions

    func callAsFunction(_ rows: [any XCConfigRow]) async throws -> Data {
        guard !rows.isEmpty else {
            throw XCConfigConverterError.rowsNotProvided
        }
        
        let content = rows
            .map { $0.asString() }
            .map { $0.appending(String.newline) }
            .reduce(String.empty) { content, row in
                content.appending(row)
            }
        
        guard let data = content.data(using: .utf8) else {
            throw XCConfigConverterError.stringNotConvertedToData
        }
        
        return data
    }
    
}

// MARK: - Error

enum XCConfigConverterError: Error {
    case rowsNotProvided
    case stringNotConvertedToData
}
