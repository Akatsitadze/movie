//
//  SimilarItemCell.swift
//  Movie
//
//  Created by Mac User on 29.07.21.
//

import UIKit

class SimilarItemCell: UICollectionViewCell {
    
    //MARK: IBOutlet
    @IBOutlet var itemImageView: UIImageView!
    @IBOutlet var itemTitleLabel: UILabel!
    @IBOutlet var itemRateLabel: UILabel!
    
    var item : Item! {
        didSet {
            updateImage()
        }
    }
    
    func updateImage() {
        if let image = ImageManager.shared.image(for: item) {
            DispatchQueue.main.async { [weak self] in
                guard let s = self else {return}
                UIView.transition(with: s.itemImageView,
                                  duration: Constants.imageSetAnimationDuration,
                                  options: .transitionCrossDissolve,
                                  animations: {s.itemImageView.image = image}, completion: nil)
            }
        } else {
            ImageManager.shared.downloadImage(for: item, priority: .high)
        }
    }
}
