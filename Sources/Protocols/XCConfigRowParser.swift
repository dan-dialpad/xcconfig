//
//  XCConfigRowParser.swift
//  XCConfig
//
//  Created by Javier Cicchelli on 25/09/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

protocol XCConfigRowParser {

    // MARK: Functions
    
    func callAsFunction(_ row: String) async throws -> any XCConfigRow
    
}
