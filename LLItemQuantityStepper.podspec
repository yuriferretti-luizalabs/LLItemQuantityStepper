Pod::Spec.new do |s|

  s.name         = "LLItemQuantityStepper"
  s.version      = "0.0.1"
  s.summary      = "Custom basket stepper"

  s.description  = <<-DESC 
  A stepper for basket item quantity selection and removal
                   DESC

  s.homepage     = "https://github.com/yuriferretti-luizalabs/LLItemQuantityStepper"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Yuri Ferretti" => "email@address.com" }
  s.source       = { :git => "https://github.com/yuriferretti-luizalabs/LLItemQuantityStepper.git", :commit => "3a11bb9f3a4f14cda2e522eff8246f8cfc583a28" }
  s.source_files  = "Source/**/*.{swift}"
  s.platform     = :ios, "9.0"
  s.framework  = "UIKit"

end
