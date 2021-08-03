//
//  Item.swift
//  Movie
//
//  Created by Mac User on 28.07.21.
//

import Foundation

struct Item: Codable {
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
        
    public func imageUrl() -> URL? {
        guard let poster_path = self.posterPath,
              let url = URL(string: String(format: Constants.imagePath, poster_path)) else {
            return nil
        }
        return url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: StructKeys.self)
        
        posterPath = try? container.decode(String.self, forKey: .posterPath)
        popularity = try? container.decode(Double.self, forKey: .popularity)
        id = try? container.decode(Int.self, forKey: .id)
        
        backdropPath = try? container.decode(String.self, forKey: .backdropPath)
        voteAverage = try? container.decode(Double.self, forKey: .voteAverage)
        overview = try? container.decode(String.self, forKey: .overview)
        firstAirDate = try? container.decode(String.self, forKey: .firstAirDate)
        originCountry = try? container.decode([String].self, forKey: .originCountry)
        genreIds = try? container.decode([Int].self, forKey: .genreIds)
        originalLanguage = try? container.decode(String.self, forKey: .originalLanguage)
        voteCount = try? container.decode(Int.self, forKey: .voteCount)
        name = try? container.decode(String.self, forKey: .name)
        originalName = try? container.decode(String.self, forKey: .originalName)
    }
    
    enum StructKeys : String, CodingKey {
        case posterPath = "poster_path"
        case popularity
        case id
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case overview
        case firstAirDate = "first_air_date"
        case originCountry = "origin_country"
        case genreIds = "genre_ids"
        case originalLanguage = "original_language"
        case voteCount = "vote_count"
        case name
        case originalName = "original_name"
    }
}

extension Item : Hashable {
    static func == (lhs : Item, rhs : Item) -> Bool {
        return lhs.id == rhs.id
    }
}
