//
//  ItemDetailViewController.swift
//  Movie
//
//  Created by Mac User on 28.07.21.
//

import UIKit

//FIXME: make marks
class ItemDetailViewController: UITableViewController {
    
    @IBOutlet var itemImageView: UIImageView!
    @IBOutlet var itemTitleLabel: UILabel!
    @IBOutlet var itemDescriptionLabel: UILabel!
    @IBOutlet var similarCollectionView: UICollectionView!

    //FIXME: remove uptional and use implicity unwrap
    //FIXME: remove all ? mark in the controller
    public var detailViewModel: ItemDetailViewModel?
    public var similarViewModel: SimilarItemViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        fetchSimilarData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //FIXME: where is notification removing code? removeNotificationObserver() is unused
        addNotificationObserver(forNames: .updateItem, object: nil, queue: .main) { [weak self](notif) in
            guard let item = notif.object as? Item else { return }
            guard let index = self?.similarViewModel!.items.firstIndex(of: item) else { return }
            let indexPath = IndexPath(row: index, section: 0)
            guard let cell = self?.similarCollectionView?.cellForItem(at: indexPath) as? SimilarItemCell else { return }
            cell.item = item
        }
    }
    
    func fetchSimilarData() {
        similarViewModel?.getSimilarItemList(completion: { [weak self] error in
            self?.similarCollectionView.reloadData()
        })
    }
    
    private func configure() {
        updateImage()
        itemTitleLabel.text = detailViewModel?.diplayName()
        itemDescriptionLabel.text = detailViewModel?.description()
    }
    
    func updateImage() {
        guard let item = detailViewModel?.item else {return}
        if let image = ImageManager.shared.image(for: item) {
            DispatchQueue.main.async {
                UIView.transition(with: self.itemImageView, duration: 0.2, options: .transitionCrossDissolve, animations: {self.itemImageView.image = image}, completion: nil)
            }
        } else {
            ImageManager.shared.downloadImage(for: item, priority: .high)
        }
    }
}

extension ItemDetailViewController {
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}

extension ItemDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         similarViewModel!.numbersOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "similarItemCell", for: indexPath) as! SimilarItemCell
        
        cell.itemTitleLabel.text = similarViewModel!.diplayName(at: indexPath.row)
        cell.itemRateLabel.text = similarViewModel!.rate(at: indexPath.row)
        
        cell.item = similarViewModel!.item(at: indexPath.row)
     
        if indexPath.row == similarViewModel!.numbersOfRows()-1,
           similarViewModel!.canFetchData {
            similarViewModel!.getSimilarItemList { _ in
                collectionView.reloadData()
            }
        }
        
        return cell
    }
    
}
