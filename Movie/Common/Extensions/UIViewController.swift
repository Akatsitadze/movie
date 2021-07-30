//
//  UIViewController.swift
//  Movie
//
//  Created by Mac User on 29.07.21.
//

import UIKit

private var kAssociationKeyNotificationObserver : UInt8 = 4

extension UIViewController {
    
    private var notificationsObserver : [NSObjectProtocol] {
        get {
            return objc_getAssociatedObject(self, &kAssociationKeyNotificationObserver) as? [NSObjectProtocol] ?? []
        }
        set {
            objc_setAssociatedObject(self, &kAssociationKeyNotificationObserver, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func addNotificationObserver(forNames names : NSNotification.Name..., object obj: Any?, queue: OperationQueue?, using block: @escaping (Notification) -> Swift.Void) {
        for name in names {
            addNotificationObserver(NotificationCenter.default.addObserver(forName: name, object: obj, queue: queue, using: block))
        }
    }
    func addNotificationObserver(_ obj : NSObjectProtocol) {
        var list = notificationsObserver
        list.append(obj)
        notificationsObserver = list
    }
    
    func removeNotificationObserver() {
        while !notificationsObserver.isEmpty {
            let obj = notificationsObserver.removeLast()
            NotificationCenter.default.removeObserver(obj)
        }
    }
    
}
