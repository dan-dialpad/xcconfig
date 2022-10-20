//
//  XCConfigParserTests.swift
//  XCConfigTests
//
//  Created by Javier Cicchelli on 27/09/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

import XCTest

@testable import XCConfig

final class XCConfigParserTests: XCTestCase {
    
    // MARK: Constants
    
    private let parse = XCConfigParser()
    
    // MARK: Properties
    
    private var row: String!
    private var result: (any XCConfigRow)!
    private var expected: (any XCConfigRow)!
    
    // MARK: Empty row tests
    
    func testParseRow_withEmptyRow_whenHasNewline() async throws {
        // GIVEN
        row = Row.Empty.withNewline
        
        // WHEN
        result = try await parse(row)

        // THEN
        expected = XCConfigRowEmpty()
        
        XCTAssert(type(of: result) == type(of: expected))
        XCTAssertEqual(result.asString(), expected.asString())
    }
    
    func testParseRow_withEmptyRow_whenHasOneSpaceAndNewline() async throws {
        // GIVEN
        row = Row.Empty.withOneSpaceAndNewline
        
        // WHEN
        result = try await parse(row)

        // THEN
        expected = XCConfigRowEmpty()
        
        XCTAssert(type(of: result) == type(of: expected))
        XCTAssertEqual(result.asString(), expected.asString())
    }
    
    func testParseRow_withEmptyRow_whenHasMultipleSpacesAndNewline() async throws {
        // GIVEN
        row = Row.Empty.withMultipleSpacesAndNewline
        
        // WHEN
        result = try await parse(row)

        // THEN
        expected = XCConfigRowEmpty()
        
        XCTAssert(type(of: result) == type(of: expected))
        XCTAssertEqual(result.asString(), expected.asString())
    }
    
