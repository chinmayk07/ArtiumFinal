//
//  ProductDetailsViewController.swift
//  ArtiumFinal
//
//  Created by Chinmay Khot on 30/05/22.
//

import UIKit

class ProductDetailsViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleMain: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productRating: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    
    var productID : Int = 0
    
    lazy var viewModel = {
        ProductDetailsViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        // Do any additional setup after loading the view.
    }
    
    func initViewModel() {
        viewModel.getproductDetails(id: productID)
        viewModel.reloadView = {
            DispatchQueue.main.async {
                self.initView()
            }
            
        }
    }
    
    func initView() {
        image.sd_setImage(with: URL(string: viewModel.imageString), placeholderImage: UIImage(named: "loading.png"))
        titleMain.text = viewModel.titleString
        category.text = viewModel.categoryString
        productPrice.text = viewModel.priceString
        productRating.text = viewModel.ratingString
        productDescription.text = viewModel.descriptionString
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
