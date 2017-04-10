Pod::Spec.new do |s|

  s.name         = "LLItemQuantityStepper"
  s.version      = "0.0.9"
  s.summary      = "Custom basket stepper"

  s.description  = <<-DESC 
  A stepper for basket item quantity selection and removal
                   DESC

  s.homepage     = "https://github.com/yuriferretti-luizalabs/LLItemQuantityStepper"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Yuri Ferretti" => "yuri.ferretti@luizalabs.com.com" }
  s.source       = { :git => "https://github.com/yuriferretti-luizalabs/LLItemQuantityStepper.git", :tag => "#{s.version}" }
  s.source_files = "Source/**/*.{swift}"
  s.platform     = :ios, "9.0"
  s.framework    = "UIKit"

end
