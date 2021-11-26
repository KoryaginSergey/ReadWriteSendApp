//
//  ViewController.swift
//  ReadWriteSendApp
//
//  Created by macuser on 26.11.2021.
//

import UIKit


class ViewController: UIViewController {
  
  @IBOutlet weak var textTextField: UITextField!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var textView: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.textTextField.delegate = self
    activityIndicator.isHidden = true
    
  }
  
  @IBAction func writeInFile(_ sender: Any) {
    
  }
  
  @IBAction func sendMessage(_ sender: Any) {
    textView.text = ""
    showActivityIndicator()
    timeLapseForWriting()
  }
  
  @IBAction func readFromFile(_ sender: Any) {
    textView.text = ""
    showActivityIndicator()
    timeLapseForReading()
  }
}

extension ViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textTextField.resignFirstResponder()
  }
}

private extension ViewController {
  func readTextFromFile() {
    if let path = Bundle.main.path(forResource: "text", ofType: "txt") {
      if let text = try? String(contentsOfFile: path) {
        textView.text = text
      }
    }
  }
  
  func writeTextInFile() {
    let namePhone = UIDevice.current.name
    let systemVersionPhone = UIDevice.current.systemVersion
    let systemNamePhone = UIDevice.current.systemName
    let batteryLevelPhone = UIDevice.current.batteryLevel
    let modelPhone = UIDevice.current.model
    
    textView.text = """
  Phone name: \(namePhone)
  Phone model: \(modelPhone)
  Battery level: \(batteryLevelPhone)
  System name: \(systemNamePhone)
  System version: \(systemVersionPhone)
"""
  }
  
  func timeLapseForReading() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      self.activityIndicator.stopAnimating()
      self.activityIndicator.isHidden = true
      self.readTextFromFile()
    }
  }
  
  func timeLapseForWriting() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      self.activityIndicator.stopAnimating()
      self.activityIndicator.isHidden = true
      self.writeTextInFile()
    }
  }
  
  func showActivityIndicator() {
    activityIndicator.isHidden = false
    activityIndicator.color = UIColor.systemGray2
    activityIndicator.startAnimating()
  }
}

