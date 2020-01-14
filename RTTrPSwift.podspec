#
# Be sure to run `pod lib lint RTTrPSwift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RTTrPSwift'
  s.version          = '0.3'
  s.summary          = 'RTTrPSwift is a library for Swift of the RTTrP protocol'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
RTTrPSwift is a library for Swift of the RTTrP protocol. Information about the protocol can be found here: https://rttrp.github.io/RTTrP-Wiki/
                       DESC

  s.homepage         = 'https://github.com/gwsounddsg/RTTrPSwift'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'GW Rodriguez' => 'gwsounddsg@gmail.com' }
  s.source           = { :git => 'https://github.com/gwsounddsg/RTTrPSwift.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform = :osx
  s.osx.deployment_target = "10.10"
  s.swift_version = "5.0"

  s.source_files = 'RTTrPSwift/Classes/**/*'

  # s.resource_bundles = {
  #   'RTTrPSwift' => ['RTTrPSwift/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'Cocoa'
  # s.dependency 'AFNetworking', '~> 2.3'
end
