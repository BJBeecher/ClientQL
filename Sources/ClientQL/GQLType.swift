//
//  File.swift
//  
//
//  Created by BJ Beecher on 5/14/21.
//

import Foundation

public protocol GQLType : Codable {
    static var graphQLTypeName : String { get }
}

// conformance

extension String : GQLType {
    public static let graphQLTypeName = "String!"
}

extension UUID : GQLType {
    public static let graphQLTypeName = "ID!"
}

extension Int : GQLType {
    public static let graphQLTypeName = "Int!"
}

extension Float : GQLType {
    public static let graphQLTypeName = "Float!"
}

extension Double : GQLType {
    public static let graphQLTypeName = "Float!"
}

extension Bool : GQLType {
    public static let graphQLTypeName = "Boolean!"
}

extension Optional : GQLType where Wrapped : GQLType {
    public static var graphQLTypeName : String {
        "\(Wrapped.graphQLTypeName.dropLast())"
    }
}

extension Array : GQLType where Element : GQLType {
    public static var graphQLTypeName : String {
        "[\(Element.graphQLTypeName)]!"
    }
}

extension Set : GQLType where Element : GQLType {
    public static var graphQLTypeName : String {
        "[\(Element.graphQLTypeName)]!"
    }
}

