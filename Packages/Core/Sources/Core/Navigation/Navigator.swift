//
//  Navigator.swift
//  Core
//
//  Created by Luthfi Asmara on 13/11/25.
//

import Foundation
import UIKit

public enum NavigationBehavior {
  case push(animated: Bool)
  case present(animated: Bool)
  case replace
  case replaceRoot
}

public protocol Navigator {
  var viewController: UIViewController { get }
  var behavior: NavigationBehavior { get }
}

public protocol InitialNavigator {
  var viewController: UIViewController { get }
}

public extension Navigator {
  func navigate(from viewController: UIViewController) {
    let destination = self.viewController
    switch behavior {
    case .push(let animated):
      viewController.navigationController?.pushViewController(destination, animated: animated)
    case .present(let animated):
      viewController.present(destination, animated: animated, completion: nil)
    case .replace:
      if var stack = viewController.navigationController?.viewControllers {
        stack.removeLast()
        stack.append(destination)
        viewController.navigationController?.viewControllers = stack
      }
    case .replaceRoot:
      viewController.view.window?.rootViewController = destination
    }
  }
  
  func back(from: UIViewController) {
    switch behavior {
    case .push(let animated):
      from.navigationController?.popViewController(animated: animated)
    case .present(let animated):
      from.dismiss(animated: animated, completion: nil)
    case .replace:
      from.navigationController?.popViewController(animated: false)
    case .replaceRoot:
      print("Can not back. This is root view controller")
    }
  }
}

public extension InitialNavigator {
  func navigate(from window: UIWindow?) {
    window?.rootViewController = viewController
  }
}
