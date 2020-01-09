//
//  Thumbnail.swift
//  MarvelApp
//
//  Created by Bartłomiej Smektała on 09/01/2020.
//  Copyright © 2020 Bartłomiej Smektała. All rights reserved.
//

import Foundation
import ObjectMapper

class Thumbnail: NSObject, Mappable, NSCoding {
    public var path: String?
    public var type: String?
        
    required init?(map: Map) {
        
    }
    
    required public init(coder aDecoder: NSCoder) {
        self.path = aDecoder.decodeObject(forKey: CodingKeys.path) as? String
        self.type = aDecoder.decodeObject(forKey: CodingKeys.type) as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.path, forKey: CodingKeys.path)
        aCoder.encode(self.type, forKey: CodingKeys.type)
    }
    
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = self.path { dictionary[CodingKeys.path] = value }
        if let value = self.type { dictionary[CodingKeys.type] = value }
        
        return dictionary
    }
    
    public func mapping(map: Map) {
        self.path <- map[CodingKeys.path]
        self.type <- map[CodingKeys.type]
    }
    
    struct CodingKeys {
        public static let path = "path"
        public static let type = "extension"
    }

}
