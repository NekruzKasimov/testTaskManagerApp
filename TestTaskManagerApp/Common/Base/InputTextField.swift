//
//  InputTextField.swift
//  TestTaskManagerApp
//
//  Created by Niko on 13.10.22.
//

import Foundation
import UIKit

final class InputTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.setLeftPaddingPoints(10)
        self.setRightPaddingPoints(10)
    }
}
