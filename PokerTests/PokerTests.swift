//
//  PokerTests.swift
//  PokerTests
//
//  Created by Sergey Klimov on 4/22/15.
//  Copyright (c) 2015 Sergey Klimov. All rights reserved.
//

import UIKit
import XCTest
import Poker

class PokerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDeck() {
        // This is an example of a functional test case.
        var pokerDeck = Poker.GameEngine.pokerDeck()
        println("Deck: |\(pokerDeck)|")
        XCTAssertEqual(pokerDeck.count, 52, "Should be proper desc")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
