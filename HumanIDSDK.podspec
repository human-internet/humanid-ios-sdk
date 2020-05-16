Pod::Spec.new do |s|
  s.name                  = 'HumanIDSDK'
  s.version               = '1.0.0'
  s.summary               = 'HumanIDSDK for iOS.'

  s.description           = <<-DESC
  Bluenumber Foundation HumanID SDK for iOS platform.
                            DESC

  s.homepage              = 'https://github.com/bluenumberfoundation/humanid-ios-sdk'
  s.license               = { :type => 'GPL', :file => 'LICENSE' }
  s.author                = { 'Bluenumber Foundation' => 'developers@human-id.org' }
  s.source                = { :git => 'https://github.com/bluenumberfoundation/humanid-ios-sdk.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'
  s.swift_version         = '5.0'

  s.subspec 'Sources' do |sources|
    sources.source_files  = 'HumanIDSDK/Classes/**/*.{swift}'
  end

  s.resource_bundles      = { 'HumanIDSDK' => ['HumanIDSDK/Assets/**/*.{xcassets,xib}'] }

  s.frameworks            = 'UIKit'
  s.dependency 'FlagPhoneNumber', '~> 0.8.0'
  s.dependency 'VKPinCodeView', '~> 0.4.1'
  s.dependency 'IQKeyboardManager', '~> 6.5.5'
  s.dependency 'PodAsset', '~> 1.0.0'

  s.pod_target_xcconfig   = { 'PRODUCT_BUNDLE_IDENTIFIER': 'org.humanid.HumanIDSDK' }
end
