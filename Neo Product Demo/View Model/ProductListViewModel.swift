//
//  ProductListViewModel.swift
//  Neo Product Demo
//
//  Created by Neosoft on 18/10/23.
//

import UIKit
//MARK: - ProductListViewModel
class ProductListViewModel: NSObject {
    //Properties
    var products: [ProductInfo] = []
    var productListAPIService = ProductListAPIServices()
    
    //API call
    func callFetchProductList(productCategory: Int,completion: @escaping(Result<String,Error>) -> Void){
        productListAPIService.fetchProductsList(productCategoryId: productCategory){
             response in
            switch response{
            case .success(let value):
                self.products += value.data
                completion(.success(AlertText.Title.success.rawValue))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
