//
//  XCConfigHandler+VerifyTests.swift
//  XCConfigTests
//
//  Created by Javier Cicchelli on 03/10/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

import XCTest
import Foundation

@testable import XCConfig

final class XCConfigHandlerVerifyTests: XCTestCase {
    
    // MARK: Properties
    
    private var url: URL!
    private var handler: XCConfigHandler!
    
    private var result: Bool!

    // MARK: Verify URL tests

    func testVerifyURL_whenIsXCConfigFile_thenFileExists_andFileWritable() async throws {
        // GIVEN
        url = .Seeds.Files.xcconfig
        handler = .init(
            fileManager: XCConfigFileManagerMock(
                fileExists: true,
                isWritableFile: true
            )
        )
        
        // WHEN
        result = try await handler.verify(url: url)
        
        // THEN
        XCTAssertTrue(result)
    }
    
    func testVerifyURL_whenIsNotFile() async throws {
        // GIVEN
        url = .Seeds.Network.https
        handler = .init(
            fileManager: XCConfigFileManagerMock(
                fileExists: true,
                isWritableFile: true
            )
        )
        
        // WHEN & THEN
        do {
            result = try await handler.verify(url: url)
        } catch XCConfigHandlerError.urlNotFile {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func testVerifyURL_whenIsDirectory() async throws {
        // GIVEN
        url = .Seeds.Directory.default
        handler = .init(
            fileManager: XCConfigFileManagerMock(
                fileExists: true,
                isWritableFile: true
            )
        )
        
        // WHEN & THEN
        do {
            result = try await handler.verify(url: url)
        } catch XCConfigHandlerError.urlPathNotXCConfig {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func testVerifyURL_whenIsNotXCConfigFile() async throws {
        // GIVEN
        url = .Seeds.Files.other
        handler = .init(
            fileManager: XCConfigFileManagerMock(
                fileExists: true,
                isWritableFile: true
            )
        )
        
        // WHEN & THEN
        do {
            result = try await handler.verify(url: url)
        } catch XCConfigHandlerError.urlPathNotXCConfig {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func testVerifyURL_whenFileNotExists() async throws {
        // GIVEN
        url = .Seeds.Files.xcconfig
        handler = .init(
            fileManager: XCConfigFileManagerMock(
                fileExists: false,
                isWritableFile: true
            )
        )
        
        // WHEN & THEN
        do {
            result = try await handler.verify(url: url)
        } catch XCConfigHandlerError.urlPathNotFound {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    
    
    func testVerifyURL_whenFileNotWritable() async throws {
        // GIVEN
        url = .Seeds.Files.xcconfig
        handler = .init(
            fileManager: XCConfigFileManagerMock(
                fileExists: true,
                isWritableFile: false
            )
        )
        
        // WHEN & THEN
        do {
            result = try await handler.verify(url: url)
        } catch XCConfigHandlerError.urlPathNotWritable {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }

}
