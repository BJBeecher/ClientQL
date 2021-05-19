//
//  File.swift
//  
//
//  Created by BJ Beecher on 5/18/21.
//

import Foundation

struct EncodableValue : Encodable {
    let value : Encodable
    
    func encode(to encoder: Encoder) throws {
        try value.encode(to: encoder)
    }
}

struct Payload : Encodable {
    let query : String
    let variables : [String : EncodableValue]?
}
