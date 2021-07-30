//
//  Item.swift
//  Movie
//
//  Created by Mac User on 28.07.21.
//

import Foundation

struct Item: Decodable {
    let poster_path: String?
    let popularity: Double?
    let id: Int?
    let backdrop_path: String?
    let vote_average: Double?
    let overview: String?
    let first_air_date: String?
    let origin_country: [String]?
    let genre_ids: [Int]?
    let original_language: String?
    let vote_count: Int?
    let name: String?
    let original_name: String?
    
    //FIXME: better to remove snake case and make camal case
    
    public func imageUrl() -> URL? {
        guard let poster_path = self.poster_path,
              let url = URL(string: String(format: Constants.imagePath, poster_path)) else {
            return nil
        }
        return url
    }
}

extension Item : Hashable {
    static func == (lhs : Item, rhs : Item) -> Bool {
        return lhs.id == rhs.id
    }
}
