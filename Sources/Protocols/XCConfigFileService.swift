//
//  XCConfigFileService.swift
//  XCConfig
//
//  Created by Javier Cicchelli on 23/10/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

import Foundation

public protocol XCConfigFileService {
    
    // MARK: Functions
    
    func read(fromURL url: URL) async throws -> [any XCConfigRow]
    func write(rows: [any XCConfigRow], toURL url: URL) async throws
    
}
