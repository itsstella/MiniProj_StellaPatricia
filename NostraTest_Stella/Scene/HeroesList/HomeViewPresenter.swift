//
//  HomeViewPresenter.swift
//  NostraTest_Stella
//
//  Created by Stella Patricia on 11/08/21.
//  Copyright © 2021 Stella Patricia. All rights reserved.
//

import Foundation
import UIKit

class HomeViewPresenter: HomeViewViewToPresenterProtocol {
    var view: HomeViewPresenterToViewProtocol?
    var interactor: HomeViewPresenterToInteractorProtocol?
    var router: HomeViewPresenterToRouterProtocol?
    
    func startFetchingData() {
        interactor?.fetchData()
    }
}

extension HomeViewPresenter: HomeViewInteractorToPresenterProtocol{
    func dataFetchedSuccess(dataArray: Array<HeroesModel>?) {
        view?.showData(array: dataArray)
    }
    
    func dataFetchFailed() {
        view?.showError()
    }
}
