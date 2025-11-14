//
//  ModuleManager.swift
//  Core
//
//  Created by Luthfi Asmara on 13/11/25.
//

import UIKit

public class ModuleManager {
  private var launchables: [Launchable] = []
  private weak var launcher: Launching?
  
  public init(launcher: Launching) {
    self.launcher = launcher
  }
  
  public func register(launchables: [Launchable]) {
    self.launchables.append(contentsOf: launchables)
    self.launchables.forEach({ $0.launcher = launcher })
  }
  
  public func launch(from window: UIWindow?, options: LaunchOptions) {
    guard let initialModule = launchables.compactMap({ $0 as? InitialLaunchable }).first else {
      return
    }
    initialModule.launch(in: window, options: options)
  }
  
  public func launchModule(identifier: ModuleIdentifier, in viewController: UIViewController, options: LaunchOptions) {
    guard let module = launchables.first(where: { $0.identifier == identifier }) else {
      print("Unknown Module: can not find the module with matching identifier")
      return
    }
    module.launch(in: viewController, options: options)
  }
  
  public func backToModule(identifier: ModuleIdentifier, from viewController: UIViewController, to destination: String) {
    guard let module = launchables.first(where: { $0.identifier == identifier }) else {
      print("Unknown Module: can not find the module with matching identifier")
      return
    }
    module.back(from: viewController, to: destination)
  }
  
  public func getLandingViewController(identifier: ModuleIdentifier, options: LaunchOptions) -> UIViewController? {
    guard let module = launchables.filter({ $0.identifier == identifier }).first else {
      print("Unknown Module: can not find the module with matching identifier")
      return nil
    }
    return module.landingViewController(with: options)
  }
}
