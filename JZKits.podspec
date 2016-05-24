#
# Be sure to run `pod lib lint JZKits.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "JZKits"
  s.version          = "0.1.0"
  s.summary          = "iOS Kits created by JaxZhou"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                        Kits created by JaxZhou,Include
                        1,Runtime helper for swizzling
                        2,UIKit Extensions
                            2.1 UITextField
                            2.2 UIImage
                            2.3 UIVIew
                            2.4 UIDevice
                        3,Foundation Extensions
                            3.1 Crypto of String and Data
                            3.2 Date Paraser
                       DESC

  s.homepage         = "https://github.com/jaxzhou/JZKits"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "JaxZhou" => "zhoujinxiu@didapinche.com" }
  s.source           = { :git => "https://github.com/jaxzhou/JZKits.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/jaxzhou'

  s.ios.deployment_target = '7.0'

  s.source_files = 'JZKits/Classes/**/*'
  s.resource_bundles = {
    'JZKits' => ['JZKits/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
