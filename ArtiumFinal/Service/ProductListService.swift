//
//  ProductListService.swift
//  ArtiumFinal
//
//  Created by Chinmay Khot on 29/05/22.
//

import Foundation

protocol ProductListServiceProtocol {
    func getProductList(completion: @escaping (_ success: Bool, _ results: [Product]?, _ error: String?) ->())
    
    func getCategories(completion: @escaping (_ success: Bool, _ results: [String]?, _ error: String?) ->())
}

struct ProductListService: ProductListServiceProtocol {
    
    func getCategories(completion: @escaping (Bool, [String]?, String?) -> ()) {
        HTTPService().GET(url: "https://fakestoreapi.com/products/categories", params: ["": ""], httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode([String].self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, "Error: Trying to parse Product to model")
                }
            } else {
                completion(false, nil, "Error: Product List GET Request failed")
            }
        }
    }
    

    func getProductList(completion: @escaping (Bool, [Product]?, String?) -> ()) {
        
        HTTPService().GET(url: "https://fakestoreapi.com/products", params: ["": ""], httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode([Product].self, from: data!)
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
