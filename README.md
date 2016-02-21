# Chemical

```swift
var system = StochasticSystem(molecules: Array(Repeat(count: 100, repeatedValue: true) + [false]))

let stabilizationBehavior = Behavior(
    Reaction(reactants: [true, true],    products: [true, false], rate: 100),
    Reaction(reactants: [false,  false], products: [false, true], rate: 1)
)
system.simulate(stabilizationBehavior, stopping: .whenStable(streakLength: 500, absoluteTolerance: 1))
let sum = system.molecules.filter{ $0 }.count // should be small because of the rate constants
```
