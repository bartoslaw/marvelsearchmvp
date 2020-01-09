# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'


use_frameworks!
inhibit_all_warnings!

def shared_pods
  pod 'SDWebImage', '~> 5.0'
  pod 'RxSwift',    '~> 5.0'
  pod 'RxCocoa',    '~> 5.0'
  pod 'Swinject'
  pod 'SwinjectStoryboard'
  pod 'MBProgressHUD', '~> 1.0.0'
  pod 'Alamofire', '~> 4.4'
  pod 'AlamofireObjectMapper', '~> 5.0'
  pod 'IQKeyboardManagerSwift'
end

target 'MarvelApp' do
  shared_pods
end

target 'MarvelAppTests' do
  inherit! :search_paths
  pod 'AlamofireObjectMapper', '~> 5.0'
  pod 'Quick'
  pod 'Nimble'
  pod 'RxBlocking'
  pod 'RxTest'
end

target 'MarvelAppUITests' do

end
