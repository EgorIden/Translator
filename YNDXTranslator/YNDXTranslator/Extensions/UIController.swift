//
//  UIController.swift
//  YNDXTranslator
//
//  Created by Egor on 07/02/2021.
//  Copyright © 2021 Egor. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
  
  func showAlert(title: String = "Error", message: String = "Something went wrong", completion: Error? = nil) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: {_ in
      //completion?()
    }))
    present(alert, animated: true, completion: nil)
  }
}
