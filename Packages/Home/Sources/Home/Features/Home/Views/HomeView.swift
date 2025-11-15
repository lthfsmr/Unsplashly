//
//  HomeView.swift
//  Home
//
//  Created by Luthfi Asmara on 15/11/25.
//

import SwiftUI
import CommonUI
import Common

struct HomeView: WrappedView {
  var holder: WrapperHolder = WrapperHolder()
  var navigator: HomeNavigator
  @StateObject private var viewModel: HomeViewModel
  
  init(
    navigator: HomeNavigator,
    viewModel: HomeViewModel
  ) {
    self.navigator = navigator
    _viewModel = StateObject(wrappedValue: viewModel)
  }
  
  var body: some View {
    ZStack {
      VStack(alignment: .leading, spacing: 12){
        Text("Unsplashly")
          .font(.largeTitle)
          .fontWeight(.bold)
          .padding(.horizontal, 12)
        
        TextField("Search photo...", text: $viewModel.currentQuery)
          .padding(10)
          .background(Color(.systemGray6))
          .cornerRadius(8)
          .padding(.horizontal, 12)
        
        ScrollViewReader { proxy in
          ScrollView {
            LazyVStack {
              Color.clear
                .frame(height: 1)
                .id("top")
              
              FlowLayout(viewModel.photos, columns: 2) { photo in
                WebImage(
                  url: photo.urls?.thumb ?? "",
                  width: photo.width ?? 0,
                  height: photo.height ?? 0,
                  onTapPhotoHandler: {
                    guard let viewController = holder.viewController else { return }
                    navigator.navigateToPhotoDetail(
                      from: viewController,
                      photo: photo
                    )
                  }
                )
                .cornerRadius(16)
                .onAppear {
                  if viewModel.photos.last?.id == photo.id && viewModel.isLoadMore && !viewModel.isOffline {
                    let isQueryEmpty = viewModel.currentQuery.isEmpty
                    viewModel.searchPhoto(
                      query: isQueryEmpty ? viewModel.initialQuery : viewModel.currentQuery,
                      page: viewModel.currentPage
                    )
                  }
                }
              }
            }
          }
          .onChange(of: viewModel.currentQuery) { newValue in
            withAnimation {
              proxy.scrollTo("top", anchor: .top)
            }
          }
        }
      }
      
      VStack {
        Spacer()
        if viewModel.photos.isEmpty && !viewModel.isLoading && !viewModel.currentQuery.isEmpty {
          Text("🙁 There is no photo with keywords: \(viewModel.currentQuery)")
            .foregroundColor(.black)
            .font(.headline)
        }
        Spacer()
      }
    }
    .onAppear {
      viewModel.searchPhoto(query: viewModel.initialQuery)
    }
    .dataState(
      state: viewModel.photo,
      onFailed: { error in
        viewModel.errorMessage = error.mapToGeneralError().errorMessage
        viewModel.shouldShowAlert = true
      }
    )
    .onChange(of: viewModel.isOffline) { isOffline in
      if isOffline {
        viewModel.errorMessage = GeneralError.noInternetConnection.errorMessage
        viewModel.shouldShowAlert = true
        viewModel.loadLocalPhotos()
      }
    }
    .alert(isPresented: $viewModel.shouldShowAlert) {
      Alert(
        title: Text("Error"),
        message: Text(viewModel.errorMessage),
        dismissButton: .default(Text("OK"))
      )
    }
  }
}
