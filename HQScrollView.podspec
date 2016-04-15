Pod::Spec.new do |s|
s.name         = 'HQScrollView'
s.version      = '0.0.1'
s.summary      = 'An easy way to use scorll advertisement'
s.homepage     = 'https://github.com/SmallWeed/HQScrollView'
s.license      = 'MIT'
s.authors      = {'Smallweed' => '491041442@qq.com'}
s.platform     = :ios, '6.0'
s.source       = {:git => 'https://github.com/SmallWeed/HQScrollView.git', :tag => s.version}
s.source_files = 'HQScrollView/**/*.{h,m}'
s.resource     = 'HQScrollView/**/*.{png,xib,storyboard}'
s.requires_arc = true
s.dependency 'SDWebImage'
end
