//
//  ProductListViewController.swift
//  Neo Product Demo
//
//  Created by Neosoft on 18/10/23.
//

import UIKit
//MARK: - ProductListViewController
class ProductListViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var productListTableView: UITableView!
    
    let productListViewModel = ProductListViewModel()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setProductList()
        navigationController?.navigationBar.isHidden = false
    }
    
    private func setUpUI(){
        setNavBarStyle(fontSize: 16)
        title = NavTitle.productList.rawValue
    }
    
    private func setProductList(){
        productListViewModel.callFetchProductList(productCategory: 1) { response in
            DispatchQueue.main.async {
                switch response{
                case .success(_):
                    self.productListTableView.reloadData()
                case .failure(let error):
                    self.showAlert(title: AlertText.Title.error.rawValue, msg: error.localizedDescription, okClosure: nil)
                }
            }
        }
    }
    
    private func setUpTableView(){
        productListTableView.delegate = self
        productListTableView.dataSource = self
        
        productListTableView.register(UINib(nibName: CellNames.ProductListCell.rawValue, bundle: nil),forCellReuseIdentifier: CellNames.ProductListCell.rawValue)
    }
}

//MARK: - TableView Delegates and DataSource
extension ProductListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productListViewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellNames.ProductListCell.rawValue, for: indexPath) as? ProductListCell
        cell?.setDetails(productInfo: productListViewModel.products[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = ProductDetailsViewController(nibName: VCNames.ProductDetails.rawValue, bundle: nil)
        nextVC.productId = productListViewModel.products[indexPath.row].id
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if productListViewModel.products.count-1 == indexPath.row && pageNumber < 2{
            pageNumber += 1
            setProductList()
        }
    }
}
