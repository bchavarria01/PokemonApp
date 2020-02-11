# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

target 'PokemonApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  inhibit_all_warnings!
  #Pods for PokemonApp
  pod 'XLPagerTabStrip', '~> 8.1'
  pod 'SwiftKeychainWrapper'
  pod 'Hero'
  pod 'FittedSheets'
  pod 'Nuke'
  pod 'Reusable'
  pod 'IBAnimatable'
  pod 'RxSwift', '~> 4'
  pod 'RxCocoa', '~> 4'
  pod 'Moya/RxSwift', '~> 13.0'
  pod 'SwiftGen', '~> 6.0'
  
  # Pods for PokemonApp
end
post_install do |installer_representation|
  installer_representation.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = '$(inherited)'
    end
  end
end
