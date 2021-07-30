//
//  ItemListViewController.swift
//  Movie
//
//  Created by Mac User on 28.07.21.
//

import UIKit

class ItemListViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var contentTable: UITableView!
    
    // MARK: ViewModel
    var viewModel = ItemViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addNotificationObserver(forNames: .updateItem, object: nil, queue: .main) { [weak self](notif) in
            guard let item = notif.object as? Item else { return }
            guard let index = self?.viewModel.items.firstIndex(of: item) else { return }
            let indexPath = IndexPath(row: index, section: 0)
            guard let cell = self?.contentTable?.cellForRow(at: indexPath) as? ItemCell else { return }
            cell.item = item
        }
    }
    
    func fetchData() {
        viewModel.getItemList { [weak self] error in
            self?.contentTable.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? ItemDetailViewController else { return }
        guard let item = sender as? Item else { return }
        let viewModel = ItemDetailViewModel(with: item)
        vc.detailViewModel = viewModel
        guard let itemId = viewModel.item.id else { return }
        vc.similarViewModel = SimilarItemViewModel(with: itemId)
    }
    
    deinit {
        removeNotificationObserver()
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension ItemListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numbersOfRows()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "itemDetails", sender: viewModel.item(at: indexPath.row))
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        cell.itemTitleLabel.text = viewModel.diplayName(at: indexPath.row)
        cell.itemDescriptionLabel.text = viewModel.description(at: indexPath.row)
        cell.itemRateLabel.text = viewModel.rate(at: indexPath.row)
        
        cell.item = viewModel.item(at: indexPath.row)
        
        if indexPath.row == viewModel.numbersOfRows()-1,
           viewModel.canFetchData {
            viewModel.getItemList { _ in
                tableView.reloadData()
            }
        }
        return cell
    }
}
