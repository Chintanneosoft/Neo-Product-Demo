//
//  ProductDetailsViewModel.swift
//  Neo Product Demo
//
//  Created by Neosoft on 18/10/23.
//

import UIKit
//MARK: - ProductDetailsViewModel
class ProductDetailsViewModel: NSObject {
    //Properties
    var productDetail: ProductDetail?
    var productImages: [ProductImage] = []
    
    var productDetailsAPIService = ProductDetailsAPIService()
    
    //API call
    func callFetchProductList(productId: Int,completion: @escaping(Result<String,Error>) -> Void){
        productDetailsAPIService.fetchProductsDetails(productId: productId){
            response in
            switch response{
            case .success(let value):
                self.productDetail = value.data
                self.productImages = self.productDetail?.productImages ?? []
                completion(.success(AlertText.Title.success.rawValue))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
