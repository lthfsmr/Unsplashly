//
//  HomeViewController.swift
//  Home
//
//  Created by Luthfi Asmara on 13/11/25.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
  private let navigator: HomeNavigator
  
  init(navigator: HomeNavigator) {
    self.navigator = navigator
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "Home"
    label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
    label.textColor = .black
    label.textAlignment = .center
    return label
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    configureViews()
  }
  
  private func configureViews() {
    view.addSubview(titleLabel)
    
    titleLabel.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }
}
