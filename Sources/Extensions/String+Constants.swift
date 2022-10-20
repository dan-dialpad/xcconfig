//
//  String+Constants.swift
//  XCConfig
//
//  Created by Javier Cicchelli on 02/10/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

extension String {
    static let empty = ""
    static let space = String(Character.space)
    static let newline = String(Character.newline)
}

// MARK: - Character+Constants

private extension Character {
    static let space = Character(" ")
    static let newline = Character("\n")
}
