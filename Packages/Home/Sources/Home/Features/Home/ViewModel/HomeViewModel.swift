//
//  HomeViewModel.swift
//  Home
//
//  Created by Luthfi Asmara on 14/11/25.
//

import UIKit
import Combine
import Core
import Common

class HomeViewModel: ObservableObject {
  @Published var photo: DataState<[Photo]> = .initiate
  @Published var photos: [Photo] = []
  @Published var photoFromLocal: [PhotoObject] = []
  @Published var isLoading = false
  @Published var isLoadMore = true
  @Published var isOffline = false
  
  var currentPage = 1
  @Published var initialQuery: String = "All"
  @Published var currentQuery: String = ""
  @Published var shouldShowAlert: Bool = false
  @Published var errorMessage: String = ""
  
  private let getPhotosUseCase: GetPhotosUseCase
  private let getPhotoOfflineUseCase: GetPhotoOfflineUseCase
  private let saveToLocalUseCase: SaveToLocalUseCase
  
  init(
    getPhotosUseCase: GetPhotosUseCase,
    getPhotoOfflineUseCase: GetPhotoOfflineUseCase,
    saveToLocalUseCase: SaveToLocalUseCase
  ) {
    self.getPhotosUseCase = getPhotosUseCase
    self.getPhotoOfflineUseCase = getPhotoOfflineUseCase
    self.saveToLocalUseCase = saveToLocalUseCase
    
    observeSearchValues()
  }
  
  private var cancellables = Set<AnyCancellable>()
  
  func searchPhoto(query: String, page: Int = 1) {
    photo = .loading
    getPhotosUseCase.execute(request: SearchPhotosRequest(query: query, page: page))
      .receive(on: DispatchQueue.main)
      .sink { [weak self] completion in
        guard let self else { return }
        if case .failure(let error) = completion {
          if case .noInternetConnection = error.mapToGeneralError()  {
            DispatchQueue.main.async {
              self.isOffline = true
            }
            return
          }
          photo = .failed(reason: error)
            
        }
        isLoading = false
      } receiveValue: { [weak self] newPhotos in
        guard let self else { return }
        if newPhotos.isEmpty {
          self.isLoadMore = false
        } else {
          self.photos.append(contentsOf: newPhotos)
          self.currentPage += 1
        }
        photo = .success(data: newPhotos)
        
        if photoFromLocal.isEmpty {
          saveToLocalUseCase.execute(photo: newPhotos)
        }
        isLoading = false
      }
      .store(in: &cancellables)
  }
  
  func loadLocalPhotos() {
    getPhotoOfflineUseCase .execute()
      .receive(on: DispatchQueue.main)
      .sink { _ in } receiveValue: { [weak self] localPhotos in
        guard let self = self else { return }
        self.photoFromLocal = localPhotos
        if self.photos.isEmpty {
          self.photos = localPhotos.map { photoObject in
            Photo(
              localId: photoObject.id,
              width: photoObject.width ?? 0,
              height: photoObject.height ?? 0,
              urls: PhotoURLs(
                regular: photoObject.imageUrl,
                thumb: photoObject.imageUrl
              )
            )
          }
        }
      }
      .store(in: &cancellables)
  }
  
  private func observeSearchValues() {
    $currentQuery
      .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
      .removeDuplicates()
      .sink { [weak self] query in
        guard let self = self, !isOffline else { return }
        self.resetAndSearch(query: !query.isEmpty ? query : initialQuery)
      }
      .store(in: &cancellables)
  }
  
  private func resetAndSearch(query: String) {
    photos.removeAll()
    isLoadMore = true
    currentPage = 1
    searchPhoto(query: query, page: currentPage)
  }
}
