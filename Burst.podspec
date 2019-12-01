Pod::Spec.new do |s|
  s.name = 'Burst'
  s.version = '0.1.2'
  s.license = 'MIT'
  s.summary = 'Swift and easy way to make elements in your iOS or tvOS app burst'
  s.homepage = 'https://github.com/piemonte/burst'
  s.social_media_url = 'http://twitter.com/piemonte'
  s.authors = { 'patrick piemonte' => "patrick.piemonte@gmail.com" }
  s.source = { :git => 'https://github.com/piemonte/burst.git', :tag => s.version }
  s.ios.deployment_target = '10.0'
  s.tvos.deployment_target = '10.0'
  s.source_files = 'Sources/*.swift'
  s.resources = 'Sources/Resources/*.png'
  s.requires_arc = true
  s.swift_version = '5.0'
  s.screenshot = "https://raw.github.com/piemonte/burst/master/heartburst.gif"
end
