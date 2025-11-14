//
//  SplashNavigator.swift
//  Home
//
//  Created by Luthfi Asmara on 13/11/25.
//

import Core
import UIKit

protocol SplashNavigator: InitialNavigator {
  func navigateToHome(from viewController: UIViewController)
}

struct DefaultSplashNavigator: SplashNavigator {
  var viewController: UIViewController {
    let viewController: SplashViewController = assembler.view()
    return viewController
  }

  private let assembler: Assembler
  private let launcher: Launching?

  init(assembler: Assembler, launcher: Launching?) {
    self.assembler = assembler
    self.launcher = launcher
  }

  func navigateToHome(from viewController: UIViewController) {
    let navigator: HomeNavigator = assembler.navigator()
    navigator.navigate(from: viewController)
  }
}
