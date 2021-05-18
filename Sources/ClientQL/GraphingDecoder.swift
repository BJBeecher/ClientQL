//
//  File.swift
//  
//
//  Created by BJ Beecher on 5/12/21.
//

import Foundation

class GraphingDecoder<Keys: CodingKey>: GQLDecoder<Keys> {
    
    var fields = [QueryField]()
    
    override func from<T: Decodable & GQLPrimitive>(_ key: Keys, ofType: T.Type = T.self) throws -> T {
        let typeName = "\(type(of: T.self))".replacingOccurrences(of: ".Type", with: "")
        let childField = QueryField(name: key.stringValue, type: .primitive(.init(from: typeName)))
        
        fields.append(childField)
        
        return T()
    }
    
    override func objectFrom<T: GQLObject>(_ key: Keys, ofType: T.Type = T.self) throws -> T {
        let childDecoder = GraphingDecoder<T.Keys>()
        let obj = try T(from: childDecoder)
        let objectWrappedGraph = QueryField(name: key.stringValue, type: .object(name: "\(T.self)", fields: childDecoder.fields))
        
        fields.append(objectWrappedGraph)
        
        return obj
    }
    
    override func objectsFrom<T: GQLObject>(_ key: Keys, ofType: T.Type = T.self) throws -> [T] {
        let childDecoder = GraphingDecoder<T.Keys>()
        let obj = try T(from: childDecoder)
        
        let arrayWrappedGraph = QueryField(name: key.stringValue, type: .list(.object(name: "\(T.self)", fields: childDecoder.fields)))
        
        fields.append(arrayWrappedGraph)
        
        return [obj]
    }
}
