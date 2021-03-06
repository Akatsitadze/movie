//
//  ItemViewModel.swift
//  Movie
//
//  Created by Mac User on 28.07.21.
//

import Foundation

class ItemViewModel {

    //MARK: Properties
    var canFetchData = true
    
    //MARK: Private Properties
    var items: [Item] = []
    private let itemLimit = 20
    private var currentPage = 1
    
    func getItemList(completion: @escaping ((NetworkError?)->())) {
        let service = GetItemListService(page: self.currentPage)
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
        return items[index].originalName
    }
    
    func description(at index: Int) -> String? {
        return items[index].overview
    }
    
    func rate(at index: Int) -> String? {
        guard let vote = items[index].voteAverage else {
            return nil
        }
        return String(format: "\(Constants.rate) %.2f", vote)
    } 
    
    func imageUrl(at index: Int) -> URL? {
        guard let poster_path = items[index].posterPath,
              let url = URL(string: String(format: Constants.imagePath, poster_path)) else {
            return nil
        }
        return url
    }
    
}
