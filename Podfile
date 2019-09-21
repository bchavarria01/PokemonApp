# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

target 'PokemonApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  inhibit_all_warnings!
  #Pods for PokemonApp
  pod 'XLPagerTabStrip', '~> 8.1'
  pod 'SwiftKeychainWrapper'
  pod 'Alamofire', '~> 4.7'
  pod 'Hero'
  pod 'SwiftLint'
  pod 'SwiftyJSON'
  pod 'CryptoSwift'
  pod 'SkyFloatingLabelTextField'
  pod 'SVProgressHUD'
  pod 'NVActivityIndicatorView'
  pod 'FittedSheets'
  # Pods for PokemonApp
end
post_install do |installer_representation|
  installer_representation.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = '$(inherited)'
    end
  end
end
