//
//  MainView.swift
//  ReadWriteSendApp
//
//  Created by macuser on 06.12.2021.
//  
//

import UIKit


// MARK: - MainViewDelegate
protocol MainViewDelegate: class {
  func viewSomeAction(view: MainViewProtocol)
}

// MARK: - MainViewProtocol
protocol MainViewProtocol: UIView {
  var delegate: MainViewDelegate? { get set }
}

// MARK: - MainView
class MainView: UIView, MainViewProtocol {
  
  // MARK: - MainView interface methods
  weak var delegate: MainViewDelegate?
  
  // MARK: - Overrided methods
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  // MARK: - IBActions
  func someButtonAction() {
    
    self.delegate?.viewSomeAction(view: self)
  }
}
