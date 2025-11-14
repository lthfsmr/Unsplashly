//
//  SplashAssembler.swift
//  Home
//
//  Created by Luthfi Asmara on 13/11/25.
//

import Common
import CommonUI
import Foundation

protocol SplashAssembler {
  func navigator() -> SplashNavigator
  func view() -> SplashViewController
}

extension SplashAssembler where Self: Assembler {
  func navigator() -> any SplashNavigator {
    return DefaultSplashNavigator(assembler: self, launcher: launcher)
  }
  
  func view() -> SplashViewController {
    return SplashViewController(navigator: navigator())
  }
}
