//
//  File.swift
//  
//
//  Created by BJ Beecher on 5/18/21.
//

import Foundation

struct Payload : Encodable {
    let query : String
    let variables : [String : EncodableParam]?
}
