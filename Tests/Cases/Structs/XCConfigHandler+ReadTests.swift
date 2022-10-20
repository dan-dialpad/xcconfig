//
//  XCConfigHandler+ReadTests.swift
//  XCConfigTests
//
//  Created by Javier Cicchelli on 04/10/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

import XCTest

@testable import XCConfig

final class XCConfigHandlerReadTests: XCTestCase {
    
    // MARK: Constants
    
    private let url = URL.Seeds.Files.xcconfig
    
    // MARK: Properties
    
    private var handler: XCConfigHandler!
    
    private var result: [any XCConfigRow]!
    private var expected: [any XCConfigRow]!

    // MARK: Read from URL tests
    
    func testReadFromURL_whenDataHasEmptyRow() async throws {
        // GIVEN
        handler = .init(fileManager: XCConfigFileManagerMock(
            fileExists: true,
            isWritableFile: true,
            contents: .Seeds.Rows.emptyWithNewline
        ))
        
        // WHEN
        result = try await handler.read(fromURL: url)
        
        // THEN
        expected = [XCConfigRowEmpty()]
        
        XCTAssertEqual(result.count, expected.count)
        
        result.enumerated().forEach { index, row in
            XCTAssert(type(of: row) == type(of: expected[index]))
            XCTAssertEqual(row.asString(), expected[index].asString())
        }
    }
    
    func testReadFromURL_whenDataHasCommentRow() async throws {
        // GIVEN
        handler = .init(fileManager: XCConfigFileManagerMock(
            fileExists: true,
            isWritableFile: true,
            contents: .Seeds.Rows.commentWithNewline
        ))
        
        // WHEN
        result = try await handler.read(fromURL: url)

        // THEN
        expected = [XCConfigRowComment(text: .Constants.comment)]
        
        XCTAssertEqual(result.count, expected.count)
        
        result.enumerated().forEach { index, row in
            XCTAssert(type(of: row) == type(of: expected[index]))
            XCTAssertEqual(row.asString(), expected[index].asString())
        }
    }
    
    func testReadFromURL_whenDataHasIncludeRow() async throws {
        // GIVEN
        handler = .init(fileManager: XCConfigFileManagerMock(
            fileExists: true,
            isWritableFile: true,
            contents: .Seeds.Rows.includeWithNewline
        ))
        
        // WHEN
        result = try await handler.read(fromURL: url)
        
        // THEN
        expected = [XCConfigRowInclude(file: .Constants.file)]
        
        XCTAssertEqual(result.count, expected.count)
        
        result.enumerated().forEach { index, row in
            XCTAssert(type(of: row) == type(of: expected[index]))
            XCTAssertEqual(row.asString(), expected[index].asString())
        }
    }
    
    func testReadFromURL_whenDataHasPropertyRow() async throws {
        // GIVEN
        handler = .init(fileManager: XCConfigFileManagerMock(
            fileExists: true,
            isWritableFile: true,
            contents: .Seeds.Rows.propertyWithNewLine
        ))
        
        // WHEN
        result = try await handler.read(fromURL: url)
        
        // THEN
        expected = [XCConfigRowProperty(
            key: .Constants.propertyKey,
            value: .Constants.propertyValue
        )]

        XCTAssertEqual(result.count, expected.count)
        
        result.enumerated().forEach { index, row in
            XCTAssert(type(of: row) == type(of: expected[index]))
            XCTAssertEqual(row.asString(), expected[index].asString())
        }
    }
    
    func testReadFromURL_whenDataHasMultipleRows() async throws {
        // GIVEN
        handler = .init(fileManager: XCConfigFileManagerMock(
            fileExists: true,
            isWritableFile: true,
            contents: .Seeds.Rows.multipleLinesWithNewLines
        ))
        
        // WHEN
        result = try await handler.read(fromURL: url)
        
        // THEN
        expected = [
            XCConfigRowComment(text: .Constants.comment),
            XCConfigRowEmpty(),
            XCConfigRowInclude(file: .Constants.file),
            XCConfigRowEmpty(),
            XCConfigRowProperty(
                key: .Constants.propertyKey,
                value: .Constants.propertyValue
            )
        ]
        
        XCTAssertEqual(result.count, expected.count)
        
        result.enumerated().forEach { index, row in
            XCTAssert(type(of: row) == type(of: expected[index]))
            XCTAssertEqual(row.asString(), expected[index].asString())
        }
    }
    
    func testReadFromURL_whenDataIsNil() async throws {
        // GIVEN
        handler = .init(fileManager: XCConfigFileManagerMock(
            fileExists: true,
            isWritableFile: true,
            contents: nil
        ))
        
        // WHEN & THEN
        do {
            result = try await handler.read(fromURL: url)
        } catch XCConfigHandlerError.dataNotRetrieved {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func testReadFromURL_whenDataIsEmpty() async throws {
        // GIVEN
        handler = .init(fileManager: XCConfigFileManagerMock(
            fileExists: true,
            isWritableFile: true,
            contents: .Seeds.Contents.none
        ))
        
        // WHEN & THEN
        do {
            result = try await handler.read(fromURL: url)
        } catch XCConfigHandlerError.dataIsEmpty {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
}

// MARK: - String+Constants

private extension String {
    
    enum Constants {
        static let comment = "// Something goes here..."
        static let file = "../folder/something.xcconfig"
        static let propertyKey = "SOME_KEY"
        static let propertyValue = "SOME_VALUE"
    }
    
}
