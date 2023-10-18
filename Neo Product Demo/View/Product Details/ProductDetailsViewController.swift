//
//  ProductDetailsViewController.swift
//  Neo Product Demo
//
//  Created by Neosoft on 18/10/23.
//

import UIKit
import SDWebImage

//MARK: - ProductDetailsViewController
class ProductDetailsViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblProducer: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnFavorite: UIButton!
    @IBOutlet weak var productImageCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    let productDetailsViewModel = ProductDetailsViewModel()
    let dbManager = DataBaseManager()
    
    var productId: Int?
    var productIds:[ProductData] = []
    
    private var timer: Timer!
    private var currImg: Int = 0
    var isFavorite: Bool = false
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        setProductDetails()
        getFavorite()
        setUpNav()
    }
    
    private func setUpNav(){
        setNavBarStyle(fontSize: 16)
        navigationItem.title = NavTitle.productDetails.rawValue
    }
    
    private func setUpUI(){
        
        let product = productDetailsViewModel.productDetail
        lblName.text = product?.name
        lblProducer.text = product?.producer
        lblPrice.text = "Rs: \(product?.cost ?? 0)"
        lblRating.text = "Rating: \(product?.rating ?? 0)"
        lblDescription.text = product?.dataDescription
        productImageCollectionView.reloadData()
        checkFavorite()
        pageControl.numberOfPages = productDetailsViewModel.productImages.count
    }
    
    private func setUpCollectionView(){
        productImageCollectionView.delegate = self
        productImageCollectionView.dataSource = self
        
        productImageCollectionView.register(UINib(nibName: CellNames.ProductImgCell.rawValue, bundle: nil), forCellWithReuseIdentifier: CellNames.ProductImgCell.rawValue)
    }
    
    private func setProductDetails(){
        productDetailsViewModel.callFetchProductList(productId: productId ?? 0) { response in
            DispatchQueue.main.async {
                switch response{
                case .success(_):
                    self.setUpUI()
                case .failure(let error):
                    self.showAlert(title: AlertText.Title.error.rawValue, msg: error.localizedDescription, okClosure: nil)
                }
            }
        }
    }
    
    private func getFavorite(){
        productIds = dbManager.getFavorite() ?? []
    }
    
    private func checkFavorite(){
        for i in productIds{
            if i.productId == productId ?? -1{
                isFavorite = true
                btnFavorite.isSelected = true
            }
        }
    }
    
    private func getProductData()-> ProductData?{
        for i in productIds{
            if i.productId == productId ?? -1{
                return i
            }
        }
        return nil
    }
    
    //MARK: - IBActions
    @IBAction func pageChange(_ sender: UIPageControl) {
        let current = sender.currentPage
        let indexPath = IndexPath(item: current, section: 0)
        productImageCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        currImg = current
    }
    
    @IBAction func btnFavoriteTapped(_ sender: UIButton) {
        getFavorite()
        if isFavorite {
            if let productData = getProductData() {
                if let errorMessage = dbManager.deleteFavorite(productData: productData) {
                    showAlert(title: AlertText.Title.error.rawValue, msg: errorMessage, okClosure: nil)
                } else {
                    showAlert(title: AlertText.Title.success.rawValue, msg: AlertText.message.removedFav.rawValue, okClosure: nil)
                    isFavorite = false
                    btnFavorite.isSelected = false 
                }
            }
        } else {
            if let errorMessage = dbManager.saveFavorite(productID: productId ?? -1) {
                showAlert(title: AlertText.Title.error.rawValue, msg: errorMessage, okClosure: nil)
            } else {
                showAlert(title: AlertText.Title.success.rawValue, msg: AlertText.message.savedFav.rawValue, okClosure: nil)
                isFavorite = true
                btnFavorite.isSelected = true
            }
        }
    }
}

//MARK: - CollectionView Delegate and DataSource
extension ProductDetailsViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productDetailsViewModel.productImages.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellNames.ProductImgCell.rawValue, for: indexPath) as? ProductImgCell
        cell?.productImg.sd_setImage(with: URL(string: productDetailsViewModel.productImages[indexPath.row].image ?? ""))
        return cell ?? UICollectionViewCell()
    }
}

//MARK: - CollectionView DelegateFlowLayout
extension ProductDetailsViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return  0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return  0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
}
