Pod::Spec.new do |s|
s.name         = "KRHome"
s.version      = "0.0.1"
s.summary      = "KRHome"
s.description  = <<-DESC

                    DESC

s.homepage     = "https://github.com/KinRainModulization/KRHome.git"
# s.screenshots  = "www.example.com/screenshots_1.gif"
s.license      = "MIT"                #开源协议
s.author             = { "linyi31" => "linyi@jd.com" }

s.source       = { :git => "https://github.com/KinRainModulization/KRHome.git" }
#s.source       = { :git => "https://github.com/KinRainModulization/KRHome.git", :tag => s.version.to_s }

s.platform     = :ios, "9.0"
s.requires_arc = true

s.source_files  = "KRHome/KRHome/Classes/**/*.{h,m}"

#s.dependency "CTMediator"

end
