//
//  File.swift
//  
//
//  Created by BJ Beecher on 2/12/21.
//
import Foundation

public struct GQLRequest<Response : GQLType> : Hashable {
    let rootType : RootType
    let field : String
    let parameters : [GQLParameter]?
    
    public init(_ rootType: RootType, field: String, parameters: [GQLParameter]? = nil){
        self.rootType = rootType
        self.field = field
        self.parameters = parameters
    }
}

extension GQLRequest {
    var title : String {
        field.prefix(1).capitalized + field.dropFirst()
    }
    
    var inlineParamaters : (title: String, field: String) {
        guard let parameters = parameters, !parameters.isEmpty else { return ("", "") }
        
        let inline = parameters.reduce((title: "", field: "")) { result, param in
            var title = result.title
            var field = result.field
            
            let key = param.name
            let value = param.value
            
            if !title.isEmpty { title.append(", ") }
            if !field.isEmpty { field.append(", ") }
            
            title.append("$\(key): \(value.graphQLType)")
            field.append("\(key): $\(key)")
            
            return (title, field)
        }
        
        return ("(\(inline.title))", "(\(inline.field))")
    }
    
    var variables : [String : EncodableValue]? {
        parameters?.reduce([String : EncodableValue]()) { result, item in
            var newResult = result
            let newValue = EncodableValue(value: item.value)
            newResult[item.name] = newValue
            return newResult
        }
    }
    
    var query : String {
        let params = inlineParamaters
        let titleParams = params.title
        let fieldParams = params.field
        
        if let fields = (Response.self as? GQLGraphable.Type)?.fields {
            return "\(rootType) \(title)\(titleParams) { success: \(field)\(fieldParams) \(fields) }"
        } else {
            return "\(rootType) \(title)\(titleParams) { success: \(field)\(fieldParams) }"
        }
    }
}
