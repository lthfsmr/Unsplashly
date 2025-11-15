//
//  WebImage.swift
//  Home
//
//  Created by Luthfi Asmara on 15/11/25.
//

import SwiftUI
import Combine
import Common

struct WebImage: View {
  @StateObject private var loader: ImageLoader
  private let placeholder: AnyView
  private let image: (Image) -> AnyView
  private let width: Int?
  private let height: Int?
  private let onTapPhotoHandler: (() -> Void)?
  
  init(
    url: String?,
    width: Int? = nil,
    height: Int? = nil,
    @ViewBuilder image: @escaping (Image) -> AnyView = { AnyView($0.resizable()) },
    @ViewBuilder placeholder: @escaping () -> AnyView = {
      AnyView(
        ZStack {
          Color.black.opacity(0.5)
          ProgressView()
        }
      )
    },
   onTapPhotoHandler: (() -> Void)? = nil

  ) {
    _loader = StateObject(wrappedValue: ImageLoader(url: url))
    self.image = image
    self.placeholder = placeholder()
    self.width = width
    self.height = height
    self.onTapPhotoHandler = onTapPhotoHandler
  }
  
  var body: some View {
    content
      .aspectRatio(aspectRatio, contentMode: .fit)
      .onAppear(perform: loader.load)
      .onTapGesture {
        onTapPhotoHandler?()
      }
  }
  
  private var content: some View {
    Group {
      if let uiImage = loader.image {
        image(Image(uiImage: uiImage))
      } else if loader.isLoading {
        placeholder
      } else {
        AnyView(
          ZStack {
            Color.black.opacity(0.1)
            Image(systemName: "photo")
              .font(.system(size: 24))
              .foregroundColor(.white)
          }
        )
      }
    }
  }
  
  private var aspectRatio: CGFloat {
    guard let width = width, let height = height, height > 0 else { return 1 }
    return CGFloat(width) / CGFloat(height)
  }
}

final class ImageLoader: ObservableObject {
  @Published var image: UIImage?
  @Published var isLoading = false
  
  private let url: String?
  private var cancellable: AnyCancellable?
  
  init(url: String?) {
    self.url = url
  }
  
  func load() {
    guard !isLoading else { return }
    guard let urlString = url, let url = URL(string: urlString) else { return }
    
    isLoading = true
    
    cancellable = URLSession.shared.dataTaskPublisher(for: url)
      .map { UIImage(data: $0.data) }
      .replaceError(with: nil)
      .receive(on: DispatchQueue.main)
      .sink { [weak self] uiImage in
        self?.image = uiImage
        self?.isLoading = false
      }
  }
  
  deinit {
    cancellable?.cancel()
  }
}
