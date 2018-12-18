#
# Be sure to run `pod lib lint SwipeableTableViewCell.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwipeableTableViewCell'
  s.version          = '0.2.0'
  s.summary          = 'Swipable subclass of UITableViewCell'

  s.description      = <<-DESC
A subclass of UITableViewCell which adds an ability to swipe left the content of the cell.
                       DESC

  s.homepage         = 'https://github.com/10clouds/SwipeableTableViewCell-ios'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Hubert Kuczynski' => 'hubert.kuczynski@10clouds.com' }
  s.source           = { :git => 'https://github.com/10clouds/SwipeableTableViewCell-ios.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.3'
  s.swift_version = '4.0'

  s.source_files = 'SwipeableTableViewCell/Classes/**/*'
end
