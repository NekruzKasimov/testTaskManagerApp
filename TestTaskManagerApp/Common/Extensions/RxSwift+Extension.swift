//
//  RxSwift+Extension.swift
//  TestTaskManagerApp
//
//  Created by Niko on 13.10.22.
//

import Foundation
import RxCocoa
import RxSwift

extension SharedSequenceConvertibleType where SharingStrategy == SignalSharingStrategy {
    func also<O: ObservableConvertibleType>(_ sideEffect: @escaping (_ element: Element) -> O) -> Signal<Element> {
        return self
            .flatMapLatest { element in
                sideEffect(element)
                    .asObservable()
                    .asSignal { _ in .never() }
                    .flatMapLatest { _ in .never() }
                    .startWith(element)
            }
    }
}

extension SharedSequenceConvertibleType where SharingStrategy == DriverSharingStrategy {
    func also<O: ObservableConvertibleType>(_ sideEffect: @escaping (_ element: Element) -> O) -> Driver<Element> {
        return self
            .flatMapLatest { element in
                sideEffect(element)
                    .asObservable()
                    .asDriver { _ in .never() }
                    .flatMapLatest { _ in .never() }
                    .startWith(element)
            }
    }
}
