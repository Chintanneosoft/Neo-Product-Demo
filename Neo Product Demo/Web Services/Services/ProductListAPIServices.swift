//
//  ProductListServices.swift
//  Neo Product Demo
//
//  Created by Neosoft on 18/10/23.
//

import UIKit

class ProductListAPIServices: NSObject {
    func fetchProductsList(productCategoryId: Int,completion: @escaping(Result<Products,Error>) -> Void){
        APIManager.shared.callRequest(apiCallType: .fetchProductsList){ (response) in
            switch response {
            case .success(let value):
                do {
                    let responseData = try JSONDecoder().decode(Products.self, from: value)
                    completion(.success(responseData))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
