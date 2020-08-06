//
//  UserDefauls.swift
//  IdillikaMVP
//
//  Created by Асельдер on 05.08.2020.
//  Copyright © 2020 Асельдер. All rights reserved.
//

import Foundation

final class Clothes {
    
    //сингл тон
    static let shared = Clothes()
    
    //сингл тон
    private let key = "ru.diit.tipo_idillika"
    private var clothes: [MainCatalogItems] = []
    
    // MARK: - Init
    private init() {
        guard
            let data = UserDefaults.standard.data(forKey: key),
            let clothesFromDataBase = try? JSONDecoder().decode([MainCatalogItems].self, from: data) else { return }
        
        clothes.append(contentsOf: clothesFromDataBase)
    }
    
    // MARK: - Public methods
    func isFavorite(item: MainCatalogItems) -> Bool {
        
        if clothes.firstIndex(where: { $0.id == item.id}) != nil {
            return true
        } else {
            return false
        }
    }
    
    func checkFavoriteOnClick(item: MainCatalogItems) -> Bool {
        if let index = clothes.firstIndex(where: { $0.id == item.id}) {
            clothes.remove(at: index)
            
            //обновление данных юзерфалс
            synchronize()
            return true
        } else {
            clothes.append(item)
            synchronize()
            return false
        }
    }
    
    func clear() {
        clothes.removeAll()
        synchronize()
    }
    
    // MARK: - Private methods
    private func synchronize() {
        
        //обновление данных
        guard let clothes = try? JSONEncoder().encode(clothes) else { return }
        UserDefaults.standard.set(clothes, forKey: key)
    }
}
