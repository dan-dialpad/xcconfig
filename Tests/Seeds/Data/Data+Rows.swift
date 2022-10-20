//
//  Data+Rows.swift
//  XCConfigTests
//
//  Created by Javier Cicchelli on 02/10/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

import Foundation

extension Data.Seeds {

    enum Rows {
        static let emptyWithNewline = Rows.Empty.withNewline.data(using: .utf8)!
        static let commentWithNewline = Rows.Comment.withTwoSlashesAndOneSpace.data(using: .utf8)!
        static let includeWithNewline = Rows.Include.withFileInOtherFolderAndExtension.data(using: .utf8)!
        static let propertyWithNewLine = Rows.Property.withOneSpace.data(using: .utf8)!
        static let multipleLinesWithNewLines = """
        // Something goes here...
        
        #include "../folder/something.xcconfig"
        
        SOME_KEY = SOME_VALUE
        
        """.data(using: .utf8)!
    }
    
}

// MARK: - Helpers

private extension Data.Seeds.Rows {
    
    // MARK: Type aliases
    
    typealias Rows = String.Seeds.Rows
    
}
