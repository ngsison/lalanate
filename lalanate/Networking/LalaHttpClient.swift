//
//  LalaHttpClient.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/11/20.
//

import Moya
import RxSwift

public typealias Transformer<T> = (Response) throws -> T

public class LalaHttpClient {
  
  // MARK: - Public Props
  
  public var provider: MoyaProvider<MultiTarget>
  
  // MARK: - Private Props
  
  private let disposeBag = DisposeBag()
  
  // MARK: - Lifecycle Events
  
  public init(plugins: [PluginType] = [PluginType]()) {
    provider = MoyaProvider<MultiTarget>(plugins: plugins)
  }
  
  // MARK: - Public Methods
  
  /**
   Performs a request against the given `target`.
   
   - Parameter target: Preferred `Target` that conforms to `TargetType`
   - Parameter transformer: Closure that accepts a `Moya.Response` and returns it as an object of type `T`.
   May throw an error if the response object can't be transformed properly.
   
   - Returns: An observable of which type is defined by the transformer.
   
   - Note: The closure `transformer` would only be executed if the request is successful.
   */
  
  public func request<T>(target: TargetType,
                         transformer: @escaping Transformer<T>) -> Observable<T> {
    
    return Observable.create { [unowned self] (observer) -> Disposable in
      
      let multiTarget = MultiTarget(target)
      
      self.provider
        .rx
        .request(multiTarget)
        .filterSuccessfulStatusCodes()
        .subscribe(onSuccess: { (response: Response) in
          do {
            let transformedObject = try transformer(response)
            observer.onNext(transformedObject)
          } catch {
            observer.onError(MoyaError.objectMapping(error, response))
          }
        }, onError: { (error: Error) in
          observer.onError(error)
        }).disposed(by: self.disposeBag)
      
      return Disposables.create()
    }
  }
  
  /**
   Fake MoyaProvider.
   
   - Note: Usage: htttpClient.provider = LalaHttpClient.fakeMoyaProvider()
   */
  
  public static func fakeMoyaProvider(statusCode: Int = 200,
                                      responseDelay: Double = 0,
                                      data: Data = Data()) -> MoyaProvider<MultiTarget> {
    
    let endpointClosure = { (target: MultiTarget) -> Endpoint in
      
      let fullURL = target.baseURL.appendingPathComponent(target.path).absoluteString
      
      let sampleResponseClosure = {
        return EndpointSampleResponse.networkResponse(statusCode,
                                                      data.isEmpty ? target.sampleData : data)
      }
      
      return Endpoint(url: fullURL,
                      sampleResponseClosure: sampleResponseClosure,
                      method: target.method,
                      task: target.task,
                      httpHeaderFields: nil)
    }
    
    let stubClosure = { (_: MultiTarget) -> Moya.StubBehavior in
      return responseDelay == 0
        ? .immediate
        : .delayed(seconds: responseDelay)
    }
    
    let fakeMoyaProvider = MoyaProvider<MultiTarget>(endpointClosure: endpointClosure,
                                                     stubClosure: stubClosure)
    
    return fakeMoyaProvider
  }
}
