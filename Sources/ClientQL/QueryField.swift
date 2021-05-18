//
//  File.swift
//  
//
//  Created by BJ Beecher on 5/12/21.
//

import Foundation

struct QueryField {
    let name : String
    let type : GQLType
}

extension QueryField {
    indirect enum GQLType {
        case primitive(Primitive)
        case object(name: String, fields: [QueryField])
        case list(GQLType)
    }
}

extension QueryField.GQLType {
    enum Primitive: String {
        case int
        case string
        case double
        case bool
        case unsupportedType
        case unknown
        
        init(from type: String) {
            switch type {
            case "Int": self = .int
            case "String": self = .string
            case "Double": self = .double
            case "Bool": self = .bool
            case "Date", "URL": self = .unsupportedType
            default: self = .unknown
            }
        }
    }
}
