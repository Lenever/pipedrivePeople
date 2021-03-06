//
//  UIViewController+Extension.swift
//  PipedrivePeoples
//
//  Created by Ikechukwu Onuorah on 05/02/2022.
//

import UIKit

extension UIViewController {
  func handleNetworkError(prompt: String) {
    let alert = UIAlertController(title: "⚠️", message: prompt, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
}
