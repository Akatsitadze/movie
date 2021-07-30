//
//  Item.swift
//  Movie
//
//  Created by Mac User on 28.07.21.
//

import Foundation

struct Item: Decodable {
    let posterPath: String?
    let popularity: Double?
    let id: Int?
    let backdropPath: String?
    let voteAverage: Double?
    let overview: String?
    let firstAirDate: String?
    let originCountry: [String]?
    let genreIds: [Int]?
    let originalLanguage: String?
    let voteCount: Int?
    let name: String?
    let originalName: String?
    
    //FIXME: better to remove snake case and make camal case
    
    public func imageUrl() -> URL? {
        guard let poster_path = self.posterPath,
              let url = URL(string: String(format: Constants.imagePath, poster_path)) else {
            return nil
        }
        return url
    }
    
    enum StructKeys : String, CodingKey {
        case posterPath = "poster_path"
        case popularity = "popularity"
        case id = "id"
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case overview = "overview"
        case firstAirDate = "first_air_date"
        case originCountry = "origin_country"
        case genreIds = "genre_ids"
        case originalLanguage = "original_language"
        case voteCount = "vote_count"
        case name = "name"
        case originalName = "original_name"
    }
}

extension Item : Hashable {
    static func == (lhs : Item, rhs : Item) -> Bool {
        return lhs.id == rhs.id
    }
}
