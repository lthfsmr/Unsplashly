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
  func navigator() -> PhotoDetailNavigator
  func view() -> HomeView
  func view(viewModel: PhotoDetailViewModel) -> PhotoDetailView
  func viewModel() -> HomeViewModel
  func viewModel() -> PhotoDetailViewModel
}

extension HomeAssembler where Self: Assembler {
  func navigator() -> HomeNavigator {
    return DefaultHomeNavigator(assembler: self, launcher: launcher)
  }
  
  func navigator() -> PhotoDetailNavigator {
    return DefaultPhotoDetailNavigator(assembler: self, launcher: launcher)
  }
  
  func view() -> HomeView {
    return HomeView(navigator: navigator(), viewModel: viewModel())
  }
  
  func view(viewModel: PhotoDetailViewModel) -> PhotoDetailView {
    return PhotoDetailView(
      navigator: navigator(),
      viewModel: viewModel
    )
  }
  
  func viewModel() -> HomeViewModel {
    return HomeViewModel(
      getPhotosUseCase: useCase(),
      getPhotoOfflineUseCase: useCase(),
      saveToLocalUseCase: useCase()
    )
  }
  
  func viewModel() -> PhotoDetailViewModel {
    return PhotoDetailViewModel()
  }
}
