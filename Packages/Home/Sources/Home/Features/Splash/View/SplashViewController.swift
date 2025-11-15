//
//  SplashViewController.swift
//  Home
//
//  Created by Luthfi Asmara on 13/11/25.
//

import UIKit
import SnapKit
import Core

class SplashViewController: UIViewController {
  private let navigator: SplashNavigator
  
  init(navigator: SplashNavigator) {
    self.navigator = navigator
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = InfoPlistKey.appName.configValue
    label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
    label.textColor = .white
    label.textAlignment = .center
    return label
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .black
    configureViews()
    startTimer()
  }
  
  private func configureViews() {
    view.addSubview(titleLabel)
    
    titleLabel.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }
  
  private func startTimer() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
      guard let self = self else { return }
      navigator.navigateToHome(from: self)
    }
  }
}
