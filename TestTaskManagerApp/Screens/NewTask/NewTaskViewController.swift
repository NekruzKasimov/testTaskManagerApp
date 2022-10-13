//
//  NewTaskViewController.swift
//  TestTaskManagerApp
//
//  Created by Niko on 13.10.22.
//

import Foundation
import UIKit
import SnapKit
import RxCocoa
import RxSwift

protocol INewTaskScreen: AnyObject {
    var viewModel: INewTaskViewModel! { set get }
}

typealias INewTaskViewController = BaseViewController & INewTaskScreen

class NewTaskViewController: INewTaskViewController {
    var viewModel: INewTaskViewModel!
    let titleTF = InputTextField()
    let messageTextView = UITextView()
    let acceptButton = AcceptButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bind()
    }
    
    func bind() {
        let input = NewTaskViewModel.Input(
            titleText: titleTF.rx.text.orEmpty.asDriver(),
            message: messageTextView.rx.text.orEmpty.asDriver(),
            acceptAction: acceptButton.rx.tap.asSignal())
        
        let output = viewModel.transform(input)
        
        disposeBag.insert(output.accepted.emit())
    }
    
    func setupView() {
        view.backgroundColor = .white
        messageTextView.layer.masksToBounds = true
        messageTextView.layer.cornerRadius = 5
        messageTextView.layer.borderColor = UIColor.gray.cgColor
        messageTextView.layer.borderWidth = 1
        
        let label = UILabel()
        label.text = R.string.localizable.newTaskCreateLabelText()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        view.addSubview(label)
        
        titleTF.placeholder = R.string.localizable.mainCellTitlePlaceholder()
        
        label.snp.makeConstraints {
            $0.top.equalToSuperview().offset(150)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        view.addSubview(titleTF)
        
        titleTF.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        view.addSubview(messageTextView)
        messageTextView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalTo(titleTF.snp.bottom).offset(20)
            $0.height.equalTo(300)
        }
        
        view.addSubview(acceptButton)
        acceptButton.snp.makeConstraints {
            $0.top.equalTo(messageTextView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
}
