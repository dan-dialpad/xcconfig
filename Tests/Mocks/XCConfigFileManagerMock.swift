//
//  XCConfigFileManagerMock.swift
//  XCConfigTests
//
//  Created by Javier Cicchelli on 03/10/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

import Foundation

@testable import XCConfig

struct XCConfigFileManagerMock {
    
    // MARK: Properties
    
    private let fileExists: Bool?
    private let isWritableFile: Bool?
    private let contents: Data?
    private let removeItem: Bool?
    private let createFile: Bool?

    // MARK: Life cycle
    
    init(
        fileExists: Bool? = nil,
        isWritableFile: Bool? = nil,
        contents: Data? = nil,
        removeItem: Bool? = nil,
        createFile: Bool? = nil
    ) {
        self.fileExists = fileExists
        self.isWritableFile = isWritableFile
        self.contents = contents
        self.removeItem = removeItem
        self.createFile = createFile
    }
    
}

// MARK: - XCConfigFileManager

extension XCConfigFileManagerMock: XCConfigFileManager {

    // MARK: Functions
    
    func fileExists(atPath: String) -> Bool {
        guard let fileExists else {
            assertionFailure("The property `fileExists` should have been defined")
            return false
        }
        
        return fileExists
    }
    
    func isWritableFile(atPath: String) -> Bool {
        guard let isWritableFile else {
            assertionFailure("The property `isWritableFile` should have been defined")
            return false
        }
        
        return isWritableFile
    }
    
    func contents(atPath: String) -> Data? {
        guard let contents else { return nil }
        
        return contents
    }
    
    func removeItem(atPath: String) throws {
        guard let removeItem else {
            assertionFailure("The property `removeItem` should have been defined")
            return
        }

        guard removeItem else { throw NSError(domain: .empty, code: 0) }
    }
    
    func createFile(
        atPath: String,
        contents: Data?,
        attributes: [FileAttributeKey : Any]?
    ) -> Bool {
        guard let createFile else {
            assertionFailure("The property `createFile` should have been defined")
            return false
        }
        
        return createFile
    }
    
}
