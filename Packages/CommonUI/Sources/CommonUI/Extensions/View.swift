//
//  View.swift
//  CommonUI
//
//  Created by Luthfi Asmara on 16/11/25.
//

import SwiftUI
import Core

extension View {
  public func showLoading() {
    let loading = CommonLoadingView()
    loading.show()
  }

  public func dismissLoading(willDismissQueue: Bool = false) {
    let loading = CommonLoadingView()
    delay(bySeconds: 0.5) {
      loading.dismiss(willDismissQueue: willDismissQueue)
    }
  }
}
