//
//  ImageManager.swift
//  Movie
//
//  Created by Mac User on 29.07.21.
//

import Foundation
import UIKit

//FIXME: mark the code
class ImageManager {
   
    static let shared = ImageManager()

    private let imageQueue = DispatchQueue(label: "app.imageManager")
    private var requestsDeal = [Item: URLSessionTask]()
    
    enum DownloadPriority {
        case high
        case low
    }
    
    enum imageType {
        case item
        
        static let allCacheUrl : [URL] = [item.cacheUrl]
        var cacheUrl : URL {
            switch self {
            case .item: return URL.cachesDirectory.appendingPathComponent("item")
            }
        }
    }
    
    static func localImageUrl(for item : Item) -> URL {
        var doc = imageType.item.cacheUrl
        doc.appendPathComponent("item")
        try? FileManager.default.createDirectory(at: doc, withIntermediateDirectories: true, attributes: nil)
        return doc.appendingPathComponent(item.id!.description).appendingPathExtension("jpg")
    }
    
    func downloadImage(for item : Item, priority : DownloadPriority) {

        if let task = imageQueue.sync(execute: { () -> URLSessionTask? in return self.requestsDeal[item] }) {
            self.set(priority: priority, for: task)
            return
        }
        guard let url = item.imageUrl() else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self](data, response, error) in
            do {
                if let err = error {
                    throw err
                }
                if let d = data {
                    try d.write(to: ImageManager.localImageUrl(for: item))
                    _=self?.imageQueue.sync {
                        self?.requestsDeal.removeValue(forKey: item)
                    }
                    NotificationCenter.default.post(name: .updateItem, object: item)
                }
            }
            catch {
                debugPrint(error)
            }
        }
        self.set(priority: priority, for: task)

        imageQueue.sync {
            self.requestsDeal[item] = task
        }
        task.resume()
    }
    
    private func set(priority : DownloadPriority, for task : URLSessionTask) {
        switch priority {
        case .high:
            task.priority = URLSessionTask.highPriority
        case .low:
            task.priority = URLSessionTask.lowPriority
        }
    }
    
    func image(for item : Item) -> UIImage? {
        return image(for: ImageManager.localImageUrl(for: item))
    }
    
    private func image(for url : URL) -> UIImage? {
        guard let data = try? Data(contentsOf: url) else { return nil}
        return UIImage(data: data)
    }
}
