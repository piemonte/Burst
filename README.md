![Burst](https://github.com/piemonte/Burst/blob/master/heartburst.gif?raw=true)

## Burst 🎆

`Burst` is a [Swift](https://developer.apple.com/swift/) and simple way to make elements in your iOS app burst.

Back in the day, Facebook Paper popularized the firework burst effect using CAEmitterLayers. This library provides a CAEmitterLayer firework effect contained in a customizable open source library, written in Swift.

If you enjoy this, you may also like another CAEmitterLayer project, [Twinkle](https://github.com/piemonte/twinkle).

[![Build Status](https://travis-ci.org/piemonte/Burst.svg?branch=master)](https://travis-ci.org/piemonte/Burst) [![Pod Version](https://img.shields.io/cocoapods/v/Burst.svg?style=flat)](http://cocoadocs.org/docsets/Burst/) [![Swift Version](https://img.shields.io/badge/language-swift%205.0-brightgreen.svg)](https://developer.apple.com/swift) [![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://github.com/piemonte/Burst/blob/master/LICENSE)

* `5.0` - Target your Podfile to the latest release or master

# Quick Start

`Burst` is available and recommended for installation using the Cocoa dependency manager [CocoaPods](http://cocoapods.org/). You can also simply copy the `Burst.swift` file into your Xcode project.

```ruby
# CocoaPods
pod "Burst", "~> 0.1.0"

# Carthage
github "piemonte/Burst" ~> 0.1.0

# SwiftPM
let package = Package(
    dependencies: [
        .Package(url: "https://github.com/piemonte/Burst", majorVersion: 0)
    ]
)
```

## Usage

The sample project provides an example of how to integrate `Burst`, otherwise you can follow this example.

``` Swift
   import Burst
```

``` Swift

// ...
    let button: BurstButton = BurstButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
// ...
   
extension ViewController {
    
    @objc func handleButton(_ button: BurstButton) {
        button.isSelected = !button.isSelected
    }
}


```

## Community

- Found a bug? Open an [issue](https://github.com/piemonte/burst/issues).
- Feature idea? Open an [issue](https://github.com/piemonte/burst/issues).
- Want to contribute? Submit a [pull request](https://github.com/piemonte/burst/pulls).

## Resources

* [Core Animation Reference Collection](https://developer.apple.com/library/ios/documentation/Cocoa/Reference/CoreAnimation_framework/index.html)
* [Swift Evolution](https://github.com/apple/swift-evolution)
* [MCFireworksButton](https://github.com/matthewcheok/MCFireworksButton), Objective-C version
* [Twinkle](https://github.com/piemonte/twinkle)
* [Twinkle for Android](https://github.com/dev-labs-bg/twinkle)
* [Shimmer](https://github.com/facebook/shimmer)

## License

`Burst` is available under the MIT license, see the [LICENSE](https://github.com/piemonte/burst/blob/master/LICENSE) file for more information.
