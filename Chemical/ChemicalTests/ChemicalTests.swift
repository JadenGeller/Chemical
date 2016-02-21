//
//  ChemicalTests.swift
//  ChemicalTests
//
//  Created by Jaden Geller on 2/20/16.
//  Copyright © 2016 Jaden Geller. All rights reserved.
//

import XCTest
@testable import Chemical
import Stochastic
import Handbag

class ChemicalTests: XCTestCase {
    
    func testReaction() {
        var system = StochasticSystem(molecules: Array(Repeat(count: 100, repeatedValue: true) + [false]))
        let stabilizationBehavior = Behavior(
            Reaction(reactants: [true, true], products: [true, false]),
            Reaction(reactants: [false,  false], products: [false, true])
        )
        system.simulate(stabilizationBehavior, stopping: .whenStable(streakLength: 500, absoluteTolerance: 1))
        let sum = system.molecules.filter{ $0 }.count
        XCTAssertGreaterThan(58, sum)
        XCTAssertLessThan(42, sum)
    }
    
    func testRateConstants() {
        var system = StochasticSystem(molecules: Array(Repeat(count: 100, repeatedValue: true) + [false]))
        let stabilizationBehavior = Behavior(
            Reaction(reactants: [true, true], products: [true, false], rate: 100),
            Reaction(reactants: [false,  false], products: [false, true], rate: 1)
        )
        system.simulate(stabilizationBehavior, stopping: .whenStable(streakLength: 500, absoluteTolerance: 1))
        let sum = system.molecules.filter{ $0 }.count
        XCTAssertGreaterThan(15, sum)
        XCTAssertLessThan(5, sum)
    }
}
