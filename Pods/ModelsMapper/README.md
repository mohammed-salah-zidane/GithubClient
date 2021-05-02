ModelMapper
================
![platforms](https://img.shields.io/badge/platforms-iOS%20%7C%20macOS%20%7C%20tvOS%20%7C%20watchOS%20%7C%20Linux-333333.svg) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) [![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)

An abstraction for mapping models, write a mapper once, use everywhere.

# Usage

```swift
// declare Mapper
struct UserDtoMapper: Mapper {
    typealias I = UserDto
    typealias O = User
    
    func map(_ input: UserDto) -> User {
        User(name: input.name, email: input.email)
    }
}

// mape UserDto to User
let user: User = UserDtoMapper().map(userDto)

// map [UserDto] to [User]
let input: [UserDto] = [userDto, userDto]
let users: [User] = ListMapper(UserDtoMapper()).map(input)

// map [UserDto]? to [User]
let input: [UserDto]? = nil
let users: [User] = OptionalInputListMapper(UserDtoMapper()).map(input)

// map [UserDto] to [User]?
let input: [UserDto] = []
let users: [User]? = OptionalOutputListMapper(UserDtoMapper()).map(input)  

// map [UserDto]? to [User]?
let input: [UserDto]? = nil
let users: [User]? = OptionalListMapper(UserDtoMapper()).map(input)  
```

## Installation

### Swift Package Manager

To integrate using Apple's Swift package manager, add the following as a dependency to your `Package.swift`:

```swift
.package(url: "https://github.com/ShabanKamell/ModelMapper.git", .upToNextMajor(from: "0.1.0"))
```

and then specify `"ModelMapper"` as a dependency of the Target in which you wish to use ModelMapper.
Here's an example `PackageDescription`:

```swift
// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "MyPackage",
    products: [
        .library(
            name: "MyPackage",
            targets: ["MyPackage"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ShabanKamell/ModelMapper-Swift.git", .upToNextMajor(from: "0.1.0"))
    ],
    targets: [
        .target(
            name: "MyPackage",
            dependencies: ["ModelMapper"])
    ]
)
```

### Accio

[Accio](https://github.com/JamitLabs/Accio) is a dependency manager based on SwiftPM which can build frameworks for iOS/macOS/tvOS/watchOS. Therefore the integration steps of RxRequester are exactly the same as described above. Once your `Package.swift` file is configured, run `accio update` instead of `swift package update`.

### CocoaPods

For RxRequester, use the following entry in your Podfile:

```rb
pod 'ModelMapper-Swift', '~> 0.1.0'
```

Then run `pod install`.

In any file you'd like to use RxRequester in, don't forget to
import the framework with `import ModelMapper` or `import ModelMapper_Swift` when using CocoaPods.

### Carthage

Carthage users can point to this repository and use generated `ModelMapper` framework.

Make the following entry in your Cartfile:

```
github "ShabanKamell/ModelMapper-Swift" ~> 0.1.0
```

Then run `carthage update`.

If this is your first time using Carthage in the project, you'll need to go through some additional steps as explained [over at Carthage](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application).

### License

<details>
    <summary>
        click to reveal License
    </summary>
    
```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

</details>
