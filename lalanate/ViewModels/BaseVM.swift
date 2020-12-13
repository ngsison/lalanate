//
//  BaseVM.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/11/20.
//

import Moya
import RxCocoa
import RxSwift

class BaseVM {
  
  // MARK: Public Props
  
  public let httpClient = LalaHttpClient()
  public let disposeBag = DisposeBag()
  
  public var isBusy = BehaviorRelay<Bool>(value: false)
  public var errorMessage = BehaviorRelay<String>(value: "")
}