    func testParseRow_withEmptyRow_whenHasOneSpace() async throws {
        // GIVEN
        row = Row.Empty.withOneSpace
        
        // WHEN & THEN
        do {
            _ = try await parse(row)
        } catch XCConfigParserError.patternNotRecognized {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func testParseRow_withEmptyRow_whenHasNewlineAndOneSpace() async throws {
        // GIVEN
        row = Row.Empty.withNewlineAndOneSpace
        
        // WHEN & THEN
        do {
            _ = try await parse(row)
        } catch XCConfigParserError.patternNotRecognized {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func testParseRow_withEmptyRow_whenHasNewlineAndMultipleSpaces() async throws {
        // GIVEN
        row = Row.Empty.withNewlineAndMultipleSpaces
        
        // WHEN & THEN
        do {
            _ = try await parse(row)
        } catch XCConfigParserError.patternNotRecognized {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    // MARK: Comment row tests
    
    func testParseRow_withCommentRow_whenHasTwoSlashesAndNoSpace() async throws {
        // GIVEN
        row = Row.Comment.withTwoSlashesAndNoSpace

        // WHEN
        result = try await parse(row)

        // THEN
        expected = XCConfigRowComment(
            text: row.replacing(.newlineSequence, with: "")
        )
        
        XCTAssert(type(of: result) == type(of: expected))
        XCTAssertEqual(result.asString(), expected.asString())
    }
    
    func testParseRow_withCommentRow_whenHasMultipleSlashesAndNoSpace() async throws {
        // GIVEN
        row = Row.Comment.withMultipleSlashesAndNoSpace
        
        // WHEN
        result = try await parse(row)

        // THEN
        expected = XCConfigRowComment(
            text: row.replacing(.newlineSequence, with: "")
        )
        
        XCTAssert(type(of: result) == type(of: expected))
        XCTAssertEqual(result.asString(), expected.asString())
    }
    
    func testParseRow_withCommentRow_whenHasTwoSlashesAndOneSpace() async throws {
        // GIVEN
        row = Row.Comment.withTwoSlashesAndOneSpace
        
        // WHEN
        result = try await parse(row)

        // THEN
        expected = XCConfigRowComment(
            text: row.replacing(.newlineSequence, with: "")
        )
        
        XCTAssert(type(of: result) == type(of: expected))
        XCTAssertEqual(result.asString(), expected.asString())
    }
    
    func testParseRow_withCommentRow_whenHasMultipleSlashesAndOneSpace() async throws {
        // GIVEN
        row = Row.Comment.withMultipleSlashesAndOneSpace
        
        // WHEN
        result = try await parse(row)

        // THEN
        expected = XCConfigRowComment(
            text: row.replacing(.newlineSequence, with: "")
        )
        
        XCTAssert(type(of: result) == type(of: expected))
        XCTAssertEqual(result.asString(), expected.asString())
    }
    
    func testParseRow_withCommentRow_whenHasTwoSlashesAndMultipleSpaces() async throws {
        // GIVEN
        row = Row.Comment.withTwoSlashesAndMultipleSpaces
        
        // WHEN
        result = try await parse(row)

        // THEN
        expected = XCConfigRowComment(
            text: row.replacing(.newlineSequence, with: "")
        )
        
        XCTAssert(type(of: result) == type(of: expected))
        XCTAssertEqual(result.asString(), expected.asString())
    }
    
    func testParseRow_withCommentRow_whenHasMultipleSlashesAndMultipleSpaces() async throws {
        // GIVEN
        row = Row.Comment.withMultipleSlashesAndMultipleSpaces
        
        // WHEN
        result = try await parse(row)
        
        // THEN
        expected = XCConfigRowComment(
            text: row.replacing(.newlineSequence, with: "")
        )
        
        XCTAssert(type(of: result) == type(of: expected))
        XCTAssertEqual(result.asString(), expected.asString())
    }
    
    func testParseRow_withCommentRow_whenHasOneSlashAndNoSpace() async throws {
        // GIVEN
        row = Row.Comment.withOneSlashAndNoSpace
        
        // WHEN & THEN
        do {
            _ = try await parse(row)
        } catch XCConfigParserError.patternNotRecognized {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func testParseRow_withCommentRow_whenHasOneSlashAndOneSpace() async throws {
        // GIVEN
        row = Row.Comment.withOneSlashAndOneSpace
        
        // WHEN & THEN
        do {
            _ = try await parse(row)
        } catch XCConfigParserError.patternNotRecognized {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func testParseRow_withCommentRow_whenHasOneSlashAndMultipleSpaces() async throws {
        // GIVEN
        row = Row.Comment.withOneSlashAndMultipleSpaces
        
        // WHEN & THEN
        do {
            _ = try await parse(row)
        } catch XCConfigParserError.patternNotRecognized {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func testParseRow_withCommentRow_whenHasTwoSlashesNoSpaceAndNoText() async throws {
        // GIVEN
        row = Row.Comment.withTwoSlashesNoSpaceAndNoText
        
        // WHEN & THEN
        do {
            _ = try await parse(row)
        } catch XCConfigParserError.patternNotRecognized {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func testParseRow_withCommentRow_whenHasTwoSlashesOneSpaceAndNoText() async throws {
        // GIVEN
        row = Row.Comment.withTwoSlashesOneSpaceAndNoText
        
        // WHEN & THEN
        do {
            _ = try await parse(row)
        } catch XCConfigParserError.patternNotRecognized {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func testParseRow_withCommentRow_whenHasTwoSlashesMultipleSpacesAndNoText() async throws {
        // GIVEN
        row = Row.Comment.withTwoSlashesMultipleSpacesAndNoText
        
        // WHEN & THEN
        do {
            _ = try await parse(row)
        } catch XCConfigParserError.patternNotRecognized {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func testParseRow_withCommentRow_whenHasMultipleSlashesNoSpaceAndNoText() async throws {
        // GIVEN
        row = Row.Comment.withMultipleSlashesNoSpaceAndNoText
        
        // WHEN & THEN
        do {
            _ = try await parse(row)
        } catch XCConfigParserError.patternNotRecognized {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func testParseRow_withCommentRow_whenHasMultipleSlashesOneSpaceAndNoText() async throws {
        // GIVEN
        row = Row.Comment.withMultipleSlashesOneSpaceAndNoText
        
        // WHEN & THEN
        do {
            _ = try await parse(row)
        } catch XCConfigParserError.patternNotRecognized {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func testParseRow_withCommentRow_whenHasMultipleSlashesMultipleSpacesAndNoText() async throws {
        // GIVEN
        row = Row.Comment.withMultipleSlashesAndMultipleSpacesAndNoText
        
        // WHEN & THEN
        do {
            _ = try await parse(row)
        } catch XCConfigParserError.patternNotRecognized {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }

    // MARK: Include row tests
    
    func testParseRow_withIncludeRow_whenFileInSameFolderAndExtension() async throws {
        // GIVEN
        row = Row.Include.withFileInSameFolderAndExtension
        
        // WHEN
        result = try await parse(row)

        // THEN
        expected = XCConfigRowInclude(file: "something.xcconfig")
        
        XCTAssert(type(of: result) == type(of: expected))
        XCTAssertEqual(result.asString(), expected.asString())
    }
    
    func testParseRow_withIncludeRow_whenFileInParentFolderAndExtension() async throws {
        // GIVEN
        row = Row.Include.withFileInParentFolderAndExtension

        // WHEN
        result = try await parse(row)
        
        // THEN
        expected = XCConfigRowInclude(file: "../something.xcconfig")
        
        XCTAssert(type(of: result) == type(of: expected))
        XCTAssertEqual(result.asString(), expected.asString())
    }
    
    func testParseRow_withIncludeRow_whenFileInOtherFolderAndExtension() async throws {
        // GIVEN
        row = Row.Include.withFileInOtherFolderAndExtension

        // WHEN
        result = try await parse(row)

        // THEN
        expected = XCConfigRowInclude(file: "../folder/something.xcconfig")
        
        XCTAssert(type(of: result) == type(of: expected))
        XCTAssertEqual(result.asString(), expected.asString())
    }
    
    func testParseRow_withIncludeRow_whenFileInSameFolderAndNoExtension() async throws {
        // GIVEN
        row = Row.Include.withFileInSameFolderAndNoExtension
        
        // WHEN & THEN
        do {
            _ = try await parse(row)
        } catch XCConfigParserError.patternNotRecognized {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func testParseRow_withIncludeRow_whenFileInParentFolderAndNoExtension() async throws {
        // GIVEN
        row = Row.Include.withFileInParentFolderAndNoExtension
        
        // WHEN & THEN
        do {
            _ = try await parse(row)
        } catch XCConfigParserError.patternNotRecognized {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func testParseRow_withIncludeRow_whenFileInOtherFolderAndNoExtension() async throws {
        // GIVEN
        row = Row.Include.withFileInOtherFolderAndNoExtension
        
        // WHEN & THEN
        do {
            _ = try await parse(row)
        } catch XCConfigParserError.patternNotRecognized {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func testParseRow_withIncludeRow_whenHasNoNewline() async throws {
        // GIVEN
        row = Row.Include.withNoNewline
        
        // WHEN & THEN
        do {
            _ = try await parse(row)
        } catch XCConfigParserError.patternNotRecognized {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func testParseRow_withIncludeRow_whenHasNoDoubleQuotes() async throws {
        // GIVEN
        row = Row.Include.withNoDoubleQuotes
        
        // WHEN & THEN
        do {
            _ = try await parse(row)
        } catch XCConfigParserError.patternNotRecognized {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func testParseRow_withIncludeRow_whenHasMispelledInclude() async throws {
        // GIVEN
        row = Row.Include.withMisspelledInclude
        
        // WHEN & THEN
        do {
            _ = try await parse(row)
        } catch XCConfigParserError.patternNotRecognized {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func testParseRow_withIncludeRow_whenHasNoHashtag() async throws {
        // GIVEN
        row = Row.Include.withNoHashtag
        
        // WHEN & THEN
        do {
            _ = try await parse(row)
        } catch XCConfigParserError.patternNotRecognized {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }

    // MARK: Property row tests
    
    func testParseRow_withPropertyRow_whenKeyAndValueHasNoSpace() async throws {
        // GIVEN
        row = Row.Property.withNoSpace
        
        // WHEN
        result = try await parse(row)

        // THEN
        expected = XCConfigRowProperty(
            key: "SOME_KEY",
            value: "SOME_VALUE"
        )
        
        XCTAssert(type(of: result) == type(of: expected))
        XCTAssertEqual(result.asString(), expected.asString())
    }
    
    func testParseRow_withPropertyRow_whenKeyAndValueHasOneSpace() async throws {
        // GIVEN
        row = Row.Property.withOneSpace
        
        // WHEN
        result = try await parse(row)

        // THEN
        expected = XCConfigRowProperty(
            key: "SOME_KEY",
            value: "SOME_VALUE"
        )
        
        XCTAssert(type(of: result) == type(of: expected))
        XCTAssertEqual(result.asString(), expected.asString())
    }
    
    func testParseRow_withPropertyRow_whenKeyAndValueHasMultipleSpaces() async throws {
        // GIVEN
        row = Row.Property.withMultipleSpaces
        
        // WHEN
        result = try await parse(row)

        // THEN
        expected = XCConfigRowProperty(
            key: "SOME_KEY",
            value: "SOME_VALUE"
        )
        
        XCTAssert(type(of: result) == type(of: expected))
        XCTAssertEqual(result.asString(), expected.asString())
    }
    
    func testParseRow_withPropertyRow_whenHasNoNewline() async throws {
        // GIVEN
        row = Row.Property.withNoNewline
        
        // WHEN & THEN
        do {
            _ = try await parse(row)
        } catch XCConfigParserError.patternNotRecognized {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func testParseRow_withPropertyRow_whenHasNoKey() async throws {
        // GIVEN
        row = Row.Property.withNoKey
        
        // WHEN & THEN
        do {
            _ = try await parse(row)
        } catch XCConfigParserError.patternNotRecognized {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func testParseRow_withPropertyRow_whenHasNoValue() async throws {
        // GIVEN
        row = Row.Property.withNoValue
        
        // WHEN & THEN
        do {
            _ = try await parse(row)
        } catch XCConfigParserError.patternNotRecognized {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func testParseRow_withPropertyRow_whenHasNoKeyNorValue() async throws {
        // GIVEN
        row = Row.Property.withNoKeyNorValue
        
        // WHEN & THEN
        do {
            _ = try await parse(row)
        } catch XCConfigParserError.patternNotRecognized {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func testParseRow_withPropertyRow_whenHasNoEqual() async throws {
        // GIVEN
        row = Row.Property.withNoEqual
        
        // WHEN & THEN
        do {
            _ = try await parse(row)
        } catch XCConfigParserError.patternNotRecognized {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }

    // MARK: Other tests
    
    func testParseRow_whenRowIsEmpty() async throws {
        // GIVEN
        row = Row.none
        
        // WHEN & THEN
        do {
            _ = try await parse(row)
        } catch XCConfigParserError.patternNotRecognized {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }

}

// MARK: - Helpers

private extension XCConfigParserTests {
    
    // MARK: Type aliases
    
    typealias Row = String.Seeds.Rows
    
}
