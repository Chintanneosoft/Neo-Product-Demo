//
//  Constants.swift
//  Neo Product Demo
//
//  Created by Neosoft on 18/10/23.
//

import Foundation

enum Constants{
    
}

enum NavTitle:String{
    case productList = "Products"
    case productDetails = "Product Details"
}

enum VCNames: String{
    case ProductList = "ProductListViewController"
    case ProductDetails = "ProductDetailsViewController"
}

enum CellNames: String{
    case ProductListCell = "ProductListCell"
    case ProductImgCell = "ProductImgCell"
}

enum APIServiceText:String{
    case productCategoryId = "product_category_id"
    case productId = "product_id"
}

enum AlertText{
    enum Title:String{
        case success = "Success"
        case error = "Error"
        case alert = "Alert"
    }
    enum message:String{
        case savedFav = "Saved as Favorite"
        case removedFav = "Removed From Favorites"
    }
}
