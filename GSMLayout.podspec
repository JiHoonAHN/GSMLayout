#
# Be sure to run `pod lib lint GSMLayout.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GSMLayout'
  s.version          = '0.1.5'
  s.summary          = 'bout Fast Swift Views layouting without auto layout.'
  s.description      = 'About Fast Swift Views layouting without auto layout. pure code, full control and blazing fast.'
  s.homepage         = 'https://github.com/JiHoonAHN/GSMLayout'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'JiHoonAHN' => 'ahnjh1028@naver.com' }
  s.source           = { :git => 'https://github.com/JiHoonAHN/GSMLayout.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'Sources/GSMLayout/Classes/**/*'
end
