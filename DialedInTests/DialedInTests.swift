//
//  DialedInTests.swift
//  DialedInTests
//
//  Created by Jason Hilimire on 1/26/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//


import XCTest
import SwiftUI
@testable import Dialed_In

class DialedInTests: XCTestCase {
    
    let bike = Bike()
    let frontSetup = NoteFrontSetupViewModel()
    let rearSetup = NoteRearSetupViewModel()
    let forkVM = ForkViewModel()
    let rearVM = RearShockViewModel()
    let noteVM = NoteViewModel()
    let bikeVM = BikeViewModel()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
       
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCalcSag() {
        let sag = 25.0
        let travel = 100.0
        let sut = calcSag(sag: sag, travel: travel)
        XCTAssertEqual(sut, 25.0)
    }
    
    func testCalcSag_stringConversion() {
        let sag = 25.0
        let travel = 100.0
        let sut = calcSagString(sag: sag, travel: travel)
        XCTAssertEqual(sut, "Sag %: 25.0")
    }
    
    func testCalcSag_stringConversion_noSetup() {
        let sag = 25.0
        let travel = 0.0
        let sut = calcSagString(sag: sag, travel: travel)
        XCTAssertEqual(sut, "Sag %: N/A")
    }
    
    func testCalcSag_stringConversion_badValue() {
        let sag = 25.0
        let travel = 10000.0
        let sut = calcSagString(sag: sag, travel: travel)
        XCTAssertEqual(sut, "Sag %: N/A")
    }
    
    
    
}
 
