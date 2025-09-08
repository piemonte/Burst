# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Common Development Commands

### Building the project
```bash
# Build using Xcode
xcodebuild -workspace Burst.xcworkspace -scheme 'Debug - iOS' -sdk iphonesimulator build

# Build release version
xcodebuild -workspace Burst.xcworkspace -scheme 'Release - iOS' -sdk iphonesimulator build
```

### Testing
```bash
# Run tests (if test target exists)
xcodebuild -workspace Burst.xcworkspace -scheme 'Debug - iOS' -sdk iphonesimulator test

# Analyze code for issues
xcodebuild -workspace Burst.xcworkspace -scheme 'Debug - iOS' -sdk iphonesimulator analyze
```

### Package Management
```bash
# CocoaPods - install/update dependencies
pod install

# Swift Package Manager - build the package
swift build

# Swift Package Manager - test the package
swift test
```

## Architecture and Structure

Burst is a Swift iOS library that provides a firework burst effect using CAEmitterLayers. The library is designed to be simple and easy to integrate.

### Core Components

#### BurstView (Sources/Burst.swift:31-163)
- UIView subclass that manages the burst animation effect
- Uses two CAEmitterLayers: `_chargeLayer` for the initial charge effect and `_explosionLayer` for the burst
- Configurable properties:
  - `particleImage`: The image used for each particle
  - `particleScale`: Scale factor for particles (default: 0.05)
  - `particleScaleRange`: Range of scale variation (default: 0.02)

#### BurstButton (Sources/Burst.swift:205-293)
- UIButton subclass that integrates BurstView
- Triggers burst animation when `isSelected` changes to true
- Includes bounce animations during state transitions
- Manages its own BurstView instance

### Project Structure
- **Sources/**: Main library code
  - `Burst.swift`: Contains both BurstView and BurstButton implementations
  - `Burst.h`: Objective-C header for framework compatibility
  - `Resources/`: Contains particle images (burst-red.png)

- **Project/**: Example iOS application
  - `Burst/`: Sample app demonstrating library usage
  - `Burst.xcodeproj`: Xcode project file
  - Configuration files: Base.xcconfig, Debug.xcconfig, Release.xcconfig

### Key Implementation Details

The burst effect is achieved through a two-phase animation:
1. **Charge phase**: Particles move inward (`burst()` method at Sources/Burst.swift:173)
2. **Explosion phase**: Particles burst outward (`explode()` method at Sources/Burst.swift:183)

The animation timing is controlled via:
- CAEmitterLayer's `birthRate` property for starting/stopping particle emission
- DispatchQueue delays for phase transitions (200ms charge, 100ms explosion)

### Distribution Methods
- CocoaPods: Via Burst.podspec
- Carthage: Direct GitHub repository
- Swift Package Manager: Via Package.swift (requires Swift 5.0+, iOS 10.0+)

### Platform Requirements
- iOS 10.0+ minimum deployment target
- Swift 5.0+
- Xcode 11.5+ (based on Travis CI configuration)