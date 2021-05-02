# Uncomment the next line to define a global platform for your project
workspace 'GithubClient'

use_frameworks!

platform :ios, '13.0'

#core module
def core_pods
  pod 'SwiftLint', :configurations => ['Debug']
  pod 'SwiftGen', :configurations => ['Debug']
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'ModelsMapper'
  pod 'SwiftyJSON'
  pod 'SwiftyNet'
end


target 'Core' do
  project 'Core/Core.project'
  core_pods
  
end

#presentation module
def presentation_pods
  core_pods
  pod 'SwiftMessages'
  pod 'Toast-Swift'
  pod 'NVActivityIndicatorView'
  pod 'IQKeyboardManagerSwift'
  pod 'Lightbox'
  pod 'PanModal'
  pod 'DropDown'
  pod 'Nuke'
  pod 'RxReachability'
  pod 'SnapKit'
end

target 'Presentation' do
  project 'Presentation/Presentation.project'
  presentation_pods
end

#data module
def data_pods
  core_pods
  
end

target 'Data' do
  use_frameworks!
  project 'Data/Data.project'
  data_pods

end

#app module
def app_pods
  core_pods
end


target 'GithubClient' do
  app_pods
  presentation_pods
  
  target 'GithubClientTests' do
    pod 'SwiftyNet'

  end
  target 'GithubClientUITests' do
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['CONFIGURATION_BUILD_DIR'] = '$PODS_CONFIGURATION_BUILD_DIR'
    end
    
    target.build_configurations.each do |config|
      config.build_settings['ENABLE_BITCODE'] = 'NO'
    end
    
  end
end
