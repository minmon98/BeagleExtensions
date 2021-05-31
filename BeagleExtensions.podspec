Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name         = "BeagleExtensions"
  spec.version      = "1.0.10"
  spec.summary      = "An extension of beagle framework."
  spec.description  = "An extension of beagle framework. It contains action and widget extensions."
  spec.homepage     = "https://github.com/minmon98/BeagleExtensions"
  spec.license      = "MIT"
  spec.author             = { "Minh Mon" => "phivanminh10@gmail.com" }
  spec.platform     = :ios, "12.0"
  spec.source       = { :git => "https://github.com/minmon98/BeagleExtensions.git", :tag => spec.version.to_s }
  spec.source_files  = "BeagleExtensions/**/*.{swift}"
  spec.resources = "BeagleExtensions/**/*.{xib}"
  spec.resource_bundles = {
      "BeagleExtensions" => ["BeagleExtensions/**/*.{xib}"]
  }
  spec.swift_versions = "5.0"

  spec.dependency "Beagle"
  spec.dependency "BeagleSchema"
  spec.dependency "BeagleScaffold"
  spec.dependency "Charts"
  spec.dependency "SVProgressHUD"
  spec.dependency "MaterialComponents"
  spec.dependency "SDWebImage"
  spec.dependency "SwiftGifOrigin"
end
