//
//  XCConfigRowComment.swift
//  XCConfig
//
//  Created by Javier Cicchelli on 15/10/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

public struct XCConfigRowComment {
    let text: String
}

// MARK: - XCConfigRowType

extension XCConfigRowComment: XCConfigRow {
    
    // MARK: Functions
    
    public func asString() -> String {
        text
    }
    
}
