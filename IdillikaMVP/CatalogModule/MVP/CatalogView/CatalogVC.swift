//
//  ViewController.swift
//  IdillikaMVP
//
//  Created by Асельдер on 05.08.2020.
//  Copyright © 2020 Асельдер. All rights reserved.
//

import UIKit

class CatalogVC: UIViewController {

    @IBOutlet weak var catalogCollectionView: UICollectionView!
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    
    //инициализируем пресентор
    var myPresenter: CatalogPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "ОДЕЖДА"
        
        //теперь МайПресентер может принимать вью и сервис -- Он для того что бы через него обращались к пресентеру
        let networkService = MainCatalogService()
        myPresenter = CatalogPresenter(view: self, networkService: networkService)
        
        catalogCollectionView.dataSource = self
        catalogCollectionView.delegate = self
        
        
        let bagImage = UIImage(named: "bag")
        let basketButton = UIBarButtonItem(image: bagImage, style: .plain, target: self, action: #selector(goToBagFunc))
        
        let backButton = UIBarButtonItem(title: " ", style: .plain, target: self, action: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        self.navigationItem.rightBarButtonItem = basketButton
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        self.navigationController?.navigationBar.tintColor = UIColor.black
        
    }
    
    @objc func goToBagFunc() {
        
        // Засовываем в переменную файл сторибоарда
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // ЗАсосываем во вторую перменную ВьюКонтроллер по ID
        let catalogVC = storyboard.instantiateViewController(identifier: "BagVC")
        // Пушим новый вью контроллер
        self.navigationController?.pushViewController(catalogVC, animated: true)
    }

}



//MARK: - UICollection

extension CatalogVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // Возвращаем количество ячеек в collectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myPresenter.catalogItems?.count ?? 0 // Количество ячеек равняется количеству элементов массива презентера
    }
    
    // Возвращаем как будет выглядеть ячейка
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as? CollectionViewCell {
            
            itemCell.setData(catalogItem: myPresenter.catalogItems![indexPath.item])
            return itemCell
        }
        
        return UICollectionViewCell()
    }
    
    // Размер ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let cellWidth = ((collectionView.frame.width / 2) - (flowLayout.sectionInset.left + flowLayout.sectionInset.right) - flowLayout.minimumInteritemSpacing)
            
        return CGSize(width: cellWidth, height: cellWidth * 1.8)
    }
    
    // Действие при нажатии на ячейку
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
}


//MARK: - Protocols

extension CatalogVC: CatalogViewProtocol {
    
    func showLoading() {
        myActivityIndicator.startAnimating()
        myActivityIndicator.isHidden = false
    }
    
    func hideLoading() {
        myActivityIndicator.stopAnimating()
        myActivityIndicator.isHidden = true
    }
    
    func success() {
        catalogCollectionView.reloadData()
    }

    func failure(error: Error) {
        print(error.localizedDescription)
    }
}
