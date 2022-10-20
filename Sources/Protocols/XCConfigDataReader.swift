//
//  XCConfigDataReader.swift
//  XCConfig
//
//  Created by Javier Cicchelli on 24/09/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

import Foundation

protocol XCConfigDataReader {
    
    // MARK: Functions
    
    func callAsFunction(_ data: Data) async throws -> [String]
    
}
