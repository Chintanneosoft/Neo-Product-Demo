//
//  DataBaseManager.swift
//  Neo Product Demo
//
//  Created by Neosoft on 18/10/23.
//
import UIKit
import Foundation
//MARK: - DataBaseManager
class DataBaseManager: NSObject {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveFavorite(productID: Int) -> String? {
        var productData = ProductData(context: context)
        productData.productId = Int64(productID)
        do{
            try context.save()
            return nil
        } catch {
            return error.localizedDescription
        }
    }
    
    func getFavorite() -> [ProductData]?{
        do{
            let productData = try context.fetch(ProductData.fetchRequest())
            return productData
        } catch {
            return nil
        }
    }
    
    func deleteFavorite(productData: ProductData) -> String?{
        do{
            context.delete(productData)
            try context.save()
            return nil
        } catch {
            return error.localizedDescription
        }
    }
}
