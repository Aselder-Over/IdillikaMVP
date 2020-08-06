//
//  HomeVC.swift
//  IdillikaMVP
//
//  Created by Асельдер on 05.08.2020.
//  Copyright © 2020 Асельдер. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func showCatalogButton(_ sender: Any) {
        // Засовываем в переменную файл сторибоарда
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // ЗАсосываем во вторую перменную ВьюКонтроллер по ID
        let catalogVC = storyboard.instantiateViewController(identifier: "CatalogVC")
        // Пушим новый вью контроллер
        self.navigationController?.pushViewController(catalogVC, animated: true)
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.black
    }
    
}
