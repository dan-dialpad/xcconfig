//
//  XCConfigDataConverter.swift
//  XCConfig
//
//  Created by Javier Cicchelli on 02/10/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

import Foundation

protocol XCConfigDataConverter {

    // MARK: Functions
    
    func callAsFunction(_ rows: [any XCConfigRow]) async throws -> Data
    
}
