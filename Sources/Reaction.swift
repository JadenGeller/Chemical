//
//  Reaction.swift
//  Chemical
//
//  Created by Jaden Geller on 2/20/16.
//  Copyright © 2016 Jaden Geller. All rights reserved.
//

import Handbag
import Stochastic
import Orderly

#if os(Linux)
    import Glibc
#else
    import Darwin.C
#endif

public struct Reaction<Molecule: Hashable> {
    public var reactants: Bag<Molecule>
    public var products: Bag<Molecule>
    public var rate: Float
    
    public init(reactants: Bag<Molecule>, products: Bag<Molecule>, rate: Float = 1) {
        self.reactants = reactants
        self.products = products
        self.rate = rate
    }
}

extension Interaction where Molecule: Hashable {
    public init(_ reaction: Reaction<Molecule>) {
        self.init(moleculeCount: reaction.reactants.count) { molecules in
            guard reaction.reactants == Bag(molecules) else { return nil }
            return Array(reaction.products)
        }
    }
}

extension Behavior where Molecule: Hashable {
    public init(_ reactions: [Reaction<Molecule>]) {
        let sortedReactions = SortedArray(unsorted: reactions, isOrderedBefore: { $0.rate < $1.rate })
        let _integratedReactions = sortedReactions.reduce((0, [])) { pair, element in
            return (pair.0 + element.rate, pair.1 + [Reaction(reactants: element.reactants, products: element.products, rate: element.rate + pair.0)])
        } // GROSS^^^
        let integratedReactions = SortedArray(unsafeSorted: _integratedReactions.1, isOrderedBefore: { $0.rate < $1.rate })
        let integral = _integratedReactions.0
        self.init {
            let value = Float.random(between: 0...integral)
            let index = integratedReactions.insertionIndexOf(Reaction(reactants: [], products: [], rate: value))
            // ^This is gross.. :P
            return Interaction(sortedReactions[index])
        }
    }
    
    public init(_ reactions: Reaction<Molecule>...) {
        self.init(reactions)
    }
}

// MARK: Helpers

extension Float {
    private static func random() -> Float {
        #if os(Linux)
            return Float(rand()) / Float(RAND_MAX)
        #else
            return Float(arc4random()) / Float(UInt32.max)
        #endif
    }
    
    private static func random(between between: ClosedInterval<Float>) -> Float {
        return between.start + (between.end - between.start) * random()
    }
}


