Pod::Spec.new do |spec|
  spec.name             = 'DCKit_Printt'
  spec.version          = '0.3.0'
  spec.license          = { :type => 'BSD' }
  spec.homepage         = 'http://www.decode.agency'
  spec.authors          = { 'Vladimir Kolbas' => 'vladimir.kolbas@decode.agency' }
  spec.summary          = 'DC helpers and extensions'
  spec.source           = { :git => 'https://github.com/AIWIP/DCKit_Printt.git', :tag => spec.version.to_s }
  spec.source_files     = 'DCKit', 'DCKit/VC Custom Transitioning'
  spec.requires_arc     = true
  spec.ios.deployment_target = '8.0'
  spec.dependency 'SnapKit'
  
end
