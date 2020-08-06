//
//  CatalogItems.swift
//  IdillikaMVP
//
//  Created by Асельдер on 05.08.2020.
//  Copyright © 2020 Асельдер. All rights reserved.
//

import Foundation

struct MainCatalogItems: Codable {
    var id: Int?
    var imageLink: String?
    var title: String?
    var price: Int?
    var available: Bool?
    var favorite: Bool?
    var brand: String?
}
