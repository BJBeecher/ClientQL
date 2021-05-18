//
//  File.swift
//  
//
//  Created by BJ Beecher on 2/12/21.
//

import Foundation

public struct GQLResponse<T: Codable> : Codable {
    let data : Success?
    let errors : [Failure]?
}

public extension GQLResponse {
    struct Success : Codable {
        let success : T
    }
    
    struct Failure : Error, Codable {
        let message : String
    }
}
