#
# Be sure to run `pod lib lint SearchAds365_SDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SearchAds365_SDK'
  s.version          = '0.0.1'
  s.summary          = 'SearchAds365_SDK podspec file.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: SearchAds365_SDK: to analyze data conveniently.
                       DESC

  s.homepage         = 'https://github.com/SearchAds365/SearchAds365_SDK'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'SearchAds365' => 'support@Searchads365.com' }
  s.source           = { :git => 'https://github.com/SearchAds365/SearchAds365_SDK.git', :tag => s.version.to_s }
  s.ios.deployment_target = '11.0'

  s.source_files = 'SearchAds365_SDK/Classes/**/*'

  s.dependency 'FCUUID','~> 1.3.1'
  s.dependency 'AnyCodable-FlightSchool', '~> 0.6.1'
  s.frameworks = 'Foundation', 'StoreKit'
  s.ios.framework = 'UIKit', 'iAd', 'AdSupport','AppTrackingTransparency'
  s.ios.weak_frameworks = 'AdServices'
  s.osx.frameworks = 'AppKit'
  s.osx.weak_frameworks = 'AdSupport', 'AdServices'
end
