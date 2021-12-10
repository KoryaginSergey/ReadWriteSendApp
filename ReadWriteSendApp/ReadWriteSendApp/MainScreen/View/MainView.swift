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
  func writeDataInFile(view: MainViewProtocol)
  func sendFileToEmail(view: MainViewProtocol)
  func readDataFromFile(view: MainViewProtocol)
  func sendFileToStorage(view: MainViewProtocol)
}

// MARK: - MainViewProtocol
protocol MainViewProtocol: UIView {
  var delegate: MainViewDelegate? { get set }
}

// MARK: - MainView
class MainView: UIView, MainViewProtocol {
  
  @IBOutlet weak private var textField: UITextField!
  @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak private var textView: UITextView!
  
  
  
  // MARK: - MainView interface methods
  weak var delegate: MainViewDelegate?
  
  // MARK: - Overrided methods
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  // MARK: - IBActions
  @IBAction func writeButtonAction() {
    self.delegate?.writeDataInFile(view: self)
  }
  @IBAction func sendToEmailButtonAction() {
    self.delegate?.sendFileToEmail(view: self)
  }
  @IBAction func readButtonAction() {
    self.delegate?.readDataFromFile(view: self)
  }
  @IBAction func sendToStorageButtonAction() {
    self.delegate?.sendFileToStorage(view: self)
  }
}
