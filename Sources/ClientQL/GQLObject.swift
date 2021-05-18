//
//  File.swift
//  
//
//  Created by BJ Beecher on 5/12/21.
//

import Foundation

public protocol GQLObject : GQLType, GQLGraphable {
    associatedtype Keys: CodingKey, Hashable

    init(from decoder: GQLDecoder<Keys>) throws
}

// extended functionality

extension GQLObject {
    public static var fields : String {
        let grapher = GraphingDecoder<Keys>()
        _ = try? Self(from: grapher)
        let fields = grapher.fields.map { generateField(name: $0.name, type: $0.type) }.joined(separator: " ")
        return "{ \(fields) }"
    }
    
    static private func generateField(name: String, type: QueryField.GQLType) -> String {
        switch type {
        case .primitive(_):
            return name
        case .object(name: _, fields: let fields):
            return "\(name) { \(fields.map { generateField(name: $0.name, type: $0.type) }.joined(separator: " ")) }"
        case .list(let type):
            return generateField(name: name, type: type)
        }
    }
    
    static public var graphQLTypeName: String {
        String(describing: type(of: self))
    }
}
