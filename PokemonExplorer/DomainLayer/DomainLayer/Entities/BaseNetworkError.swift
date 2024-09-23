//
//  BaseNetworkError.swift
//  DomainLayer
//
//  Created by Alexandros Alexandrov on 23/9/24.
//

import Foundation
import Alamofire

public struct BaseNetworkError: Error {
    public let initialError: AFError
    public let backendError: BackendError?
    
    public init(initialError: AFError, backendError: BackendError?) {
        self.initialError = initialError
        self.backendError = backendError
    }
}

public struct BackendError: Codable, Error {
    public var success: Bool
    public var errorCode: String?
    
    enum CodingKeys: String, CodingKey {
        case success = "Success"
        case errorCode = "ErrorCode"
    }
}
