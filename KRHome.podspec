Pod::Spec.new do |s|
s.name         = "KRHome"
s.version      = "0.0.1"
s.summary      = "Home Module"
s.description  = <<-DESC
                    首页模块私有库
                    DESC

s.homepage     = "https://github.com/KinRainModulization/KRHome.git"
s.license      = "MIT"                #开源协议
s.author       = { "linyi31" => "linyi@jd.com" }

s.prefix_header_file = "KRHome/KRHome/PrefixHeader.pch"

s.source       = { :git => "https://github.com/KinRainModulization/KRHome.git" }
#s.source      = { :git => "https://github.com/KinRainModulization/KRHome.git", :tag => s.version.to_s }

s.platform     = :ios, "9.0"
s.requires_arc = true

s.source_files = "KRHome/KRHome/Classes/**/*.{h,m}"

s.dependency "KRPublishLibrary"

end
