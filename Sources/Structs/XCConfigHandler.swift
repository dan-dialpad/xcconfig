//
//  XCConfigHandler.swift
//  XCConfig
//
//  Created by Javier Cicchelli on 03/10/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

import Foundation

struct XCConfigHandler {
    
    // MARK: Properties
    
    private let fileManager: XCConfigFileManager
    private let reader: XCConfigDataReader
    private let parser: any XCConfigRowParser
    private let converter: XCConfigDataConverter
    
    // MARK: Life cycle
    
    init(
        fileManager: XCConfigFileManager = FileManager.default,
        reader: XCConfigDataReader = XCConfigReader(),
        parser: any XCConfigRowParser = XCConfigParser(),
        converter: XCConfigDataConverter = XCConfigConverter()
    ) {
        self.fileManager = fileManager
        self.reader = reader
        self.parser = parser
        self.converter = converter
    }
    
}

// MARK: - XCConfigFileHandler

extension XCConfigHandler: XCConfigFileHandler {

    // MARK: Functions
    
    @discardableResult
    func verify(url: URL) async throws -> Bool {
        guard url.isFileURL else { throw XCConfigHandlerError.urlNotFile }
        guard url.isXCConfigExtension else { throw XCConfigHandlerError.urlPathNotXCConfig }
        
        let path = url.path()
        
        guard fileManager.fileExists(atPath: path) else { throw XCConfigHandlerError.urlPathNotFound }
        guard fileManager.isWritableFile(atPath: path) else { throw XCConfigHandlerError.urlPathNotWritable }

        return true
    }
    
    func read(fromURL url: URL) async throws -> [any XCConfigRow] {
        guard let data = fileManager.contents(atPath: url.path()) else {
            throw XCConfigHandlerError.dataNotRetrieved
            
        }
        guard !data.isEmpty else { throw XCConfigHandlerError.dataIsEmpty }
        
        var rows: [any XCConfigRow] = []
        
        for content in try await reader(data) {
            rows.append(try await parser(content))
        }
        
        return rows
    }
    
    func write(rows: [any XCConfigRow], toURL url: URL) async throws {
        guard !rows.isEmpty else { throw XCConfigHandlerError.rowsIsEmpty }
        
        let data = try await converter(rows)
        let path = url.path()
        
        if fileManager.fileExists(atPath: path) {
            try fileManager.removeItem(atPath: path)
        }
        
        guard fileManager.createFile(
            atPath: path,
            contents: data,
            attributes: nil
        ) else { throw XCConfigHandlerError.fileNotCreated }
    }
    
}

// MARK: - Error

enum XCConfigHandlerError: Error {
    case urlNotFile
    case urlPathNotXCConfig
    case urlPathNotFound
    case urlPathNotWritable
    case dataNotRetrieved
    case dataIsEmpty
    case rowsIsEmpty
    case fileNotCreated
}

// MARK: - String+Extensions

private extension String {
    
    enum Extensions {
        static let xcconfig = "xcconfig"
    }
    
}

// MARK: - URL+Computed

private extension URL {
    
    var isXCConfigExtension: Bool { pathExtension == .Extensions.xcconfig }
    
}
