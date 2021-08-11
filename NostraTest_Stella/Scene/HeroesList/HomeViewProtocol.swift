//
//  HomeViewProtocol.swift
//  NostraTest_Stella
//
//  Created by Stella Patricia on 11/08/21.
//  Copyright © 2021 Stella Patricia. All rights reserved.
//

import Foundation
import UIKit

protocol HomeViewViewToPresenterProtocol: class{
    
    var view: HomeViewPresenterToViewProtocol? {get set}
    var interactor: HomeViewPresenterToInteractorProtocol? {get set}
    var router: HomeViewPresenterToRouterProtocol? {get set}
    func startFetchingData()
}

protocol HomeViewPresenterToViewProtocol: class{
    func showData(array:Array<HeroesModel>?)
    func showError()
}

protocol HomeViewPresenterToRouterProtocol: class {
    static func initPresenter(vc: ViewController) -> HomeViewViewToPresenterProtocol

}

protocol HomeViewPresenterToInteractorProtocol: class {
    var presenter: HomeViewInteractorToPresenterProtocol? {get set}
    func fetchData()
}

protocol HomeViewInteractorToPresenterProtocol: class {
    func dataFetchedSuccess(dataArray: Array<HeroesModel>?)
    func dataFetchFailed()
}
