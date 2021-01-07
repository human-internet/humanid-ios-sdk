Pod::Spec.new do |s|
  s.name                  = 'HumanIDSDK'
  s.version               = '1.4.2'
  s.summary               = 'HumanIDSDK for iOS.'

  s.description           = <<-DESC
  Bluenumber Foundation HumanID SDK for iOS platform.
                            DESC

  s.homepage              = 'https://github.com/bluenumberfoundation/humanid-ios-sdk'
  s.license               = { :type => 'GPL', :file => 'LICENSE' }
  s.author                = { 'Bluenumber Foundation' => 'developers@human-id.org' }
  s.source                = { :git => 'https://github.com/bluenumberfoundation/humanid-ios-sdk.git', :tag => s.version.to_s }

  s.ios.deployment_target = '12.0'
  s.swift_version         = '5.0'

  s.subspec 'Classes' do |spec|
    spec.source_files     = 'HumanIDSDK/Classes/**/*.{swift}'
  end

  s.subspec 'Assets' do |spec|
    spec.resource_bundles = { 'HumanIDSDK' => [
      'HumanIDSDK/Assets/*.xcassets',
      'HumanIDSDK/Assets/*.xib',
      'HumanIDSDK/Assets/Font/*.ttf',
      'HumanIDSDK/Assets/Localization/*.lproj/*.strings'
    ]
  }
  end

  s.frameworks            = 'UIKit'
  s.dependency 'Swinject', '2.7.1'
  s.dependency 'RxAlamofire', '5.7.1'
  s.dependency 'RxCocoa', '5.1.1'
  s.dependency 'RxSwift', '5.1.1'
  s.dependency 'FlagPhoneNumber', '0.8.0'
  s.dependency 'IQKeyboardManager', '6.5.6'
  s.dependency 'VKPinCodeView', '0.4.2'
end
