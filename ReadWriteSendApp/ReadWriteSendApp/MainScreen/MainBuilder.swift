//
//  MainBuilder.swift
//  ReadWriteSendApp
//
//  Created by macuser on 06.12.2021.
//  
//

import UIKit


class MainBuilder: NSObject {
  class func viewController() -> MainViewController {
    let view: MainViewProtocol = MainView.create() as  MainViewProtocol
    let model: MainModelProtocol = MainModel()
    let viewController = MainViewController(withView: view, model: model)
    return viewController
  }
}

