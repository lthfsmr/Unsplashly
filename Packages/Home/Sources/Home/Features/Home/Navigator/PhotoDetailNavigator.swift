//
//  PhotoDetailNavigator.swift
//  Home
//
//  Created by Luthfi Asmara on 15/11/25.
//

import Core
import Common
import UIKit

protocol PhotoDetailNavigator: Navigator {
  func navigateToPhotoDetail(from: UIViewController, photo: Photo)
}

struct DefaultPhotoDetailNavigator: PhotoDetailNavigator {
  private let assembler: Assembler
  private let launcher: Launching?

  init(assembler: Assembler, launcher: Launching?) {
    self.assembler = assembler
    self.launcher = launcher
  }
  
  var behavior: NavigationBehavior = .push(animated: true)
  
  var viewController: UIViewController {
    return UIViewController()
  }
  
  func navigateToPhotoDetail(from: UIViewController, photo: Photo) {
    let viewModel: PhotoDetailViewModel = assembler.viewModel()
    viewModel.photoItem = photo
    let nextView: PhotoDetailView = assembler.view(viewModel: viewModel)
    navigate(to: nextView.viewController, from: from)
  }
}
