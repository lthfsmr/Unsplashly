//
//  AppDelegate.swift
//  Unsplashly
//
//  Created by Luthfi Asmara on 13/11/25.
//

import Core
import Common
import CommonUI
import Home
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var hostApp: UIApplication?
  
  private var moduleManager: ModuleManager?
  
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    setupEnvironment()

    hostApp = application
    setupModules()
    
    window = UIWindow(frame: UIScreen.main.bounds)
    
    moduleManager?.launch(from: window, options: .empty)
    window?.makeKeyAndVisible()
    
    return true
  }
  
  func setupModules() {
    moduleManager = ModuleManager(launcher: self)
    moduleManager?.register(launchables: [
      HomeModule(),
    ])
  }
  
  func setupEnvironment() {
    #if DEVELOPMENT
    AppConfig.current = AppConfig(environment: .development)
    print(AppConfig.current.apiConfig.baseURL)
    #elseif STAGING
    AppConfig.current = AppConfig(environment: .staging)
    #else  // PRODUCTION
    AppConfig.current = AppConfig(environment: .production)
    #endif
  }
}

// MARK: Launcher
extension AppDelegate: Launching {
  func launchModule(identifier: ModuleIdentifier, in viewController: UIViewController, options: LaunchOptions) {
    moduleManager?.launchModule(identifier: identifier, in: viewController, options: options)
  }
  
  func landingViewController(identifier: ModuleIdentifier, with option: LaunchOptions) -> UIViewController? {
    moduleManager?.getLandingViewController(identifier: identifier, options: option)
  }
}
