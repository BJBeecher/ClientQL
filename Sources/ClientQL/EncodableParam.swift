//
//  File.swift
//  
//
//  Created by BJ Beecher on 5/5/21.
//

import Foundation

struct EncodableParam : Encodable {
    let value : Encodable
    
    func encode(to encoder: Encoder) throws {
        try value.encode(to: encoder)
    }
}
