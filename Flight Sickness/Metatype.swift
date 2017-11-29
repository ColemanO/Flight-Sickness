//
//  Metatype.swift
//  Flight Sickness
//
//  Created by William Lin on 11/28/17.
//  Copyright © 2017 Coleman. All rights reserved.
//

// Hashable wrapper for a metatype value.
struct Metatype<T> : Hashable {
    
    static func ==(lhs: Metatype, rhs: Metatype) -> Bool {
        return lhs.base == rhs.base
    }
    
    let base: T.Type
    
    init(_ base: T.Type) {
        self.base = base
    }
    
    var hashValue: Int {
        return ObjectIdentifier(base).hashValue
    }
}
