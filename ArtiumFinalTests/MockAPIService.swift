//
//  MockAPIService.swift
//  ArtiumFinalTests
//
//  Created by Chinmay Khot on 31/05/22.
//

import Foundation
@testable import ArtiumFinal

class MockAPIService : ProductListServiceProtocol {
    
    var isgetProductListCalled = false
    var completeProductList: [Product] = [Product]()
    var completeClosureproduct: ((Bool, [Product], Error?) -> ())!
    
    func getProductList(completion: @escaping (Bool, [Product]?, String?) -> ()) {
        isgetProductListCalled = true
    }
    
    func fetchSuccessProduct() {
        completeClosureproduct( true, completeProductList, nil )
    }
    
    func fetchFailProduct(error: Error?) {
        completeClosureproduct( false, completeProductList, error )
    }
    
    
    
    
    // Categories
    
    var isgetCategoriesCalled = false
    var completecategories: [String] = [String]()
    var completeClosurecategories: ((Bool, [String], Error?) -> ())!
    

    func getCategories(completion: @escaping (Bool, [String]?, String?) -> ()) {
        isgetCategoriesCalled = true
    }
    
    func fetchSuccessCategory() {
        completeClosurecategories( true, completecategories, nil )
    }
    
    func fetchFailCategory(error: Error?) {
        completeClosurecategories( false, completecategories, error )
    }
    
   
    
}
