//
//  DiscoverNetworkTests.swift
//  TWCinemaTests
//
//  Created by Li Hao Lai on 18/9/18.
//  Copyright © 2018 Li Hao Lai. All rights reserved.
//

import XCTest
import Alamofire
import RxSwift
@testable import TWCinema

class DiscoverNetworkTests: XCTestCase {

    func testFetchDiscover() {
        do {
            let disposeBag = DisposeBag()
            let configurationStorage = try ConfigurationStorage()
            let discoverNetwork = DiscoverNetwork(sessionManager: Alamofire.SessionManager(),
                                                  configurationStorage: configurationStorage)
            let expect = expectation(description: "data fetched")

            discoverNetwork.makeDiscoverRequest(with: 1)
                .subscribe(onSuccess: { _ in
                    expect.fulfill()
                }).disposed(by: disposeBag)

            waitForExpectations(timeout: 1) { (error) in
                XCTAssertNil(error)
            }

        } catch {
            XCTFail("Unexpected error occurred")
        }
    }

}
