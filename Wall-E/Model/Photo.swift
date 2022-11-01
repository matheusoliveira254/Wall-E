//
//  Photos.swift
//  Wall-E
//
//  Created by Matheus Oliveira on 10/15/22.
//

import Foundation

struct TopLevelDictionary: Decodable {
    let photos: [Photo]
}

struct Photo: Decodable {
    enum CodingKeys: String, CodingKey {
        case image = "img_src"
        case date = "earth_date"
        case id
    }
    
    let image: String?
    let date: String?
    let id: Int?
}//End of struct
