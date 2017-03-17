Pod::Spec.new do |s|
  s.name             = 'SBLApplication'
  s.version          = '0.0.1'
  s.summary          = 'Application base class to support displaying touch indicators.'
  s.description      = <<-DESC
`SBLApplication` works as a base class of application, in other words, it is an alternative of `UIApplication`.
`SBLApplication` can show touch indicators on top of the whole views so that we can demonstrate user intercations.
                       DESC
  s.homepage         = 'https://github.com/takkyun/SBLApplication'
  s.screenshots      = 'https://raw.github.com/takkyun/SBLApplication/master/sample.gif'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Takuya Otani' => 'takuya.otani@serenebach.net' }
  s.source           = { :git => 'https://github.com/takkyun/SBLApplication.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.source_files = 'SBLApplication/**/*'
end
