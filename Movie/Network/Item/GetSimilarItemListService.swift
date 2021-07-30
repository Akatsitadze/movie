//
//  GetSimilarItemListService.swift
//  Movie
//
//  Created by Mac User on 29.07.21.
//

import Foundation

struct GetSimilarItemListService: RequestType {
    let tvId: Int
    let page: Int
    
    typealias ResponseType = SimilarServiceResponse
    var data: RequestData {
        get {
            let url = String(format: Constants.getSimilar, tvId, AppConfig.shared().APIkey, page)
            var request = RequestData(path: url)
            request.method = .get
            return request
        }
    }
}

struct SimilarServiceResponse: Decodable {
    let page: Int?
    let results: [Item]?
    let totalResults: Int?
    let totalPages: Int?
    
    enum StructKeys : String, CodingKey {
        case page = "page"
        case results = "results"
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}
