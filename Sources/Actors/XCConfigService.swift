//
//  XCConfigService.swift
//  XCConfig
//
//  Created by Javier Cicchelli on 24/09/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

import Foundation

public actor XCConfigService {
    
    // MARK: Properties
    
    private let handler: XCConfigFileHandler
    
    // MARK: Initialisers
    
    public init() {
        self.handler = XCConfigHandler()
    }
    
    // MARK: Functions
    
    public func read(fromURL url: URL) async throws -> [any XCConfigRow] {
        try await handler.verify(url: url)
        return try await handler.read(fromURL: url)
    }
    
    public func write(rows: [any XCConfigRow], toURL url: URL) async throws {
        try await handler.verify(url: url)
        try await handler.write(rows: rows, toURL: url)
    }

}
