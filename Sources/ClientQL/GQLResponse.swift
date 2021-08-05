//
//  File.swift
//  
//
//  Created by BJ Beecher on 2/12/21.
//

import Foundation

public struct GQLResponse<T: Codable> : Codable {
    public let data : Success?
    public let errors : [Failure]?
}

public extension GQLResponse {
    struct Success : Codable {
        public let success : T
    }
    
    struct Failure : Error, Codable {
        public let message : String
    }
}
