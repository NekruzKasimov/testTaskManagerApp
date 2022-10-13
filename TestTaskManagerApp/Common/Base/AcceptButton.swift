//
//  AcceptButton.swift
//  TestTaskManagerApp
//
//  Created by Niko on 13.10.22.
//

import Foundation
import UIKit

final class AcceptButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        self.setTitle(R.string.localizable.acceptButtonTitle(), for: .normal)
        self.setTitleColor(.black, for: .normal)
        self.backgroundColor = .green
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
    }
}
