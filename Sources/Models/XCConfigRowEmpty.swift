//
//  XCConfigRowEmpty.swift
//  XCConfig
//
//  Created by Javier Cicchelli on 13/10/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

public struct XCConfigRowEmpty {}

// MARK: - XCConfigRowType

extension XCConfigRowEmpty: XCConfigRow {
    
    // MARK: Functions
    
    public func asString() -> String {
        .empty
    }
    
}
