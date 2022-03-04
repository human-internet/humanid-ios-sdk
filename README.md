[![Version](https://img.shields.io/cocoapods/v/HumanIDSDK.svg?style=flat)](https://cocoapods.org/pods/HumanIDSDK)
[![License](https://img.shields.io/cocoapods/l/HumanIDSDK.svg?style=flat)](https://cocoapods.org/pods/HumanIDSDK)
[![Platform](https://img.shields.io/cocoapods/p/HumanIDSDK.svg?style=flat)](https://cocoapods.org/pods/HumanIDSDK)

# humanID iOS SDK

<p align="center">
<img src="https://user-images.githubusercontent.com/2031493/80385493-4f1b8480-88d0-11ea-8110-ab62c747a997.png" width="200" height="200">
</p>

<p align="center">
<a href="https://github.com/bluenumberfoundation/humanid-documentation">General Documentation</a> •
<a href="https://github.com/bluenumberfoundation/humanid-ios-sdk/wiki">Wiki</a> •
<a href="https://github.com/bluenumberfoundation/humanid-ios-sdk/wiki/integration">Integration</a> •
<a href="https://github.com/bluenumberfoundation/humanid-documentation/blob/master/contributing.md">Contributing</a> •
<a href="https://github.com/bluenumberfoundation/humanid-documentation/blob/master/gallery.md">Gallery</a> •
<a href="https://github.com/bluenumberfoundation/humanid-documentation/blob/master/faq.md">FAQ</a>
</p>

<p align="center">
Meet humanID - An anonymous online identity, enabling platforms to offer the speed and comfort of social logins, while guaranteeing absolute privacy and protecting our communities by permanently blocking bots, spams and trolls
</p>

## Requirements

* Xcode 13.0+
* Swift 5.0+
* iOS 13.0+
* [Clean Swift](https://clean-swift.com) VIP architecture

## Built with

* [Swinject](https://github.com/Swinject/Swinject) - Dependency injection framework for Swift with iOS/macOS/Linux
* [RxAlamofire](https://github.com/RxSwiftCommunity/RxAlamofire) - RxSwift wrapper around the elegant HTTP networking in Swift Alamofire
* [RxSwift](https://github.com/ReactiveX/RxSwift) - Reactive Programming in Swift

## Installation

HumanIDSDK is available through [CocoaPods](https://cocoapods.org)\
To install it, simply add the following line to your Podfile:

```ruby
pod 'HumanIDSDK'
```

## Get the credentials access

Get the ```clientID``` and ```clientSecret``` by dropping us an email [developers@human-id.org](mailto:developers@human-id.org)

## How do I use iOS SDK

Add these codes into your ```ViewController``` class, we recommend you wrap this in a function that handles the login button

```swift
import HumanIDSDK

final class YourViewController: UIViewController {

  @IBAction func didLoginAction(_ sender: Any) {
     HumanIDSDK.shared.webLogin(with: "YOUR_CLIENT_ID", and: "YOUR_CLIENT_SECRET")
  }
}

extension YourViewController: WebLoginDelegate {

  func login(token: String) {
     // TODO You can persist our token here
  }
}
```

***(Optional) You can also pass optional parameters to support default language and priority countries selection, by using the following step***

```swift
import HumanIDSDK

final class YourViewController: UIViewController {

  @IBAction func didLoginAction(_ sender: Any) {
     HumanIDSDK.shared.webLogin(with: "YOUR_CLIENT_ID", and: "YOUR_CLIENT_SECRET", language: "YOUR_DEFAULT_LANGUAGE", countries: ["YOUR_PRIORITY_COUNTRIES"])
  }
}
```

## You are set!

Now you can integrate your iOS app to humanID\
See the full [sample](https://github.com/bluenumberfoundation/humanid-ios-sdk/tree/master/Example) here to learn more

**Warning!**
To run the example project, clone the repo and run `pod install` from the Example directory first

## License

Copyright 2022 Bluenumber Foundation\
Licensed under the GNU General Public License v3.0 [(LICENSE)](https://github.com/bluenumberfoundation/humanid-ios-sdk/blob/master/LICENSE)
