//
//  File.swift
//  
//
//  Created by BJ Beecher on 5/14/21.
//

import Foundation

public protocol GQLGraphable {
    static var fields : String { get }
}

// conformance

extension Optional : GQLGraphable where Wrapped : GQLGraphable {
    public static var fields : String {
        Wrapped.fields
    }
}

extension Array : GQLGraphable where Element : GQLGraphable {
    public static var fields : String {
        Element.fields
    }
}

extension Set : GQLGraphable where Element : GQLGraphable {
    public static var fields : String {
        Element.fields
    }
}
