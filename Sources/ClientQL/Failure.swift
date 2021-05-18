//
//  File.swift
//  
//
//  Created by BJ Beecher on 2/12/21.
//

public enum Failure : Error {
    case encodingError
    case decodingError
    case missingResponseData
    case queryFailures(_ errors: [Error])
}
