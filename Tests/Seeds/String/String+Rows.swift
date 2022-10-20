//
//  String+Rows.swift
//  XCConfigTests
//
//  Created by Javier Cicchelli on 27/09/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

extension String.Seeds {
    
    enum Rows {
        
        static let none = ""
        static let newline = "\n"
        static let oneLine = "This is just a simple line..."
        static let oneLineWithNewline = "This is just a simple line...\n"
        static let multipleLines = Array(repeating: oneLineWithNewline, count: 3).joined()
        
        // MARK: Empty
        
        enum Empty {
            // MARK: Correct
            static let withNewline = "\n"
            static let withOneSpaceAndNewline = " \n"
            static let withMultipleSpacesAndNewline = "          \n"
            
            // MARK: Incorrect
            static let withOneSpace = " "
            static let withNewlineAndOneSpace = "\n "
            static let withNewlineAndMultipleSpaces = "\n          "
        }
        
        // MARK: Comment
        
        enum Comment {
            // MARK: Correct
            static let withTwoSlashesAndNoSpace = "//Something goes here...\n"
            static let withMultipleSlashesAndNoSpace = "///Something goes here...\n"
            static let withTwoSlashesAndOneSpace = "// Something goes here...\n"
            static let withMultipleSlashesAndOneSpace = "///// Something goes here...\n"
            static let withTwoSlashesAndMultipleSpaces = "//       Something goes here...\n"
            static let withMultipleSlashesAndMultipleSpaces = "/////   Something goes here...\n"
            
            // MARK: Incorrect
            static let withOneSlashAndNoSpace = "/\n"
            static let withOneSlashAndOneSpace = "/ \n"
            static let withOneSlashAndMultipleSpaces = "/       \n"
            static let withTwoSlashesNoSpaceAndNoText = "//\n"
            static let withTwoSlashesOneSpaceAndNoText = "// \n"
            static let withTwoSlashesMultipleSpacesAndNoText = "//       \n"
            static let withMultipleSlashesNoSpaceAndNoText = "/////\n"
            static let withMultipleSlashesOneSpaceAndNoText = "///// \n"
            static let withMultipleSlashesAndMultipleSpacesAndNoText = "/////       \n"
        }
        
        // MARK: Include
        
        enum Include {
            // MARK: Correct
            static let withFileInSameFolderAndExtension = "#include \"something.xcconfig\"\n"
            static let withFileInParentFolderAndExtension = "#include \"../something.xcconfig\"\n"
            static let withFileInOtherFolderAndExtension = "#include \"../folder/something.xcconfig\"\n"
            
            // MARK: Incorrect
            static let withFileInSameFolderAndNoExtension = "#include \"something\"\n"
            static let withFileInParentFolderAndNoExtension = "#include \"../something\"\n"
            static let withFileInOtherFolderAndNoExtension = "#include \"../folder/something\"\n"
            static let withNoNewline = "#include \"something.xcconfig\""
            static let withNoDoubleQuotes = "#include something.xcconfig"
            static let withMisspelledInclude = "#inclde \"something.xcconfig\"\n"
            static let withNoHashtag = "include \"something.xcconfig\"\n"
        }
        
        // MARK: Property
        
        enum Property {
            // MARK: Correct
            static let withNoSpace = "SOME_KEY=SOME_VALUE\n"
            static let withOneSpace = "SOME_KEY = SOME_VALUE\n"
            static let withMultipleSpaces = "     SOME_KEY     =     SOME_VALUE     \n"
            
            // MARK: Incorrect
            static let withNoNewline = "SOME_KEY = SOME_VALUE"
            static let withNoKey = "=SOME_VALUE\n"
            static let withNoValue = "SOME_KEY=\n"
            static let withNoKeyNorValue = "=\n"
            static let withNoEqual = "SOME_KEY SOME_VALUE\n"
        }
        
    }
    
}
