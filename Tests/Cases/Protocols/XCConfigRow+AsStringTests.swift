//
//  XCConfigRow+AsStringTests.swift
//  XCConfigTests
//
//  Created by Javier Cicchelli on 02/10/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

import XCTest

@testable import XCConfig

final class XCConfigRowAsStringTests: XCTestCase {
    
    // MARK: Properties
    
    private var row: (any XCConfigRow)!
    private var result: String!
    
    // MARK: AsString tests
    
    func test_whenEmptyRow() throws {
        // GIVEN
        row = XCConfigRowEmpty()
        
        // WHEN
        result = row.asString()
        
        // THEN
        XCTAssertEqual(result, .empty)
    }
    
    func test_whenCommentRow() throws {
        // GIVEN
        let comment = "// Some comment goes in here... "
        
        row = XCConfigRowComment(text: comment)
        
        // WHEN
        result = row.asString()
        
        // THEN
        XCTAssertEqual(result, comment)
    }
    
    func test_whenIncludeRow() throws {
        // GIVEN
        let file = "../some_folder/some_file.some_extension"
        
        row = XCConfigRowInclude(file: file)
        
        // WHEN
        result = row.asString()
        
        // THEN
        XCTAssertEqual(result, "#include \"\(file)\"")
    }
    
    func test_whenPropertyRow() throws {
        // GIVEN
        let key = "SOME_KEY"
        let value = "SOME_VALUE"
        
        row = XCConfigRowProperty(
            key: key,
            value: value
        )
        
        // WHEN
        result = row.asString()
        
        // THEN
        XCTAssertEqual(result, "\(key) = \(value)")
    }
    
}
