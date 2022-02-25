//
//  CounterViewController.swift
//  MVVMRxSwiftTest
//
//  Created by 이건준 on 2022/02/25.
//

import UIKit
import RxSwift
import RxCocoa

final class CounterViewController: UIViewController {
    
    let countLabel = UILabel()
    let plusButton = UIButton(type: .system)
    let substractButton = UIButton(type: .system)
    
    var disposeBag = DisposeBag()
    var viewModel = CounterViewModel()
    
    private lazy var input = CounterViewModel.Input(plusAction: plusButton.rx.tap.asObservable(), subtractAction: substractButton.rx.tap.asObservable())
    
    private lazy var output = viewModel.transform(input: input)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        attribute()
        bindViewModel()
    }
    
    func layout() {
        view.addSubview(countLabel)
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        countLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(plusButton)
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.centerYAnchor.constraint(equalTo: countLabel.centerYAnchor).isActive = true
        plusButton.leftAnchor.constraint(equalTo: countLabel.rightAnchor).isActive = true
        
        view.addSubview(substractButton)
        substractButton.translatesAutoresizingMaskIntoConstraints = false
        substractButton.rightAnchor.constraint(equalTo: countLabel.leftAnchor).isActive = true
    }
    
    func attribute() {
        countLabel.text = "0"
        substractButton.setTitle("-", for: .normal)
        plusButton.setTitle("+", for: .normal)
    }
    
    private func bindViewModel() {
        output.countedValue.map{ String($0) }.drive(countLabel.rx.text).disposed(by: disposeBag)
    }
}
