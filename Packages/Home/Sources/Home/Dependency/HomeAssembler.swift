//
//  HomeAssembler.swift
//  Home
//
//  Created by Luthfi Asmara on 13/11/25.
//


import Common
import CommonUI
import Foundation

protocol HomeAssembler {
  func navigator() -> HomeNavigator
  func view() -> HomeViewController
  func viewModel() -> HomeViewModel
}

extension HomeAssembler where Self: Assembler {
  func navigator() -> any HomeNavigator {
    return DefaultHomeNavigator(assembler: self, launcher: launcher)
  }
  
  func view() -> HomeViewController {
    return HomeViewController(navigator: navigator(), viewModel: viewModel())
  }
  
  func viewModel() -> HomeViewModel {
    return HomeViewModel(getPhotosUseCase: useCase())
  }
}
