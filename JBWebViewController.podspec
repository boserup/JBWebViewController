#
#  Be sure to run `pod spec lint JBWebViewController.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "JBWebViewController"
  s.version      = "1.0.9"
  s.summary      = "A modal view controller for showing websites - inspired by the Facebook app"
  s.description  = <<-DESC
                   A drop-in Facebook inspired modal web browser.

                   Created to look like the web browser in the current Facebook App on App Store.
                   DESC
  s.homepage     = "https://github.com/boserup/JBWebViewController"
  s.screenshots  = "https://raw.githubusercontent.com/boserup/JBWebViewController/master/Example/screenshot.png"
  s.license      = "MIT"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Jonas Boserup" => "jonas@iboserup.dk" }
  s.social_media_url   = "http://twitter.com/JonasBoserup"
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/boserup/JBWebViewController.git", :tag => "#{s.version}" }
  s.source_files = "JBWebViewController/*.{h,m}"
  s.resources    = "JBWebViewController/Icons.xcassets"
  s.weak_framework = 'WebKit'
  s.requires_arc = true
  s.dependency 'ARChromeActivity', '1.0.0'
  s.dependency 'ARSafariActivity', '0.0.1'
  s.dependency 'NJKWebViewProgress', '0.2.3'
end
