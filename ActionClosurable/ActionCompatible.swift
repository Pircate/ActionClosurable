// 
//  ActionCompatible.swift
//  ActionClosurable
//
//  Created by Pircate(swifter.dev@gmail.com) on 2019/4/22
//  Copyright © 2019 Yoshitaka Seki. All rights reserved.
//

public struct Action<Base> {
    
    let base: Base
    
    init(_ base: Base) {
        self.base = base
    }
}

public protocol ActionCompatible {
    
    associatedtype CompatibleType
    
    var on: CompatibleType { get }
}

public extension ActionCompatible {
    
    var on: Action<Self> {
        return Action(self)
    }
}

extension NSObject: ActionCompatible {}
