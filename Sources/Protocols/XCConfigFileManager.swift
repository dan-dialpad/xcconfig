//
//  XCConfigFileManager.swift
//  XCConfig
//
//  Created by Javier Cicchelli on 03/10/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

import Foundation

protocol XCConfigFileManager {
    
    // MARK: Functions
    
    func fileExists(atPath: String) -> Bool
    func isWritableFile(atPath: String) -> Bool
    func contents(atPath: String) -> Data?
    func removeItem(atPath: String) throws
    func createFile(
        atPath: String,
        contents: Data?,
        attributes: [FileAttributeKey: Any]?
    ) -> Bool
    
}
