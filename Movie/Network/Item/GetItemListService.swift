//
//  GetItemListService.swift
//  Movie
//
//  Created by Mac User on 28.07.21.
//

import Foundation

struct GetItemListService: RequestType {
    let page: Int
    
    typealias ResponseType = PopularServiceResponse
    var data: RequestData {
        get {
            let url = String(format: Constants.getPopular, AppConfig.shared().APIkey, page)
            var request = RequestData(path: url)
            request.method = .get
            return request
        }
    }
}

//FIXME: better to remove snake case and make camal case
struct PopularServiceResponse: Decodable {
    let page: Int?
    let results: [Item]?
    let total_results: Int?
    let total_pages: Int?
}
