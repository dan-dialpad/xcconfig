//
//  XCConfigHandler+WriteTests.swift
//  XCConfigTests
//
//  Created by Javier Cicchelli on 05/10/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

import XCTest

@testable import XCConfig

final class XCConfigHandlerWriteTests: XCTestCase {
    
    // MARK: Constants
    
    private let url = URL.Seeds.Files.xcconfig
    
    // MARK: Properties
    
    private var rows: [any XCConfigRow]!
    
    private var handler: XCConfigHandler!
    
    // MARK: Write rows to URL tests
    
    func testWriteRowsToURL_withOneEmptyRow() async throws {
        // GIVEN
        rows = [XCConfigRowEmpty()]
        handler = .init(fileManager: XCConfigFileManagerMock(
            fileExists: true, 
            removeItem: true,
            createFile: true
        ))
        
        // WHEN & THEN
        do {
            try await handler.write(rows: rows, toURL: url)
            
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func testWriteRowsToURL_withOneCommentRow() async throws {
        // GIVEN
        rows = [XCConfigRowComment(text: "// Something goes here...")]
        handler = .init(fileManager: XCConfigFileManagerMock(
            fileExists: true,
            removeItem: true,
            createFile: true
        ))
        
        // WHEN & THEN
        do {
            try await handler.write(rows: rows, toURL: url)
            
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func testWriteRowsToURL_withOneIncludeRow() async throws {
        // GIVEN
        rows = [XCConfigRowInclude(file: "../path/to/file.xcconfig")]
        handler = .init(fileManager: XCConfigFileManagerMock(
            fileExists: true, 
            removeItem: true,
            createFile: true
        ))
        
        // WHEN & THEN
        do {
            try await handler.write(rows: rows, toURL: url)
            
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func testWriteRowsToURL_withOnePropertyRow() async throws {
        // GIVEN
        rows = [XCConfigRowProperty(key: "SOME_KEY", value: "SOME_VALUE")]
        handler = .init(fileManager: XCConfigFileManagerMock(
            fileExists: true,
            removeItem: true,
            createFile: true
        ))
        
        // WHEN & THEN
        do {
            try await handler.write(rows: rows, toURL: url)
            
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func testWriteRowsToURL_withMultipleKindOfRows() async throws {
        // GIVEN
        rows = [
            XCConfigRowComment(text: "// Something goes here..."),
            XCConfigRowEmpty(),
            XCConfigRowInclude(file: "../path/to/file.xcconfig"),
            XCConfigRowEmpty(),
            XCConfigRowProperty(key: "SOME_KEY", value: "SOME_VALUE")
        ]
        handler = .init(fileManager: XCConfigFileManagerMock(
            fileExists: true, 
            removeItem: true,
            createFile: true
        ))
        
        // WHEN & THEN
        do {
            try await handler.write(rows: rows, toURL: url)
            
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func testWriteRowsToURL_whenCreatingNewFile() async throws {
        // GIVEN
        rows = [
            XCConfigRowComment(text: "// Something goes here..."),
            XCConfigRowEmpty(),
            XCConfigRowInclude(file: "../path/to/file.xcconfig"),
            XCConfigRowEmpty(),
            XCConfigRowProperty(key: "SOME_KEY", value: "SOME_VALUE")
        ]
        handler = .init(fileManager: XCConfigFileManagerMock(
            fileExists: false,
            removeItem: false,
            createFile: true
        ))
        
        // WHEN & THEN
        do {
            try await handler.write(rows: rows, toURL: url)
            
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func testWriteRowsToURL_whenRowsIsEmpty() async throws {
        // GIVEN
        rows = []
        handler = .init(fileManager: XCConfigFileManagerMock())
        
        // WHEN & THEN
        do {
            try await handler.write(rows: rows, toURL: url)
        } catch XCConfigHandlerError.rowsIsEmpty {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func testWriteRowsToURL_whenCannotRemoveExistingFile() async throws {
        // GIVEN
        rows = [XCConfigRowEmpty()]
        handler = .init(fileManager: XCConfigFileManagerMock(
            fileExists: true, 
            removeItem: false
        ))
        
        // WHEN & THEN
        do {
            try await handler.write(rows: rows, toURL: url)
        } catch {
            guard let error = error as? NSError,
                  error.domain == .empty,
                  error.code == 0
            else {
                XCTAssertTrue(false)
                return
            }
            
            XCTAssertTrue(true)
        }
    }
    
    func testWriteRowsToURL_whenCannotCreateNewFile() async throws {
        // GIVEN
        rows = [XCConfigRowEmpty()]
        handler = .init(fileManager: XCConfigFileManagerMock(
            fileExists: false, 
            removeItem: true,
            createFile: false
        ))
        
        // WHEN & THEN
        do {
            try await handler.write(rows: rows, toURL: url)
        } catch XCConfigHandlerError.fileNotCreated {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
}
