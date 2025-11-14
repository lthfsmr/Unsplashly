//
//  ModuleAssembler.swift
//  Home
//
//  Created by Luthfi Asmara on 13/11/25.
//

import Common
import Core
import Foundation

protocol Assembler: SplashAssembler,
                    HomeAssembler {
  var launcher: Launching? { get }
}

class ModuleAssembler: Assembler {
  var launcher: Launching?
}
