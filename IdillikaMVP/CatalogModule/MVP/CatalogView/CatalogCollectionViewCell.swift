//
//  CatalogCollectionViewCell.swift
//  IdillikaMVP
//
//  Created by Асельдер on 05.08.2020.
//  Copyright © 2020 Асельдер. All rights reserved.
//

import UIKit
import SDWebImage

class CollectionViewCell: UICollectionViewCell {


    @IBOutlet weak var clothesImg: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    private var currentItem: MainCatalogItems!
    
    func setData(catalogItem: MainCatalogItems) {
        
        //собираем объекты
        currentItem = catalogItem
        
        //спарсинговые объекты передаем в подготовленные на вью их места
        if let image = catalogItem.imageLink {
            clothesImg.sd_setImage(with: URL(string: image), completed: nil)
        }
        
        // Размер изображения
        let imageWidth = Double(self.frame.width)
        let imageHeight = imageWidth * 1.26
        clothesImg.frame = CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)
        
        
        nameLabel.text = catalogItem.title?.capitalized
        descriptionLabel.text = catalogItem.brand?.capitalized
        priceLabel.text = String(catalogItem.price ?? 0) + " ₽"
        
        // Проверка ЮсерДефаултс
        if Clothes.shared.isFavorite(item: catalogItem) {
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    @IBAction func favoriteButtonAction(_ sender: Any) {
        let _ = Clothes.shared.checkFavoriteOnClick(item: currentItem)
        if Clothes.shared.isFavorite(item: currentItem) {
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
}
