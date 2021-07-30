//
//  URL.swift
//  Movie
//
//  Created by Mac User on 29.07.21.
//

import UIKit

extension URL {
    static var cachesDirectory : URL {
        return try! FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    }
}
