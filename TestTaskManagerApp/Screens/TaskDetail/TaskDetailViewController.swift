//
//  TaskDetailViewController.swift
//  TestTaskManagerApp
//
//  Created by Niko on 13.10.22.
//

import Foundation
import UIKit
import SnapKit
import RxCocoa
import RxSwift

protocol ITaskDetailScreen: AnyObject {
    var viewModel: ITaskDetailViewModel! { set get }
}

typealias ITaskDetailViewController = BaseViewController & ITaskDetailScreen

class TaskDetailViewController: ITaskDetailViewController {
    var viewModel: ITaskDetailViewModel!
    let scrollView = UIScrollView()
    let titleLabel = UILabel()
    let messageLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bind()
    }
    
    func bind() {
        let input = TaskDetailViewModel.Input(viewWillAppear: rx.viewWillAppear.asSignal())
        
        let output = viewModel.transform(input)
        
        disposeBag.insert(output.task.emit(onNext: { [unowned self] taskModel in
            self.titleLabel.text = taskModel.title
            self.messageLabel.text = taskModel.message
        }))
    }
    
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(messageLabel)
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        messageLabel.numberOfLines = 0
        
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-20)
        }
    }
}
