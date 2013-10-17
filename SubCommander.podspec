#
#  Be sure to run `pod spec lint SubCommander.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "SubCommander"
  s.version      = "0.0.1"
  s.summary      = "iOS Objective-C framework for building testable clients for JSON REST APIs"

  s.description  = <<-DESC
                   iOS Objective-C framework for building testable clients for JSON REST APIs.  Uses AFNetworking under the hood.
                   DESC

  s.homepage     = "http://github.com/substantial/SubCommander"
  s.license      = 'MIT'
  s.author        = { "Mike Judge" => "mikelovesrobots@gmail.com" }
  s.platform     = :ios, '6.0'
  s.source       = { :git => "https://github.com/substantial/SubCommander.git", :tag => "0.0.1" }
  s.source_files  = 'Classes', 'Classes/**/*.{h,m}'
  s.requires_arc = true
  s.dependency 'AFNetworking', '1.3.1'
end
