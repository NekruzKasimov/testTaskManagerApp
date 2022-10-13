//
//  MainPageViewController.swift
//  TestTaskManagerApp
//
//  Created by Niko on 11.10.22.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

private struct ConstantValues {
    static let mainCellReuseIdentifier = "MainCell"
}

protocol IMainScreen: AnyObject {
    var viewModel: IMainPageViewModel! { get set }
}

typealias IMainPageViewController = BaseViewController & IMainScreen

class MainPageViewController: IMainPageViewController {
    var viewModel: IMainPageViewModel!
    let tableView = UITableView()
    var tasks = [TaskModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bind()
    }
    
    func bind() {
        let input = MainPageViewModel.Input(
            viewWillAppear: rx.viewWillAppear.asSignal(),
            itemSelected: tableView.rx.itemSelected.asSignal())
        
        let output = viewModel.transform(input)
        
        disposeBag.insert([
            output.result.emit(onNext: { [unowned self] taskModels in
                self.tasks = taskModels
                self.tableView.reloadData()
            })
        ])
    }
    
    func setupView() {
        view.backgroundColor = .white
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: ConstantValues.mainCellReuseIdentifier)
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension MainPageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ConstantValues.mainCellReuseIdentifier, for: indexPath) as! MainTableViewCell
        cell.setTask(tasks[indexPath.row])
        return cell
    }
}
