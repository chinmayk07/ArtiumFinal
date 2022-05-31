//
//  ProductListViewModel.swift
//  ArtiumFinal
//
//  Created by Chinmay Khot on 29/05/22.
//

import Foundation

class ProductListViewModel {
    
    var productService: ProductListServiceProtocol
    
    var reloadTableView: (() -> Void)?
    var showFilter: (() -> Void)?
       
    var products = Products()
    var tofilter = Products()
    
    var searchText: String = ""
    
    var categoryArr = [String]() {
        didSet {
            showFilter?()
        }
    }
    
    var productCellViewModels = [ProductCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }
    
    init(productService: ProductListServiceProtocol = ProductListService()) {
        self.productService = productService
    }
    
    func getProducts() {
        productService.getProductList { success, results, error in
            if success, let products = results {
                self.tofilter = products
                self.fetchData(product: products)
            }
            else {
                print("errors")
            }
        }
    }
    
    func getCategories() {
        productService.getCategories { success, results, error in
            if success, let categories = results {
                self.categoryArr = categories
                print("CATEGORIES : \(categories)")
            }
            else {
                print("errors : \(error ?? "")")
            }
        }
    }
    
//    func getSearchDataOld(text: String) {
//        if text.count < 1 {
//            self.fetchData(product: tofilter)
//        }
//        else {
//            let arr = tofilter.filter { $0.category.range(of: text, options: .caseInsensitive) != nil || $0.title.range(of: text, options: .caseInsensitive) != nil }
//            self.fetchData(product: arr)
//        }
//    }
    
    func getSearchData(text: String, completion: @escaping (_ results: [Product]?) -> ()) {
        if text.count < 1 {
//            self.fetchData(product: tofilter)
            completion(tofilter)
        }
        else {
            let arr = tofilter.filter { $0.category.range(of: text, options: .caseInsensitive) != nil || $0.title.range(of: text, options: .caseInsensitive) != nil }
//            self.fetchData(product: arr)
            completion(arr)
        }
    }
    
//    func getSorttedDataOld(type: Int) {
//        var arr = Products()
//        switch (type) {
//        case 0 :
//            arr = tofilter.sorted(by: { $0.price < $1.price })
//            break
//        case 1 :
//            arr = tofilter.sorted(by: { $0.price > $1.price })
//            break
//        case 2 :
//            arr = tofilter.sorted(by: { $0.rating.rate > $1.rating.rate })
//            break
//        default:
//            return
//        }
//        self.fetchData(product: arr)
//    }
    
    func getSorttedData(type: Int, completion: @escaping (_ results: [Product]?) -> ()) {
        var arr = Products()
        switch (type) {
        case 0 :
            arr = tofilter.sorted(by: { $0.price < $1.price })
            break
        case 1 :
            arr = tofilter.sorted(by: { $0.price > $1.price })
            break
        case 2 :
            arr = tofilter.sorted(by: { $0.rating.rate > $1.rating.rate })
            break
        default:
            return
        }
        completion(arr)
    }
    
    func cancelSearch() {
        self.fetchData(product: tofilter)
    }
    
    func fetchData(product: Products) {
        var vms = [ProductCellViewModel]()
        for item in product {
            vms.append(createCellModel(product: item))
        }
        productCellViewModels = vms
    }
    
    func createCellModel(product: Product) -> ProductCellViewModel {
        
        let id = product.id
        let image = product.image
        let title = product.title
        let category = product.category
        let ratings = "\(product.rating.rate)" + " (" + "\(product.rating.count)" + ")"
        let price = "$ \(product.price)"
        
        return ProductCellViewModel(id: id, image: image, title: title, category: category, ratings: ratings, price: price)
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> ProductCellViewModel {
        return productCellViewModels[indexPath.row]
    }
    
    func didSelect(at indexPath: IndexPath) -> Int {
        return productCellViewModels[indexPath.row].id
    }
    
    
}
