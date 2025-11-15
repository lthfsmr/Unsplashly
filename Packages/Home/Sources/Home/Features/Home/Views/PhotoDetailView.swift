//
//  PhotoDetailView.swift
//  Home
//
//  Created by Luthfi Asmara on 15/11/25.
//

import SwiftUI
import Core
import CommonUI

struct PhotoDetailView: WrappedView {
  var holder: WrapperHolder = WrapperHolder()
  var navigator: PhotoDetailNavigator
  @StateObject private var viewModel: PhotoDetailViewModel
  
  init(
    navigator: PhotoDetailNavigator,
    viewModel: PhotoDetailViewModel
  ) {
    self.navigator = navigator
    _viewModel = StateObject(wrappedValue: viewModel)
  }
  
  var body: some View {
    VStack {
      Spacer()
      if let url = viewModel.photoItem?.urls?.regular,
         let width = viewModel.photoItem?.width,
         let height = viewModel.photoItem?.height {
        WebImage(
          url: url,
          width: width,
          height: height
        )
      }
      
      Spacer()
      
      Button {
        viewModel.downloadImage()
      } label: {
        Text("Download")
          .fontWeight(.bold)
          .foregroundColor(.white)
          .padding(12)
          .frame(width: UIScreen.main.bounds.width - 32)
          .background(Color.black)
          .cornerRadius(8)
      }
    }
    .alert(isPresented: $viewModel.showAlert) {
      Alert(
        title: Text("Download"),
        message: Text(viewModel.alertMessage),
        dismissButton: .default(Text("OK"))
      )
    }
    .onChange(of: viewModel.isLoading) { isLoading in
      if isLoading {
        showLoading()
      } else {
        dismissLoading()
      }
    }
  }
}
