
import PackageDescription

let package = Package(
    name: "Chemical",
    dependencies: [
        .Package(url: "https://github.com/JadenGeller/Stochastic.git", majorVersion: 1),
        .Package(url: "https://github.com/JadenGeller/Handbag.git", majorVersion: 1),
        .Package(url: "https://github.com/JadenGeller/Orderly.git", majorVersion: 1)
    ]
)
