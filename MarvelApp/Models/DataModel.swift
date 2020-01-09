//
//  DataModel.swift
//  MarvelApp
//
//  Created by Bartłomiej Smektała on 09/01/2020.
//  Copyright © 2020 Bartłomiej Smektała. All rights reserved.
//

import Foundation
import ObjectMapper

class DataModel: NSObject, Mappable, NSCoding {
    public var results: [ComicBookModel]?
        
    required init?(map: Map) {
        
    }
    
    required public init(coder aDecoder: NSCoder) {
        self.results = aDecoder.decodeObject(forKey: CodingKeys.results) as? [ComicBookModel]
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.results, forKey: CodingKeys.results)
    }
    
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = self.results { dictionary[CodingKeys.results] = value }
        
        return dictionary
    }
    
    public func mapping(map: Map) {
        self.results <- map[CodingKeys.results]
    }
    
    struct CodingKeys {
        public static let results = "results"
    }

}
