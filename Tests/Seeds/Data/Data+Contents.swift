//
//  Data+Contents.swift
//  XCConfigTests
//
//  Created by Javier Cicchelli on 02/10/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

import Foundation

extension Data.Seeds {

    enum Contents {
        static let none = Data()
        static let empty = Rows.none.data(using: .utf8)!
        static let newline = Rows.newline.data(using: .utf8)!
        static let oneLine = Rows.oneLine.data(using: .utf8)!
        static let oneLineWithNewline = Rows.oneLineWithNewline.data(using: .utf8)!
        static let multipleLines = Rows.multipleLines.data(using: .utf8)!
    }
    
}

// MARK: - Helpers

private extension Data.Seeds.Contents {
    
    // MARK: Type aliases
    
    typealias Rows = String.Seeds.Rows
    
}
