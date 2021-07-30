//
//  SimilarItemCell.swift
//  Movie
//
//  Created by Mac User on 29.07.21.
//

import UIKit

//FIXME: make marks
class SimilarItemCell: UICollectionViewCell {
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
            DispatchQueue.main.async {
                //FIXME: remove magic numbers, move it to local constants
                //FIXME: User weak self
                UIView.transition(with: self.itemImageView, duration: 0.2, options: .transitionCrossDissolve, animations: {self.itemImageView.image = image}, completion: nil) //FIXME: User weak self
            }
        } else {
            ImageManager.shared.downloadImage(for: item, priority: .high)
        }
    }
}
