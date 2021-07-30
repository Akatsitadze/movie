//
//  SimilarItemViewModel.swift
//  Movie
//
//  Created by Mac User on 29.07.21.
//

import Foundation

//FIXME: make marks
class SimilarItemViewModel {

    var canFetchData = true
    
    //MARK: Private Properties
    var items: [Item] = []
    private let itemLimit = 20
    private var currentPage = 1
    private let tvId: Int
    
    init(with tvId: Int) {
        self.tvId = tvId
    }
    
    func getSimilarItemList(completion: @escaping ((NetworkError?)->())) {
        let service = GetSimilarItemListService(tvId: self.tvId, page: currentPage)
        service.execute { [weak self] response in
            guard let results = response.results else {return}
            guard let page = response.page else {return}
            self?.items.append(contentsOf: results)
            self?.canFetchData = results.count == self?.itemLimit
            self?.currentPage = page + 1
            completion(nil)
        } failure: { error in
            completion(nil)
        }
    }
    
    func numbersOfRows() -> Int {
        return items.count
    }
    
    func item(at index: Int) -> Item {
        return items[index]
    }
    
    func diplayName(at index: Int) -> String? {
        return items[index].original_name
    }
    
    func description(at index: Int) -> String? {
        return items[index].overview
    }
    
    func rate(at index: Int) -> String? {
        guard let vote = items[index].vote_average else {
            return nil
        }
        return String(format: "\(Constants.rate) %.2f", vote)
    }
    
    func imageUrl(at index: Int) -> URL? {
        guard let poster_path = items[index].poster_path,
              let url = URL(string: String(format: Constants.imagePath, poster_path)) else {
            return nil
        }
        return url
    }
    
}
