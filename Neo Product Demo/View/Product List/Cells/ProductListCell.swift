//
//  ProductListCell.swift
//  Neo Product Demo
//
//  Created by Neosoft on 18/10/23.
//

import UIKit
import SDWebImage

//MARK: - ProductListCell
class ProductListCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProducerName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnFavorite: UIButton!
    
    let dbManager = DataBaseManager()
    
    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDetails(productInfo: ProductInfo){
        imgProduct.sd_setImage(with: URL(string: String(productInfo.productImages)))
        lblProductName.text = productInfo.name
        lblProducerName.text = productInfo.producer
        lblPrice.text = String(productInfo.cost)
        checkFavorite(productInfo: productInfo)
    }
    
    private func checkFavorite(productInfo: ProductInfo){
        let productIds = dbManager.getFavorite() ?? []
        btnFavorite.isSelected = false
        for i in productIds{
            if i.productId == productInfo.id{
                btnFavorite.isSelected = true
                break
            }
        }
    }
    
}
