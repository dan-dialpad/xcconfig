//
//  XCConfigParser.swift
//  XCConfig
//
//  Created by Javier Cicchelli on 25/09/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

import RegexBuilder

struct XCConfigParser {}

// MARK: - XCConfig

extension XCConfigParser: XCConfigRowParser {

    // MARK: Functions
    
    func callAsFunction(_ row: String) async throws -> any XCConfigRow {
        if let _ = row.wholeMatch(of: RegularExpressions.emptyRow)?.output {
            return XCConfigRowEmpty()
        } else if let (_, comment) = row.wholeMatch(of: RegularExpressions.commentRow)?.output {
            return XCConfigRowComment(text: comment)
        } else if let (_, file) = row.wholeMatch(of: RegularExpressions.includeRow)?.output {
            return XCConfigRowInclude(file: file)
        } else if let (_, key, value) = row.wholeMatch(of: RegularExpressions.propertyRow)?.output {
            return XCConfigRowProperty(key: key, value: value)
        } else {
            throw XCConfigParserError.patternNotRecognized
        }
    }
}

// MARK: - Errors

enum XCConfigParserError: Error {
    case patternNotRecognized
}

// MARK: - Regular expressions

private extension XCConfigParser {
    enum RegularExpressions {
        static let emptyRow = Regex {
            Optionally(OneOrMore(.whitespace, .reluctant))
            One(.newlineSequence)
        }
        
        static let commentRow = Regex {
            Capture {
                One("/")
                OneOrMore("/")
                Optionally(One(.whitespace))
                OneOrMore(.anyNonNewline)
            } transform: {
                String($0)
            }
            One(.newlineSequence)
        }
        
        static let includeRow = Regex {
            One("#include")
            One(.whitespace)
            One("\"")
            Capture {
                OneOrMore(.anyNonNewline)
                One(".xcconfig")
            } transform: {
                String($0)
            }
            One("\"")
            One(.newlineSequence)
        }
        
        static let propertyRow = Regex {
            Optionally(OneOrMore(.whitespace))
            Capture {
                OneOrMore(.anyNonNewline, .reluctant)
            } transform: {
                String($0)
            }
            Optionally(OneOrMore(.whitespace))
            One("=")
            Optionally(OneOrMore(.whitespace))
            Capture {
                OneOrMore(.anyNonNewline, .reluctant)
            } transform: {
                String($0)
            }
            Optionally(OneOrMore(.whitespace))
            One(.newlineSequence)
        }
    }
}
