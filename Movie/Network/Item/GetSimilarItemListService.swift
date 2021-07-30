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
            let url = String(format: Constants.getSimilat, tvId, AppConfig.shared().APIkey, page)
            var request = RequestData(path: url)
            request.method = .get
            return request
        }
    }
}

//FIXME: better to remove snake case and make camal case
struct SimilarServiceResponse: Decodable {
    let page: Int?
    let results: [Item]?
    let total_results: Int?
    let total_pages: Int?
}
