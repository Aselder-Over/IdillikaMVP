//
//  NetworkService.swift
//  IdillikaMVP
//
//  Created by Асельдер on 05.08.2020.
//  Copyright © 2020 Асельдер. All rights reserved.
//

import Foundation

import Foundation

protocol NetworkServiceProtocol {
    func getAllClothes(completionHandler: @escaping (Result<[MainCatalogItems]?, Error>) -> Void)
}

class MainCatalogService: NetworkServiceProtocol{
    //escaping po4itat
    //комплишн хендлер клоужер прочитать
    func getAllClothes(completionHandler: @escaping (Result<[MainCatalogItems]?, Error>) -> Void) {
        let mainCatalogURL = URL(string: "https://idillika.com/api/catalogList.php?section=21&session_id=f3e82db3d0b2bcce07eae17dd9cb46d3")!
        let task = URLSession.shared.dataTask(with: mainCatalogURL) { (data, response, error) in
            guard error == nil, let data = data else {
                return
            }
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            
            do {
                let catalogData = try? JSONDecoder().decode([MainCatalogItems].self, from: data)
            //completionHandler(catalogData)
                completionHandler(.success(catalogData))
            }
        }
        task.resume()
    }
}
