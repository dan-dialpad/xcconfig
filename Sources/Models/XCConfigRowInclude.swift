//
//  XCConfigRowInclude.swift
//  XCConfig
//
//  Created by Javier Cicchelli on 15/10/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

public struct XCConfigRowInclude {
    let file: String
}

// MARK: - XCConfigRowType

extension XCConfigRowInclude: XCConfigRow {
    
    // MARK: Functions
    
    public func asString() -> String {
        .init(format: .Formats.include, file)
    }
    
}

// MARK: - String+Format

private extension String {
    
    enum Formats {
        static let include = "#include \"%@\""
    }

}
