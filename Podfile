# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'KSCCM_ACCC2024' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for KSCCM_ACCC2023

platform :ios, '11.0'


    inhibit_all_warnings!

    #https://github.com/Alamofire/Alamofire
    pod 'Alamofire', '~> 4.7'

    #https://github.com/thii/FontAwesome.swift
    pod 'FontAwesome.swift', '1.9.1'

    #https://firebase.google.com/docs/ios/setup
    pod 'Firebase/Core', '7.5.0'
    pod 'Firebase/Messaging', '7.5.0'

    #https://firebase.google.com/docs/crashlytics?hl=ko
    pod 'Firebase/Crashlytics', '7.5.0'
    pod 'Firebase/Analytics', '7.5.0'

    #https://github.com/SDWebImage/SDWebImage
    pod 'SDWebImage', '~> 4.0'
    pod 'SDWebImage/GIF', '4.4.8'

    #https://github.com/evgenyneu/keychain-swift
    pod 'KeychainSwift', '~> 13.0'

    #https://github.com/ReactiveX/RxSwift
    pod 'RxSwift', '5.1.1'
    pod 'RxCocoa', '5.1.1'
    pod 'RxDataSources', '4.0.1'

    #https://github.com/RxSwiftCommunity/NSObject-Rx
    pod 'NSObject+Rx', '5.1.0'

    #https://github.com/jdg/MBProgressHUD
    pod 'MBProgressHUD', '~> 1.2.0'

    ##https://github.com/devxoul/Toaster
    pod 'Toaster', '2.3.0'

    #https://github.com/davbeck/TUSafariActivity
    pod 'TUSafariActivity', '~> 1.0'

pod 'DropDown'

end



target 'KSCCM_ACCC2024 copy' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for KSCCM_ACCC2023 copy

platform :ios, '11.0'


    inhibit_all_warnings!

    #https://github.com/Alamofire/Alamofire
    pod 'Alamofire', '~> 4.7'

    #https://github.com/thii/FontAwesome.swift
    pod 'FontAwesome.swift', '1.9.1'

    #https://firebase.google.com/docs/ios/setup
    pod 'Firebase/Core', '7.5.0'
    pod 'Firebase/Messaging', '7.5.0'

    #https://firebase.google.com/docs/crashlytics?hl=ko
    pod 'Firebase/Crashlytics', '7.5.0'
    pod 'Firebase/Analytics', '7.5.0'

    #https://github.com/SDWebImage/SDWebImage
    pod 'SDWebImage', '~> 4.0'
    pod 'SDWebImage/GIF', '4.4.8'

    #https://github.com/evgenyneu/keychain-swift
    pod 'KeychainSwift', '~> 13.0'

    #https://github.com/ReactiveX/RxSwift
    pod 'RxSwift', '5.1.1'
    pod 'RxCocoa', '5.1.1'
    pod 'RxDataSources', '4.0.1'

    #https://github.com/RxSwiftCommunity/NSObject-Rx
    pod 'NSObject+Rx', '5.1.0'

    #https://github.com/jdg/MBProgressHUD
    pod 'MBProgressHUD', '~> 1.2.0'

    ##https://github.com/devxoul/Toaster
    pod 'Toaster', '2.3.0'

    #https://github.com/davbeck/TUSafariActivity
    pod 'TUSafariActivity', '~> 1.0'

pod 'DropDown'
end

post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
               end
          end
   end
end
