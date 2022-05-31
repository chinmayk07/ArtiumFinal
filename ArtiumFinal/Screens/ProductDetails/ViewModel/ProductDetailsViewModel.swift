//
//  ProductDetailsViewModel.swift
//  ArtiumFinal
//
//  Created by Chinmay Khot on 30/05/22.
//

import Foundation

class ProductDetailsViewModel {
    
    private var productDetails : ProductDetailServiceProtocol
    
    var reloadView: (() -> Void)?
    
    private(set) var imageString = ""
    private(set) var titleString = ""
    private(set) var ratingString = ""
    private(set) var priceString = ""
    private(set) var categoryString = ""
    private(set) var descriptionString = ""
    
    init(productDetails: ProductDetailServiceProtocol = ProductDetailService()) {
        self.productDetails = productDetails
    }

    func getproductDetails(id: Int) {
        productDetails.getProductDetail(productid: id) { success, results, error in
            if success, let products = results {
                self.updateData(product: products)
            }
            else {
                print("errors")
            }
        }
    }
    
    func updateData(product: ProductDetails) {
        imageString = setimageString(product: product)
        titleString = settitleString(product: product)
        ratingString = setratingString(product: product)
        priceString = setpriceString(product: product)
        categoryString = setcategoryString(product: product)
        descriptionString = setdescString(product: product)
        reloadView?()
    }

}

extension ProductDetailsViewModel {
    
    private func setimageString(product: ProductDetails) -> String {
        return product.image
    }
    private func settitleString(product: ProductDetails) -> String {
        return product.title
    }
    private func setratingString(product: ProductDetails) -> String {
        return "\(product.rating.rate)" + " (" + "\(product.rating.count)" + ")"
    }
    private func setpriceString(product: ProductDetails) -> String {
        return "$ \(product.price)"
    }
    private func setcategoryString(product: ProductDetails) -> String {
        return product.category
    }
    private func setdescString(product: ProductDetails) -> String {
        return product.description
    }
    
}
