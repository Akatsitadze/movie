//
//  ItemDetailViewModel.swift
//  Movie
//
//  Created by Mac User on 28.07.21.
//

import Foundation

//FIXME: make marks
class ItemDetailViewModel {
    
    let item: Item
    
    init(with item: Item) {
        self.item = item
    }
    
    func diplayName() -> String? {
        return item.original_name
    }
    
    func description() -> String? {
        return item.overview
    }
    
    func rate() -> String? {
        guard let vote = item.vote_average else {
            return nil
        }
        return String(format: "%.2f", vote)
    }
    
    func imageUrl() -> URL? {
        guard let poster_path = item.poster_path,
              let url = URL(string: String(format: Constants.imagePath, poster_path)) else {
            return nil
        }
        return url
    }
    
}
