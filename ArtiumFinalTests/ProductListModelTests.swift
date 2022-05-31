//
//  ProductListModelTests.swift
//  ArtiumFinalTests
//
//  Created by Chinmay Khot on 31/05/22.
//

import XCTest
@testable import ArtiumFinal

class ProductListModelTests: XCTestCase {
    
    var sut = ProductListViewModel()
    var mockAPIService: MockAPIService!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockAPIService = MockAPIService()
        sut = ProductListViewModel(productService: mockAPIService)
    }

    override func tearDownWithError() throws {
        mockAPIService = nil
        try super.tearDownWithError()
    }
    
    
    func test_get_products() {
       
        mockAPIService.completeProductList = [Product]()
        
        print(mockAPIService.completeProductList)
        
        sut.getProducts()
        
        XCTAssert(mockAPIService.isgetProductListCalled)
    }
    
    func test_sorting_of_price_from_High_to_low() {
        let product = Product(id: 1, title: "Jacket", price: 22.00, description: "adsfasdfasdfas", category: "fashion", image: "www.google.image.com", rating: Ratings(rate: 4.5, count: 100))
        let product1 = Product(id: 2, title: "asdfasd", price: 9.00, description: "adsfasdfasdfas", category: "fashion", image: "www.google.image.com", rating: Ratings(rate: 4.5, count: 100))
        
        sut.tofilter.insert(product, at: 0)
        sut.tofilter.insert(product1, at: 1)
        sut.getSorttedData(type: 1) { results in
            let a = results![0].price
            let b = results![1].price
            
            if a > b {
                XCTAssertTrue(true)
            }
            else {
                XCTAssertFalse(true)
            }
        }
    }
    
    func test_sorting_of_price_from_low_to_high() {
        
        let product = Product(id: 1, title: "Jacket", price: 22.00, description: "adsfasdfasdfas", category: "fashion", image: "www.google.image.com", rating: Ratings(rate: 4.5, count: 100))
        let product1 = Product(id: 2, title: "asdfasd", price: 9.00, description: "adsfasdfasdfas", category: "fashion", image: "www.google.image.com", rating: Ratings(rate: 4.5, count: 100))
        sut.tofilter.insert(product, at: 0)
        sut.tofilter.insert(product1, at: 1)
        sut.getSorttedData(type: 0) { results in
            let a = results![0].price
            let b = results![1].price
            
            if a < b {
                XCTAssertTrue(true)
            }
            else {
                XCTAssertFalse(true)
            }
        }
        
    }
    
    func test_sorting_of_rating_from_high_to_low() {
        let product = Product(id: 1, title: "Jacket", price: 22.00, description: "adsfasdfasdfas", category: "fashion", image: "www.google.image.com", rating: Ratings(rate: 4.5, count: 100))
        let product1 = Product(id: 2, title: "asdfasd", price: 9.00, description: "adsfasdfasdfas", category: "fashion", image: "www.google.image.com", rating: Ratings(rate: 2.5, count: 100))
        sut.tofilter.insert(product, at: 0)
        sut.tofilter.insert(product1, at: 1)
        sut.getSorttedData(type: 2) { results in
            let a = results![0].rating.rate
            let b = results![1].rating.rate
            
            if a > b {
                XCTAssertTrue(true)
            }
            else {
                XCTAssertFalse(true)
            }
        }
    }
    
    func test_searchresults_containg_searchedProduct() {
        let product = Product(id: 1, title: "Jacket", price: 22.00, description: "adsfasdfasdfas", category: "fashion", image: "www.google.image.com", rating: Ratings(rate: 4.5, count: 100))
        let product1 = Product(id: 2, title: "asdfasd", price: 9.00, description: "adsfasdfasdfas", category: "fashion", image: "www.google.image.com", rating: Ratings(rate: 2.5, count: 100))
        sut.tofilter.insert(product, at: 0)
        sut.tofilter.insert(product1, at: 1)
        
        var flag: Bool = false
        var searchedData = Products()
        let searchtext = "fas"
        sut.getSearchData(text: searchtext) { results in
            searchedData = results ?? []
        }
        
        for item in searchedData {
            if ( item.title.contains(searchtext) || item.category.contains(searchtext) ) {
                flag = true
            }
            else { flag = false }
        }
        
        if flag == true {
            XCTAssertTrue(true)
        }
        else {
            XCTAssertFalse(true)
        }
    }
    
    func test_cell_view_model() {
        
        let product = Product(id: 1, title: "Jacket", price: 22.00, description: "adsfasdfasdfas", category: "fashion", image: "www.google.image.com", rating: Ratings(rate: 4.5, count: 100))
        let cellViewModel = sut.createCellModel(product: product)
        
        XCTAssertEqual( product.title, cellViewModel.title )
        XCTAssertEqual( product.category, cellViewModel.category )
        XCTAssertEqual( product.image, cellViewModel.image )
        XCTAssertEqual( "\(product.rating.rate)" + " (" + "\(product.rating.count)" + ")", cellViewModel.ratings )

    }

}
