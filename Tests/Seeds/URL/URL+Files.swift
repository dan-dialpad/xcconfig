//
//  URL+Files.swift
//  XCConfigTests
//
//  Created by Javier Cicchelli on 03/10/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

import Foundation

extension URL.Seeds {
    
    enum Files {
        static let xcconfig = URL(fileURLWithPath: "/path/to/file.xcconfig")
        static let other = URL(fileURLWithPath: "/path/to/file.other")
        static let withoutExtension = URL(fileURLWithPath: "/path/to/file")
    }
    
    enum Directory {
        static let `default` = URL(fileURLWithPath: "/path/to/directory")
    }
    
    enum Network {
        static let https = URL(string: "https://www.something.com")
    }
    
}
