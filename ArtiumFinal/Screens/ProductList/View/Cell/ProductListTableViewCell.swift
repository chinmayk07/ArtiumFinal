//
//  ProductListTableViewCell.swift
//  ArtiumAcademy
//
//  Created by Chinmay Khot on 24/05/22.
//

import UIKit
import SDWebImage

class ProductListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var ProductTitle: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var ratingsText: UILabel!
    @IBOutlet weak var priceText: UILabel!
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }

    var cellViewModel: ProductCellViewModel? {
        didSet {
            
            productImage.sd_setImage(with: URL(string: cellViewModel!.image), placeholderImage: UIImage(named: "loading.png"))
            ProductTitle.text = cellViewModel?.title
            category.text = cellViewModel?.category
            ratingsText.text = cellViewModel?.ratings
            priceText.text = cellViewModel?.price
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        ProductTitle.text = nil
        category.text = nil
        ratingsText.text = nil
        priceText.text = nil
    }
    
}
                                        
