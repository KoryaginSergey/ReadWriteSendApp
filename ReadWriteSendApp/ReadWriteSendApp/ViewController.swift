//
//  ViewController.swift
//  ReadWriteSendApp
//
//  Created by macuser on 26.11.2021.
//

import UIKit
import MessageUI


class ViewController: UIViewController {
  
  @IBOutlet weak private var textField: UITextField!
  @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak private var textView: UITextView!
  
  private let cleanString = ""
  private let delayTime: Double = 1
  private let someString = "Super long string here"
  private let nameTextForRead = "text"
  private let mimeType = "text/plain"
  private let errorString = "Failed!"
  private let mailForSend = "koryagin.s.work@gmail.com"
  private let subjectForMail = "Device characteristics"
  private let nameFileForSend = "Device characteristics"
  private let formatFileForSend = "txt"
  private var fullNameFileForSend: String {
    "\(nameFileForSend).\(formatFileForSend)"
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.textField.delegate = self
    activityIndicator.isHidden = true
    setupGestureRecognizers()
  }
  
  @objc func tapGesture() {
    view.endEditing(true)
  }
  
  //MARK: - IBActions
  @IBAction func writeInFile(_ sender: Any) {
    textView.text = cleanString
    showActivityIndicator()
    timeLapseForWriting()
  }
  
  @IBAction func sendMessage(_ sender: Any) {
    textView.text = cleanString
    showActivityIndicator()
    timeLapseForWriting()
    sendEmail()
  }
  
  @IBAction func readFromFile(_ sender: Any) {
    textView.text = cleanString
    showActivityIndicator()
    perform(#selector(timeLapseForReading), with: nil, afterDelay: delayTime)
  }
}

//MARK: - MFMailComposeViewControllerDelegate
extension ViewController: MFMailComposeViewControllerDelegate {
  func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
    controller.dismiss(animated: true)
  }
}

//MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
  }
}

//MARK: - Private extension
private extension ViewController {
  func readTextFromFile() {
    if let path = Bundle.main.path(forResource: nameTextForRead, ofType: formatFileForSend) {
      if let text = try? String(contentsOfFile: path) {
        textView.text = text
      }
    }
  }
  
  func writeTextInFile() {
    let namePhone = UIDevice.current.name
    let systemVersionPhone = UIDevice.current.systemVersion
    let systemNamePhone = UIDevice.current.systemName
    UIDevice.current.isBatteryMonitoringEnabled = true
    let batteryLevelPhone = UIDevice.current.batteryLevel
    let modelPhone = UIDevice.current.model
    
    let stringForDeviceCharacteristics = """
      Phone name: \(namePhone)
      Phone model: \(modelPhone)
      Battery level: \(batteryLevelPhone)
      System name: \(systemNamePhone)
      System version: \(systemVersionPhone)
    """
    textView.text = stringForDeviceCharacteristics
    
    let filename = getDocumentsDirectory().appendingPathComponent(fullNameFileForSend)
    do {
      try stringForDeviceCharacteristics.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
    } catch {
      print(errorString)
    }
  }
  
  @objc func timeLapseForReading() {
      self.activityIndicator.stopAnimating()
      self.activityIndicator.isHidden = true
      self.readTextFromFile()
  }
  
  func timeLapseForWriting() {
    DispatchQueue.main.asyncAfter(deadline: .now() + delayTime) {
      self.activityIndicator.stopAnimating()
      self.activityIndicator.isHidden = true
      self.writeTextInFile()
    }
  }
  
  func showActivityIndicator() {
    activityIndicator.isHidden = false
    activityIndicator.color = UIColor.red
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
  
  func showAlert() {
    let alert = UIAlertController(title: "ATTENTION", message: "Sign in to your account",
                                  preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
    }))
    self.present(alert, animated: true, completion: nil)
  }
  
  func sendEmail() {
    if MFMailComposeViewController.canSendMail() {
      let mail = MFMailComposeViewController()
      mail.mailComposeDelegate = self
      mail.setToRecipients([mailForSend])
      mail.setSubject(subjectForMail)
      mail.setMessageBody("<p>Hello world!</p>", isHTML: true)
      let fileURL = getDocumentsDirectory().appendingPathComponent(fullNameFileForSend)
      guard let data = try? Data(contentsOf: fileURL) else {return}
      mail.addAttachmentData(data, mimeType: mimeType, fileName: nameFileForSend)
      
      present(mail, animated: true)
    } else {
      print(errorString)
      showAlert()
    }
  }
}

