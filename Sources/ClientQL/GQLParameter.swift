//
//  File.swift
//  
//
//  Created by BJ Beecher on 5/5/21.
//

import Foundation

public struct GQLParameter {
    let name : String
    let value : GQLType
    
    public init(name: String, value: GQLType) {
        self.name = name
        self.value = value
    }
}

// hashable conformance

extension GQLParameter : Hashable {
    public static func == (lhs: GQLParameter, rhs: GQLParameter) -> Bool {
        lhs.name == rhs.name && lhs.value.data() == rhs.value.data()
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(value.data())
    }
}
