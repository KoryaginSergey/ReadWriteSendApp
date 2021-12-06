//
//  MainModel.swift
//  ReadWriteSendApp
//
//  Created by macuser on 06.12.2021.
//  
//

import UIKit


// MARK: - MainModelDelegate
protocol MainModelDelegate: class {
  
}

// MARK: - MainModelProtocol
protocol MainModelProtocol: class {
  
  var delegate: MainModelDelegate? { get set }
}

// MARK: - MainModel
class MainModel: MainModelProtocol {
  
  // MARK: - MainModel methods
  weak var delegate: MainModelDelegate?
  
  /** Implement MainModel methods here */
  
  
  // MARK: - Private methods
  
  /** Implement private methods here */
  
}

