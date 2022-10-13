//
//  MainTableViewCell.swift
//  TestTaskManagerApp
//
//  Created by Niko on 13.10.22.
//

import Foundation
import UIKit
import SnapKit

class MainTableViewCell: UITableViewCell {
    let titleLabel = UILabel()
    let messageLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTask(_ task: TaskModel) {
        self.titleLabel.text = task.title
        self.messageLabel.text = task.message
    }
    
    private func setupView() {
        self.selectionStyle = .none
        titleLabel.text = R.string.localizable.mainCellTitlePlaceholder()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        messageLabel.text = R.string.localizable.mainCellContentPlaceholder()
        messageLabel.numberOfLines = 3
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(messageLabel)
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.bottom.equalToSuperview().offset(-20)
        }
    }
}
