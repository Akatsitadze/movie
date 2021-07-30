//
//  URL.swift
//  Movie
//
//  Created by Mac User on 29.07.21.
//

import UIKit

extension URL {
    //FIXME: remove the method
    static func cointainerURL(forGroupIdentifier identifier:String) -> URL! {
        guard let url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: identifier) else { return nil }
        do {
            try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        catch {
            debugPrint(error)
        }
        return url
    }
    
    static var cachesDirectory : URL {
        return try! FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    }
}
