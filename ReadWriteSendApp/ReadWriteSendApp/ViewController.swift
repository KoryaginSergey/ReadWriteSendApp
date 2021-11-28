//
//  ViewController.swift
//  ReadWriteSendApp
//
//  Created by macuser on 26.11.2021.
//

import UIKit
import MessageUI


final class ViewController: UIViewController {
  
  @IBOutlet weak private var textTextField: UITextField!
  @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak private var textView: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.textTextField.delegate = self
    activityIndicator.isHidden = true
    setupGestureRecognizers()
  }
  
  @objc func tapGesture() {
    view.endEditing(true)
  }
  
  @IBAction func writeInFile(_ sender: Any) {
    
//    sendEmail()
    
    let str = "Super long string here"
    let filename = getDocumentsDirectory().appendingPathComponent("output.txt")

    do {
      try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
    } catch {
      print("FAILED!")
      // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
    }
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

extension ViewController: MFMailComposeViewControllerDelegate {
  func sendEmail() {
    if MFMailComposeViewController.canSendMail() {
      let mail = MFMailComposeViewController()
      mail.mailComposeDelegate = self
      mail.setToRecipients(["you@yoursite.com"])
      mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
      
      present(mail, animated: true)
    } else {
      print("failed send")
      // show failure alert
    }
  }
  
  func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
    controller.dismiss(animated: true)
  }
}

//MARK: - Private extension
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
  
  func setupGestureRecognizers() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGesture))
    view.addGestureRecognizer(tapGesture)
  }
  
  func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }
}

