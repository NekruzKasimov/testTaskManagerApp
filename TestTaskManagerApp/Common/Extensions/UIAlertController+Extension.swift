//
//  UIAlertController+Extension.swift
//  TestTaskManagerApp
//
//  Created by Niko on 13.10.22.
//

import Foundation
import UIKit

extension UIAlertController {
    func show(with message: String, from controller: UIViewController) {
        let alert = UIAlertController(title: R.string.localizable.alertTitle(), message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: R.string.localizable.alertOkActionTitle(), style: .default))
        controller.present(alert, animated: true)
    }
}
