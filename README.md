# humanID iOS SDK

Meet humanID - An anonymous online identity, enabling platforms to offer the speed and comfort of social logins, while guaranteeing absolute privacy and protecting our communities by permanently blocking bots, spams, and trolls.

<img src="Logo.png" width="200" height="200">

## Requirements

* Xcode 11.4+
* Swift 5.0
* iOS 11.0+

## Built with

* [FlagPhoneNumber](https://github.com/chronotruck/FlagPhoneNumber) - A formatted phone number UITextField with country flag picker.
* [VKPinCodeView](https://github.com/Sunspension/VKPinCodeView) - VKPinCodeView is simple and elegant UI component for input PIN. You can easily customise appearance and get auto fill (OTP) iOS 12 feature right from the box.
* [IQKeyboardManager](https://github.com/hackiftekhar/IQKeyboardManager) - Codeless drop-in universal library allows to prevent issues of keyboard sliding up and cover UITextField/UITextView. Neither need to write any code nor any setup required and much more.
* [PodAsset](https://github.com/haifengkao/PodAsset) - Unable to find cocoapods resources? Here is the solution!

## Installation

HumanIDSDK is available through [CocoaPods](https://cocoapods.org).\
To install it, simply add the following line to your Podfile:

```ruby
pod 'HumanIDSDK'
```

## Get the credentials access

Get the appId and appSecret by filling up this form or drop us an email [developers@human-id.org](mailto:developers@human-id.org).

## Configuration

Add these codes into your `AppDelegate.swift` and make sure all value is fulfilled.

```swift
import HumanIDSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
     HumanIDSDK.shared.config(appID: "YOUR_APP_ID", appSecret: "YOUR_APP_SECRET")
  }
}
```

## How Do I Use humanID iOS SDK

Add these codes into your ViewController file, we recommend you wrap this in a function that handles the login button.

```swift
import HumanIDSDK

class YourViewController: UIViewController {

  @IBAction func yourLoginAction(_ sender: Any) {
     HumanIDSDK.shared.authorize(view: self, name: "YOUR_APPLICATION_NAME", image: "YOUR_APPLICATION_LOGO")
  }
}

extension YourViewController: AuthorizeDelegate {

  func viewDidSuccess(token: String) {
     // TODO You can persist our token here.
  }
}
```

## You are set!

Now you can integrate your iOS app to humanID. See the full [sample](Example) here to learn more.

**Warning!**
To run the example project, clone the repo, and run `pod install` from the Example directory first.

## License

Copyright 2019-2020 Bluenumber Foundation\
Licensed under the GNU General Public License v3.0 [(LICENSE)](LICENSE)
