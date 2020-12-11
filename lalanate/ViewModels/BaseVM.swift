//
//  BaseVM.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/11/20.
//

import Moya
import RxSwift
import RxCocoa

class BaseVM {
  
  // MARK: Public Props
  
  public let httpClient = LalaHttpClient()
  public let disposeBag = DisposeBag()
  
  public var isBusy = BehaviorRelay<Bool>(value: false)
  public var errorMessage = BehaviorRelay<String>(value: "")
  
  // MARK: - Public Methods
  
  public func toggleIsBusy(to isBusy: Bool) {
    self.isBusy.accept(isBusy)
    if isBusy {
      errorMessage.accept("")
    }
  }
  
  public func publishErrorMessage(_ errorMessage: String) {
    isBusy.accept(false)
    self.errorMessage.accept(errorMessage)
  }
}
