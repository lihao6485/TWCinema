//
//  ConfigurationStorageTests.swift
//  TWCinemaTests
//
//  Created by Li Hao Lai on 13/9/18.
//  Copyright © 2018 Li Hao Lai. All rights reserved.
//

import XCTest
import RxSwift
@testable import TWCinema

class ConfigurationStorageTests: XCTestCase {

    func testConfigurationFileLoaded() {
        do {
            let disposeBag = DisposeBag()
            let configuration = try ConfigurationStorage().configuration()
            let expect = expectation(description: "equal")

            configuration.subscribe(onSuccess: { config in
                if config.apiKey == "5d0d27b4a1c9f83be70c6d110c345f83" {
                    expect.fulfill()
                }
            }).disposed(by: disposeBag)

            waitForExpectations(timeout: 1) { (error) in
                XCTAssertNil(error)
            }

        } catch {
            XCTFail("Unexpected error occurred")
        }
    }

    func testConfigurationFileMissing() {
        do {
            _ = try ConfigurationStorage(
                file: "MissingFile",
                ofType: "Any",
                inBundle: Bundle(for: ConfigurationStorageTests.self))
            XCTFail("Initialization expected to fail")
        } catch {
            switch error {
            case ConfigurationError.missing:
                XCTAssertTrue(true)
            default:
                XCTFail("Unexpected error occurred")
            }
        }
    }

}
