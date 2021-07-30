//
//  CustomSplitViewController.swift
//  Movie
//
//  Created by Mac User on 30.07.21.
//

import Foundation
import UIKit

class CustomSplitViewController : UISplitViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        preferredDisplayMode = .oneBesideSecondary
        title = Constants.title
    }
}

//MARK: SEGUES
class SplitViewControllerDetailStoryboardSegue : UIStoryboardSegue {
    
    override func perform() {
        if let split = source.splitViewController {
            if !split.isCollapsed {
                split.showDetailViewController(destination, sender: nil)
            }
            else {
                source.navigationController?.pushViewController(destination, animated: true)
            }
        }
    }
}

