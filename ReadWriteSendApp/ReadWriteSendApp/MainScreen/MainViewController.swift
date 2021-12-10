//
//  MainViewController.swift
//  ReadWriteSendApp
//
//  Created by macuser on 06.12.2021.
//  
//

import UIKit


// MARK: - MainViewController
class MainViewController: UIViewController {
    var model: MainModelProtocol

    fileprivate var tempView: MainViewProtocol?
    var customView: MainViewProtocol! {
        return self.view as? MainViewProtocol
    }

    // MARK: Initializers
    init(withView view: MainViewProtocol, model: MainModelProtocol) {
        self.model = model
        self.tempView = view
        super.init(nibName: nil, bundle: nil)
    }

    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("This class needs to be initialized with init(withView:model:) method")
    }

    // MARK: - View life cycle
    override func loadView() {
        super.loadView()

        self.view = self.tempView
        self.tempView = nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        customView.delegate = self
        model.delegate = self
    }

    // MARK: - Private methods
}

// MARK: - MainViewDelegate
extension MainViewController: MainViewDelegate {
  func writeDataInFile(view: MainViewProtocol) {
    <#code#>
  }
  
  func sendFileToEmail(view: MainViewProtocol) {
    <#code#>
  }
  
  func readDataFromFile(view: MainViewProtocol) {
    <#code#>
  }
  
  func sendFileToStorage(view: MainViewProtocol) {
    <#code#>
  }
  
   
}

// MARK: - MainModelDelegate
extension MainViewController: MainModelDelegate {

}
