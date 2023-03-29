
Pod::Spec.new do |spec|

  spec.name         = "WXQNetWorkAPI"
  spec.version      = "1.0"
  spec.summary      = "网络请求库。"
  spec.description  = "一个网络请求库。"
  spec.homepage     = "https://github.com/xiaoqiCloud/WXQNetWorkAPI"
  spec.license      = "MIT"
  spec.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  spec.author             = { "xiaoqiCloud" => "xiaoqi9302@163.com" }
  spec.platform     = :ios
  spec.platform     = :ios, "10.0"
  spec.source       = { :git => "https://github.com/xiaoqiCloud/WXQNetWorkAPI.git", :tag => "#{spec.version}" }
  spec.source_files  = "Classes", "Classes/**/*.{h,m}"
  spec.public_header_files = "Classes/**/*.h"
  spec.requires_arc = true
  spec.dependency "AFNetworking"
  spec.dependency "MJExtension"

end
