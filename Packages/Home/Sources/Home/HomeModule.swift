//
//  HomeModule.swift
//  Home
//
//  Created by Luthfi Asmara on 13/11/25.
//

import Common
import Core
import Foundation
import UIKit

public class HomeModule: InitialLaunchable {
  public var identifier: ModuleIdentifier = .home
  public var launcher: Launching? {
    didSet {
      assembler.launcher = launcher
    }
  }
  
  private let assembler = ModuleAssembler()
  
  private var splashNavigator: SplashNavigator {
    assembler.navigator()
  }

  private var homeNavigator: HomeNavigator {
    assembler.navigator()
  }

  public init() {
  }
    
  public func launch(in viewController: UIViewController, options: LaunchOptions) {
    guard case .targeted(let identifier, let params) = options else {
      homeNavigator.navigate(from: viewController)
      return
    }
  }
  
  public func launch(in window: UIWindow?, options: LaunchOptions) {
    splashNavigator.navigate(from: window)
  }
  
  public func landingViewController(with option: LaunchOptions) -> UIViewController {
    splashNavigator.viewController
  }
}

extension Bundle {
  static var current: Bundle {
    Bundle.init(for: HomeModule.self)
  }
}
