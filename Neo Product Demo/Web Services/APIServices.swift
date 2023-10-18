//
//  APIServices.swift
//  Neo Product Demo
//
//  Created by Neosoft on 18/10/23.
//

import Foundation

// MARK: - Constansts for APIService
let Dev_Root_Point = "http://staging.php-dev.in:8844/trainingapp"
let Prod_Root_Point = ""

let contentValue = "application/x-www-form-urlencoded"
let contentKey = "Content-Type"

var pageNumber = 1

enum  NetworkEnvironment : String{
    case dev
    case prod
}

var networkEnvironment: NetworkEnvironment {
    return .dev
}
// BaseURL
var baseURL : String{
    switch networkEnvironment {
    case .dev:
        return Dev_Root_Point
    case .prod:
        return Prod_Root_Point
    }
}

//MARK: - APIService
enum APIServices{
    //All Possible Requests
    case fetchProductsList
    case fetchProductsDetails(param: [String:Any])

    // Setting url path
    var path: String{
        let apiDomain = "/api/"
        var urlPath:String = ""
        switch self{
            
        case .fetchProductsList:
            urlPath = "products/getList?product_category_id=1&limit=10&page=\(pageNumber)"
            
        case .fetchProductsDetails:
            urlPath = "products/getDetail"
        }
            return baseURL + apiDomain + urlPath
        }
        
        
        // Setting HTTP Method
        var httpMethod: String {
                return "GET"
        }
        
        // Param to pass in HTTPBody of URL
        var param: [String:Any]? {
            switch self {
            case .fetchProductsDetails(param: let param):
                return param
            default:
                return nil
            }
        }
        
        // Setting Header for Request
        var header: [String:String] {
            var dict:[String:String]
            dict = [contentKey:contentValue]
            return dict
        }
    }
    
