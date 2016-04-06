Pod::Spec.new do |s|
  s.name = 'DAAnalytics'
  s.version = '1.0'
  s.ios.deployment_target = '8.0'
  s.author   = { 'Alexander Desyatov' => 'desyatovav@gmail.com' }
  s.dependency 'AFNetworking-RACExtensions'
  s.source_files = 'classes/*.{h,m}'
  s.requires_arc = true

end