#
# Be sure to run `pod lib lint TextFieldToken.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TextFieldToken'
  s.version          = '0.1.0'
  s.summary          = 'A short description of TextFieldToken.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/tksu92/TextFieldToken'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'tksu92' => 'sutran' }
  s.source           = { :git => 'https://github.com/tksu92/TextFieldToken.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'
  s.swift_version = '5.0'
  
  s.source_files = 'TextFieldToken/Classes/**/*'
  s.dependency 'SnapKit'
end
