//
//  Constants.swift
//  Movie
//
//  Created by Mac User on 28.07.21.
//

import Foundation

struct Constants {
    
    static let getPopular = "/tv/popular?api_key=%@&language=en-US&page=%d"
    static let getSimilar = "/tv/%d/similar?api_key=%@&language=en-US&page=%d" 
    static let imagePath = "https://image.tmdb.org/t/p/w500%@"
    
    // MARK: Localizes strings
    static let rate = "Rate"
    static let title = "Movies"
    
    // MARK: Constants
    static let imageSetAnimationDuration = 0.2
}
