//
//  ApiResponseModel.swift
//  MarvelApp
//
//  Created by Bartłomiej Smektała on 09/01/2020.
//  Copyright © 2020 Bartłomiej Smektała. All rights reserved.
//

import Foundation
import ObjectMapper

class ApiResponseModel: NSObject, Mappable, NSCoding {
    public var data: DataModel?
        
    required init?(map: Map) {
        
    }
    
    required public init(coder aDecoder: NSCoder) {
        self.data = aDecoder.decodeObject(forKey: CodingKeys.data) as? DataModel
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.data, forKey: CodingKeys.data)
    }
    
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = self.data { dictionary[CodingKeys.data] = value }
        
        return dictionary
    }
    
    public func mapping(map: Map) {
        self.data <- map[CodingKeys.data]
    }
    
    struct CodingKeys {
        public static let data = "data"
    }

}
