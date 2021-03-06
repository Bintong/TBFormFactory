#
# Be sure to run `pod lib lint TBFormFactory.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TBFormFactory'
  s.version          = '0.1.4'
  s.summary          = '表单逻辑方法实现'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
对于表单的实现逻辑
                       DESC

  s.homepage         = 'https://github.com/Bintong/TBFormFactory'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'https://github.com/Bintong/TBFormFactory' => 'yaxun_123@163.com' }
  s.source           = { :git => 'https://github.com/Bintong/TBFormFactory.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  s.source_files = 'TBFormFactory/Classes/**/*'
  
  s.prefix_header_file = 'TBFormFactory/Classes/PrefixHeader.pch'

  # s.resource_bundles = {
  #   'TBFormFactory' => ['TBFormFactory/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  
  s.dependency 'TBToolCategory'
end
