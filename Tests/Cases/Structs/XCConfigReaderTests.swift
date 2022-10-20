//
//  XCConfigReaderTests.swift
//  XCConfigTests
//
//  Created by Javier Cicchelli on 02/10/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

import XCTest

@testable import XCConfig

final class XCConfigReaderTests: XCTestCase {
    
    // MARK: Constants
    
    private let read = XCConfigReader()

    // MARK: Properties

    private var data: Data!
    private var result: [String]!
    
    // MARK: Read data tests
    
    func testReadData_whenNoContents() async throws {
        // GIVEN
        data = Contents.none
        
        // WHEN & THEN
        do {
            result = try await read(data)
        } catch XCConfigReaderError.dataNotConvertedToStrings {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func testReadData_whenContentIsEmpty() async throws {
        // GIVEN
        data = Contents.empty
        
        // WHEN
        result = try await read(data)
        
        // THEN
        XCTAssertTrue(result.isEmpty)
        XCTAssertEqual(result, [])
    }
    
    func testReadData_whenContentHasNewline() async throws {
        // GIVEN
        data = Contents.newline
        
        let row = Rows.newline
        
        // WHEN
        result = try await read(data)
        
        // THEN
        XCTAssertFalse(result.isEmpty)
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result, [row])
    }
    
    func testReadData_whenContentHasOneRow() async throws {
        // GIVEN
        data = Contents.oneLine
        
        let row = Rows.oneLineWithNewline
        
        // WHEN
        result = try await read(data)
        
        // THEN
        XCTAssertFalse(result.isEmpty)
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result, [row])
    }
    
    func testReadData_whenContentHasOneRowWithNewline() async throws {
        // GIVEN
        data = Contents.oneLineWithNewline
        
        let row = Rows.oneLineWithNewline
        
        // WHEN
        result = try await read(data)
        
        // THEN
        XCTAssertFalse(result.isEmpty)
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result, [row])
    }
    
    func testReadData_whenContentHasMultipleRows() async throws {
        // GIVEN
        data = Contents.multipleLines
        
        let row = Rows.oneLineWithNewline
        
        // WHEN
        result = try await read(data)
        
        // THEN
        XCTAssertFalse(result.isEmpty)
        XCTAssertEqual(result.count, 3)
        XCTAssertEqual(result, [row, row, row])
    }

}

// MARK: - Helpers

private extension XCConfigReaderTests {
    
    // MARK: Type aliases
    
    typealias Rows = String.Seeds.Rows
    typealias Contents = Data.Seeds.Contents
    
}
