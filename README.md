# Chemical

Chemical is a thin abstraction built on top of [Stochastic](https://github.com/jadengeller/stochastic) that makes simulating chemical reactions easy. Note that Chemical was not designed with accuracy in mind, and it has not been compared to expected result.

Here's an example of a false-biased value stabilizing chemical network.
```swift
var system = StochasticSystem(molecules: Array(Repeat(count: 100, repeatedValue: true) + [false]))

// true  + true  ->[100] true  + false
// false + false ->[1]   false + true
let stabilizationBehavior = Behavior(
    Reaction(reactants: [true, true],    products: [true, false], rate: 100),
    Reaction(reactants: [false,  false], products: [false, true], rate: 1)
)
system.simulate(stabilizationBehavior, stopping: .whenStable(streakLength: 500, absoluteTolerance: 1))
let sum = system.molecules.filter{ $0 }.count // should be small because of the rate constants
```
