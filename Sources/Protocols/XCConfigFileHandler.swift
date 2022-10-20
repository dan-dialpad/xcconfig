//
//  XCConfigFileHandler.swift
//  XCConfig
//
//  Created by Javier Cicchelli on 02/10/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

import Foundation

protocol XCConfigFileHandler {

    // MARK: Functions
    
    @discardableResult func verify(url: URL) async throws -> Bool
    func read(fromURL url: URL) async throws -> [any XCConfigRow]
    func write(rows: [any XCConfigRow], toURL url: URL) async throws
    
}
