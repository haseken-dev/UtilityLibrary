// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(name: "UtilityLibrary",
                      platforms: [.iOS(.v9)],
                      products: [.library(name: "UtilityLibrary",
                                          targets: ["UtilityLibrary"])],
                      targets: [.target(name: "UtilityLibrary",
                                        path: "Source")],
                      swiftLanguageVersions: [.v5])
