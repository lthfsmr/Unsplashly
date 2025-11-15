//
//  HomeNavigator.swift
//  Home
//
//  Created by Luthfi Asmara on 13/11/25.
//

import Core
import UIKit
import Common

protocol HomeNavigator: Navigator {
  func navigateToPhotoDetail(from: UIViewController, photo: Photo)
}

struct DefaultHomeNavigator: HomeNavigator {
  var viewController: UIViewController {
    let view: HomeView = assembler.view()
    return UINavigationController(rootViewController: view.viewController)
  }

  var behavior: NavigationBehavior = .replaceRoot

  private let assembler: Assembler
  private let launcher: Launching?

  init(assembler: Assembler, launcher: Launching?) {
    self.assembler = assembler
    self.launcher = launcher
  }
  
  func navigateToPhotoDetail(from: UIViewController, photo: Photo) {
    let navigator: PhotoDetailNavigator = assembler.navigator()
    navigator.navigateToPhotoDetail(from: from, photo: photo)
  }
}
