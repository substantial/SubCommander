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
