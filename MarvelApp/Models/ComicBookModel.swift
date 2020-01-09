//
//  ComicBook.swift
//  MarvelApp
//
//  Created by Bartłomiej Smektała on 09/01/2020.
//  Copyright © 2020 Bartłomiej Smektała. All rights reserved.
//

import Foundation
import ObjectMapper

class ComicBookModel: NSObject, Mappable, NSCoding {
    public var title: String?
    public var comicDescription: String?
    public var thumbnail: Thumbnail?
        
    required init?(map: Map) {
        
    }
    
    required public init(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObject(forKey: CodingKeys.title) as? String
        self.comicDescription = aDecoder.decodeObject(forKey: CodingKeys.description) as? String
        self.thumbnail = aDecoder.decodeObject(forKey: CodingKeys.thumbnail) as? Thumbnail
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.title, forKey: CodingKeys.title)
        aCoder.encode(self.comicDescription, forKey: CodingKeys.description)
        aCoder.encode(self.thumbnail, forKey: CodingKeys.thumbnail)
    }
    
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = self.title { dictionary[CodingKeys.title] = value }
        if let value = self.comicDescription { dictionary[CodingKeys.description] = value }
        if let value = self.thumbnail { dictionary[CodingKeys.thumbnail] = value }
        
        return dictionary
    }
    
    public func mapping(map: Map) {
        self.title <- map[CodingKeys.title]
        self.comicDescription <- map[CodingKeys.description]
        self.thumbnail <- map[CodingKeys.thumbnail]
    }
    
    struct CodingKeys {
        public static let title = "title"
        public static let description = "description"
        public static let thumbnail = "thumbnail"
    }

}
