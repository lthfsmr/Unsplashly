//
//  PhotoDetailViewModel.swift
//  Home
//
//  Created by Luthfi Asmara on 15/11/25.
//

import UIKit
import Common
import Core

class PhotoDetailViewModel: ObservableObject {
  var photoItem: Photo?
  @Published var showAlert = false
  @Published var alertMessage = ""
  @Published var isLoading = false
  
  func saveToAlbum(_ image: UIImage) {
    UIImageWriteToSavedPhotosAlbum(
      image,
      SaveHelper.shared,
      #selector(SaveHelper.shared.saveCompleted(_:didFinishSavingWithError:contextInfo:)),
      nil
    )
    
    SaveHelper.shared.onComplete = { error in
      if let error = error {
        self.alertMessage = "Failed to save photo: \(error.localizedDescription)"
      } else {
        self.isLoading = false
        self.alertMessage = "Photo saved to your gallery!"
      }
      self.showAlert = true
    }
  }
  
  func downloadImage() {
    isLoading = true
    guard let urlString = photoItem?.urls?.regular,
          let url = URL(string: urlString) else {
      self.alert("Invalid image URL.")
      return
    }
    
    let request = URLRequest(url: url)
    
    URLSession.shared.dataTask(with: request) { data, response, error in
      
      if let error = error {
        self.alert("Failed to download image: \(error.localizedDescription)")
        return
      }
      
      guard let data = data,
            let image = UIImage(data: data) else {
        self.alert("Failed to convert downloaded data to UIImage.")
        return
      }
      
      self.saveToAlbum(image)
      
    }.resume()
  }
  
  private func alert(_ message: String) {
    DispatchQueue.main.async {
      self.alertMessage = message
      self.showAlert = true
    }
  }
}
