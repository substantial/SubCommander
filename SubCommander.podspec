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
  s.platform     = :ios, '5.0'
  s.source       = { :git => "https://github.com/substantial/SubCommander.git", :tag => s.version.to_s }
  s.source_files  = 'Classes', 'Classes/**/*.{h,m}'
  s.requires_arc = true
  s.dependency 'AFNetworking', '~> 1.3.2'
  s.prefix_header_contents = <<-EOS
#import <Availability.h>

#define _AFNETWORKING_PIN_SSL_CERTIFICATES_

#if __IPHONE_OS_VERSION_MIN_REQUIRED
  #import <SystemConfiguration/SystemConfiguration.h>
  #import <MobileCoreServices/MobileCoreServices.h>
  #import <Security/Security.h>
#else
  #import <SystemConfiguration/SystemConfiguration.h>
  #import <CoreServices/CoreServices.h>
  #import <Security/Security.h>
#endif
EOS

end
