//
//  ProductDetailService.swift
//  ArtiumFinal
//
//  Created by Chinmay Khot on 30/05/22.
//

import Foundation

protocol ProductDetailServiceProtocol {
    func getProductDetail(productid: Int, completion: @escaping (_ success: Bool, _ results: ProductDetails?, _ error: String?) ->())
}

struct ProductDetailService: ProductDetailServiceProtocol {

    func getProductDetail(productid: Int, completion: @escaping (Bool, ProductDetails?, String?) -> ()) {
        
        HTTPService().GET(url: "https://fakestoreapi.com/products/\(productid)", params: ["": ""], httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(ProductDetails.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, "Error: Trying to parse Product to model")
                }
            } else {
                completion(false, nil, "Error: Product List GET Request failed")
            }
        }
        
    }
}
