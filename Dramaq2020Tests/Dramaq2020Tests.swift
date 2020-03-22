//
//  Dramaq2020Tests.swift
//  Dramaq2020Tests
//
//  Created by Петрос Тепоян on 5/3/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import RealmSwift

import XCTest
@testable import Dramaq2020

class Dramaq2020Tests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            
            _ = HomeController()
            
            // Put the code you want to measure the time of here.
        }
    }

}
