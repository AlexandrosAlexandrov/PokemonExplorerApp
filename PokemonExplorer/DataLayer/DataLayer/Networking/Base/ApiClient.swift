//
//  ApiClient.swift
//  DataLayer
//
//  Created by Alexandros Alexandrov on 23/9/24.
//

import Foundation
import Alamofire
import Combine
import DomainLayer

public class ApiClient {
    static let session: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 60
        return Session(configuration: configuration)
    }()
    
    public init() {
        
    }
    
    static func requestCodable<T: Decodable>(_ urlConvertible: URLRequestConvertible, shouldUseInterceptor: Bool = true) -> AnyPublisher<DataResponse<T, BaseNetworkError>, Never> {
        
        
        return session
            .request(urlConvertible)
            .validate()
            .publishDecodable(
                type: T.self,
                emptyResponseCodes: [200]
            )
            .map { response in
                response.mapError { error in
                    let backendError = response.data.flatMap {
                        try? JSONDecoder().decode(BackendError.self, from: $0)
                    }
                    
                    return BaseNetworkError(
                        initialError: error,
                        backendError: backendError
                    )
                }
            }
            .receive(
                on: DispatchQueue.main
            )
            .eraseToAnyPublisher()
    }
}
