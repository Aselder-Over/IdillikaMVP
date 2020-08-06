//
//  BagVC.swift
//  IdillikaMVP
//
//  Created by Асельдер on 05.08.2020.
//  Copyright © 2020 Асельдер. All rights reserved.
//

import UIKit

class BagVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem(title: " ", style: .plain, target: self, action: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        let basketButton = UIBarButtonItem(image: UIImage(named: "trash"), style: .plain, target: self, action: nil)
        
        self.navigationItem.rightBarButtonItem = basketButton
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.lightGray

    }
    @IBAction func backCatalogButton(_ sender: Any) {
        // Засовываем в переменную файл сторибоарда
        // let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.navigationController?.popViewController(animated: true)
    }
}
