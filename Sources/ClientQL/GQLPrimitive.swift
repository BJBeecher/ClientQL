//
//  File.swift
//  
//
//  Created by BJ Beecher on 5/12/21.
//

import Foundation

public protocol GQLPrimitive : GQLType {
    init()
}

// conformance

extension String : GQLPrimitive {}

extension UUID : GQLPrimitive {}

extension Int : GQLPrimitive {}

extension Float : GQLPrimitive {}

extension Double : GQLPrimitive {}

extension Bool : GQLPrimitive {}

extension Date : GQLPrimitive {}
