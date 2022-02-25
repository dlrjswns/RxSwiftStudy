//
//  CounterViewModel.swift
//  MVVMRxSwiftTest
//
//  Created by 이건준 on 2022/02/25.
//

import RxSwift
import RxCocoa

protocol ViewModelType: AnyObject {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

final class CounterViewModel: ViewModelType {
    
    let disposeBag = DisposeBag()
    
    struct Input {
        var plusAction: Observable<Void>
        var subtractAction: Observable<Void>
    }
    
    struct Output {
        var countedValue: Driver<Int>
    }
    
    func transform(input: Input) -> Output {
        let countedValue = BehaviorRelay(value: 0)
        
        input.plusAction.subscribe(onNext: { _ in
            countedValue.accept(countedValue.value + 1)
        }).disposed(by: disposeBag)
        
        input.subtractAction.subscribe(onNext: { _ in
            countedValue.accept(countedValue.value - 1)
        }).disposed(by: disposeBag)
        
        return Output(countedValue: countedValue.asDriver(onErrorJustReturn: 0))
    }
}
