//
//  CatalogPresenter.swift
//  IdillikaMVP
//
//  Created by Асельдер on 05.08.2020.
//  Copyright © 2020 Асельдер. All rights reserved.
//

import Foundation


//MARK: - protocols

protocol CatalogViewProtocol: class { // Спросить почему наследуют именно классы
    func showLoading()
    func hideLoading()
    func success()
    func failure(error: Error)
}

protocol CatalogPresenterProtocol: class {
    init(view: CatalogViewProtocol, networkService: NetworkServiceProtocol)
    func getAllClothes()
    var catalogItems: [MainCatalogItems]? {get set}
}


//MARK: - classes

class CatalogPresenter: CatalogPresenterProtocol {
    required init(view: CatalogViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        getAllClothes()
    }
    
    weak var view: CatalogViewProtocol?
    var networkService: NetworkServiceProtocol
    var catalogItems: [MainCatalogItems]?
    
    func getAllClothes() {
        view?.showLoading()
        networkService.getAllClothes { [weak self] result in
            guard let self = self else {return}
            DispatchQueue.main.async {
                switch result {
                case .success(let catalogItem):
                    self.catalogItems = catalogItem
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
                self.view?.hideLoading()
            }
        }
    }
}
