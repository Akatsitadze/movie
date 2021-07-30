//
//  ItemDetailViewController.swift
//  Movie
//
//  Created by Mac User on 28.07.21.
//

import UIKit

class ItemDetailViewController: UITableViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var itemImageView: UIImageView!
    @IBOutlet var itemTitleLabel: UILabel!
    @IBOutlet var itemDescriptionLabel: UILabel!
    @IBOutlet var similarCollectionView: UICollectionView!
    
    // MARK: - Public variables
    public var detailViewModel: ItemDetailViewModel!
    public var similarViewModel: SimilarItemViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        fetchSimilarData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        itemTitleLabel.text = detailViewModel.diplayName()
        itemDescriptionLabel.text = detailViewModel.description()
    }
    
    func updateImage() {
        guard let item = detailViewModel?.item else {return}
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
    
    deinit {
        removeNotificationObserver()
    }
}

extension ItemDetailViewController {
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}

// MARK: UICollectionViewDataSource, UICollectionViewDelegate
extension ItemDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         similarViewModel.numbersOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "similarItemCell", for: indexPath) as! SimilarItemCell
        
        cell.itemTitleLabel.text = similarViewModel.diplayName(at: indexPath.row)
        cell.itemRateLabel.text = similarViewModel.rate(at: indexPath.row)
        
        cell.item = similarViewModel.item(at: indexPath.row)
     
        if indexPath.row == similarViewModel.numbersOfRows()-1,
           similarViewModel.canFetchData {
            similarViewModel.getSimilarItemList { _ in
                collectionView.reloadData()
            }
        }
        
        return cell
    }
    
}
