//
//  XCConfigRowProperty.swift
//  XCConfig
//
//  Created by Javier Cicchelli on 15/10/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

public struct XCConfigRowProperty {
    public let key: String
    public let value: String

    public init(key: String, value: String) {
        self.key = key
        self.value = value
    }
}

// MARK: - XCConfigRowType

extension XCConfigRowProperty: XCConfigRow {
    
    // MARK: Functions
    
    public func asString() -> String {
        .init(format: .Formats.property, key, value)
    }
    
}

// MARK: - String+Format

private extension String {
    
    enum Formats {
        static let property = "%@ = %@"
    }
    
}
