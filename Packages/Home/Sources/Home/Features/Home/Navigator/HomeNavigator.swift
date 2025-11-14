//
//  HomeNavigator.swift
//  Home
//
//  Created by Luthfi Asmara on 13/11/25.
//

import Core
import UIKit

protocol HomeNavigator: Navigator { }

struct DefaultHomeNavigator: HomeNavigator {
  var viewController: UIViewController {
    let viewController: HomeViewController = assembler.view()
    return viewController
  }

  var behavior: NavigationBehavior = .replaceRoot

  private let assembler: Assembler
  private let launcher: Launching?

  init(assembler: Assembler, launcher: Launching?) {
    self.assembler = assembler
    self.launcher = launcher
  }
  
}
