Pod::Spec.new do |s|
  s.name                  = 'HumanIDSDK'
  s.version               = '2.0.0'
  s.summary               = 'HumanIDSDK for iOS'

  s.description           = <<-DESC
  Human Internet humanID SDK for iOS platform
                            DESC

  s.homepage              = 'https://github.com/human-internet/humanid-ios-sdk'
  s.license               = { :type => 'GPL', :file => 'LICENSE' }
  s.author                = { 'Human Internet' => 'developers@human-id.org' }
  s.source                = { :git => 'https://github.com/human-internet/humanid-ios-sdk.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'
  s.swift_version         = '5.0'

  s.source_files          = 'HumanIDSDK/Classes/**/*.swift'
  s.resource_bundles      = { 'HumanIDSDKResources' => 'HumanIDSDK/Assets/*.xib' }

  s.frameworks            = 'UIKit'
  s.dependency 'Swinject', '2.8.1'
  s.dependency 'RxAlamofire', '5.7.1'
  s.dependency 'RxCocoa', '5.1.3'
  s.dependency 'RxSwift', '5.1.3'
end
