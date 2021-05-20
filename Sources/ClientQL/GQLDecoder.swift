//
//  File.swift
//  
//
//  Created by BJ Beecher on 5/12/21.
//

import Foundation

open class GQLDecoder<Keys: CodingKey> {
    public func from<T: Decodable & GQLPrimitive>(_ field: Keys, ofType: T.Type = T.self) throws -> T {
        fatalError()
    }

    public func objectFrom<T: GQLObject>(_ field: Keys, ofType: T.Type = T.self) throws -> T {
        fatalError()
    }

    public func objectsFrom<T: GQLObject>(_ field: Keys, ofType: T.Type = T.self) throws -> [T] {
        fatalError()
    }
}
