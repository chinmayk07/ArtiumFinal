//
//  ProductListViewController.swift
//  ArtiumFinal
//
//  Created by Chinmay Khot on 29/05/22.
//

import UIKit

class ProductListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    lazy var viewModel = {
        ProductListViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initViewModel()
        // Do any additional setup after loading the view.
    }
    
    func initView() {
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        tableView.register(ProductListTableViewCell.nib, forCellReuseIdentifier: ProductListTableViewCell.identifier)
        tableView.register(NoDataTableViewCell.nib, forCellReuseIdentifier: NoDataTableViewCell.identifier)
    }
    
    func initViewModel() {
        viewModel.getProducts()
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    @IBAction func btnFilter(_ sender: Any) {
        viewModel.getCategories()
        viewModel.showFilter = {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Filter By", message: "", preferredStyle: .actionSheet)
                
                for item in self.viewModel.categoryArr {
                    alert.addAction(UIAlertAction(title: item, style: .default , handler:{ (UIAlertAction)in
//                        self.viewModel.getSearchData(text: item)
                        self.viewModel.getSearchData(text: item) { results in
                            self.viewModel.fetchData(product: results ?? [])
                        }
                    }))
                }
                
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
//                    self.viewModel.getSearchData(text: "")
                    self.viewModel.getSearchData(text: "") { results in
                        self.viewModel.fetchData(product: results ?? [])
                    }
                }))
                
                self.present(alert, animated: true, completion: {
                })
            }
            
        }
    }
    
    @IBAction func btnSort(_ sender: Any) {
        //Please Select an Option to Sort By
        let alert = UIAlertController(title: "Sort By", message: "", preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "Price - Low to High", style: .default , handler:{ (UIAlertAction)in
                self.viewModel.getSorttedData(type: 0) { results in
                    self.viewModel.fetchData(product: results!)
                }
            }))
            
            alert.addAction(UIAlertAction(title: "Price - High to Low", style: .default , handler:{ (UIAlertAction)in
                self.viewModel.getSorttedData(type: 1) { results in
                    self.viewModel.fetchData(product: results!)
                }
            }))

            alert.addAction(UIAlertAction(title: "Ratings", style: .default , handler:{ (UIAlertAction)in
                self.viewModel.getSorttedData(type: 2) { results in
                    self.viewModel.fetchData(product: results!)
                }
            }))
            
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
            }))

            self.present(alert, animated: true, completion: {
            })
    }

}

extension ProductListViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        viewModel.getSearchData(text: searchText)
        viewModel.getSearchData(text: searchText) { results in
            self.viewModel.fetchData(product: results ?? [])
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.cancelSearch()
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
}

extension UITableView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}

extension ProductListViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.productCellViewModels.count == 0 {
            self.tableView.setEmptyMessage("Please check the spelling or try searching for something else !!!")
        } else {
            self.tableView.restore()
        }
        return viewModel.productCellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.productCellViewModels.count > 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductListTableViewCell.identifier, for: indexPath) as? ProductListTableViewCell else { return UITableViewCell()}
            let cellVM = viewModel.getCellViewModel(at: indexPath)
            cell.cellViewModel = cellVM
            return cell
            
        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NoDataTableViewCell.identifier, for: indexPath) as? NoDataTableViewCell else { return UITableViewCell()}
            return cell
        }
        
    }
    
}

extension ProductListViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let productIDatCell = viewModel.didSelect(at: indexPath)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = (storyboard.instantiateViewController(withIdentifier: "ProductDetailsViewController") as? ProductDetailsViewController)!
        
        vc.productID = productIDatCell
    
        switch UIDevice.current.userInterfaceIdiom {
            case .phone:
                self.navigationController?.pushViewController(vc, animated: true)
            case .pad:
                let navController = UINavigationController(rootViewController: vc)
                self.present(navController, animated: true, completion: nil)
            case .unspecified:
                break
            case .tv:
                break
            case .carPlay:
                break
            case .mac:
                break
            @unknown default: break
        }
    }
}
