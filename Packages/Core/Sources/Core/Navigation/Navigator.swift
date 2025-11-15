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
  func navigate(to: UIViewController, from: UIViewController) {
    switch behavior {
    case .push(let animated):
      from.navigationController?.pushViewController(to, animated: animated)
    case .present(let animated):
      DispatchQueue.main.async {
        from.present(to, animated: animated, completion: nil)
      }
    case .replace:
      DispatchQueue.main.async {
        if var stack = from.navigationController?.viewControllers {
          stack.removeLast()
          stack.append(to)
          from.navigationController?.viewControllers = stack
        }
      }
    case .replaceRoot:
      DispatchQueue.main.async {
        UIApplication.shared.windows.first?.rootViewController = to
      }
    }
  }
  
  func navigate(from viewController: UIViewController) {
    let destination = self.viewController
    navigate(to: destination, from: viewController)
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
