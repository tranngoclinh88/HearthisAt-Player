//
//  MapperTransforms.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 05/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation
import ObjectMapper

struct URLTransform: TransformType {
    
    typealias Object = URL
    typealias JSON = String
    
    func transformFromJSON(_ value: Any?) -> URL? {
        guard let value = value as? String else { return nil }
        return URL(string: value)
    }
    
    func transformToJSON(_ value: URL?) -> String? {
        return value?.absoluteString
    }
}

struct IntTransform: TransformType {
    
    typealias Object = Int
    typealias JSON = String
    
    func transformFromJSON(_ value: Any?) -> Int? {
        guard let value = value as? String else { return nil }
        return Int(value)
    }
    
    func transformToJSON(_ value: Int?) -> String? {
        guard let value = value else { return nil }
        return "\(value)"
    }
}

struct BoolTransform: TransformType {
    
    typealias Object = Bool
    typealias JSON = String
    
    func transformFromJSON(_ value: Any?) -> Bool? {
        guard let value = value as? String else { return nil }
        return Bool(value)
    }
    
    func transformToJSON(_ value: Bool?) -> String? {
        guard let value = value else { return nil }
        return "\(value ? 1 : 0)"
    }
}

struct TimeIntervalTransform: TransformType {
    
    typealias Object = TimeInterval
    typealias JSON = String
    
    func transformFromJSON(_ value: Any?) -> TimeInterval? {
        guard let value = value as? String else { return nil }
        return TimeInterval(value)
    }
    
    func transformToJSON(_ value: TimeInterval?) -> String? {
        guard let value = value else { return nil }
        return "\(value)"
    }
}
