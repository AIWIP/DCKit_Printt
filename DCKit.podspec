Pod::Spec.new do |spec|
  spec.name             = 'DCKit'
  spec.version          = '0.2.9'
  spec.license          = { :type => 'BSD' }
  spec.homepage         = 'http://www.decode.agency'
  spec.authors          = { 'Vladimir Kolbas' => 'vladimir.kolbas@decode.agency' }
  spec.summary          = 'DC helpers and extensions'
  spec.source           = { :git => 'https://bitbucket.org/decodehq/dckit.git', :tag => spec.version.to_s }
  spec.source_files     = 'DCKit', 'DCKit/VC Custom Transitioning'
  spec.requires_arc     = true
  spec.ios.deployment_target = '8.0'
  spec.dependency 'SnapKit'
  
end