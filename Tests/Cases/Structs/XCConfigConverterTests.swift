//
//  XCConfigConverterTests.swift
//  XCConfigTests
//
//  Created by Javier Cicchelli on 02/10/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

import XCTest
import Foundation

@testable import XCConfig

final class XCConfigConverterTests: XCTestCase {
    
    // MARK: Constants
    
    private let convert = XCConfigConverter()
    
    // MARK: Properties
    
    private var rows: [any XCConfigRow]!
    private var result: Data!
    
    // MARK: Convert rows tests

    func testConvertRows_whenEmpty() async throws {
        // GIVEN
        rows = []
        
        // WHEN & THEN
        do {
            _ = try await convert(rows)
        } catch XCConfigConverterError.rowsNotProvided {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func testConvertRows_whenHasOneEmptyRow() async throws {
        // GIVEN
        rows = [XCConfigRowEmpty()]
        
        // WHEN
        result = try await convert(rows)
        
        // THEN
        XCTAssertEqual(result, .Seeds.Rows.emptyWithNewline)
    }
    
    func testConvertRows_whenHasOneCommentRow() async throws {
        // GIVEN
        rows = [XCConfigRowComment(text: "// Something goes here...")]
        
        // WHEN
        result = try await convert(rows)
        
        // THEN
        XCTAssertEqual(result, .Seeds.Rows.commentWithNewline)
    }
    
    func testConvertRows_whenHasOneIncludeRow() async throws {
        // GIVEN
        rows = [XCConfigRowInclude(file: "../folder/something.xcconfig")]
        
        // WHEN
        result = try await convert(rows)
        
        // THEN
        XCTAssertEqual(result, .Seeds.Rows.includeWithNewline)
    }
    
    func testConvertRows_whenHasOnePropertyRow() async throws {
        // GIVEN
        rows = [XCConfigRowProperty(key: "SOME_KEY", value: "SOME_VALUE")]
        
        // WHEN
        result = try await convert(rows)
        
        // THEN
        XCTAssertEqual(result, .Seeds.Rows.propertyWithNewLine)
    }
    
    func testConvertRows_whenHasMultipleRows() async throws {
        // GIVEN
        rows = [
            XCConfigRowComment(text: "// Something goes here..."),
            XCConfigRowEmpty(),
            XCConfigRowInclude(file: "../folder/something.xcconfig"),
            XCConfigRowEmpty(),
            XCConfigRowProperty(key: "SOME_KEY", value: "SOME_VALUE")
        ]
        
        // WHEN
        result = try await convert(rows)
        
        // THEN
        XCTAssertEqual(result, .Seeds.Rows.multipleLinesWithNewLines)
    }

}
