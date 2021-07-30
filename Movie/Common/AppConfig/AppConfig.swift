//
//  AppConfig.swift
//  Movie
//
//  Created by Mac User on 28.07.21.
//

import Foundation

class AppConfig {
    // MARK: - Public Properties
    let BaseUrl: String
    let APIkey: String

    
    // MARK: - Private Properties
    private static var sharedInstance: AppConfig = {
        let shared = AppConfig()
        return shared
    }()
    
    class func shared() -> AppConfig {
        return sharedInstance
    }
    
    // Initialization
    private init() {
        guard let infoPlist = Bundle.main.infoDictionary else {
            fatalError("Somthing wrong with info.plist")
        }
        APIkey = infoPlist["APIkey"] as! String
        BaseUrl = infoPlist["BaseUrl"] as! String
    }
}
