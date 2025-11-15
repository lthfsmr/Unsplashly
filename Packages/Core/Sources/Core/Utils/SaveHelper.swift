//
//  SaveHelper.swift
//  Core
//
//  Created by Luthfi Asmara on 16/11/25.
//

import UIKit

final public class SaveHelper: NSObject {
  public static let shared = SaveHelper()
  public var onComplete: ((Error?) -> Void)?
  
  @objc public func saveCompleted(_ image: UIImage,
                           didFinishSavingWithError error: Error?,
                           contextInfo: UnsafeRawPointer) {
    onComplete?(error)
  }
}
