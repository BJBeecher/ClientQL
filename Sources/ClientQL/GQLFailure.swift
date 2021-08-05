//
//  File.swift
//  
//
//  Created by BJ Beecher on 2/12/21.
//

public enum GQLFailure : Error {
    case encodingError
    case decodingError
    case missingResponseData
    case queryFailures(_ errors: [Error])
}
