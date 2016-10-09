//
//  JSONTools.swift
//  CommunityApp
//
//  Created by Dan Esrey on 2016/09/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import Foundation

extension JSONSerialization {
    enum CastingError : Swift.Error {
        case incompatibleType
    }
    
    static func jsonObject<T>(with data: Data, options: JSONSerialization.ReadingOptions) throws -> T {
        let anyResult: Any = try jsonObject(with: data, options: options)
        if let result = anyResult as? T {
            return result
        } else {
            throw CastingError.incompatibleType
        }
    }
}
