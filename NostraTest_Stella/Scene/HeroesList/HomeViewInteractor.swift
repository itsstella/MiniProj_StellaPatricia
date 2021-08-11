//
//  HomeViewInteractor.swift
//  NostraTest_Stella
//
//  Created by Stella Patricia on 11/08/21.
//  Copyright © 2021 Stella Patricia. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class HomeViewInteractor: HomeViewPresenterToInteractorProtocol{
    var presenter: HomeViewInteractorToPresenterProtocol?

    func fetchData() {
        
        let request = AF.request(API_CONSTANT.BASE_URL+API_CONSTANT.GETDATA_URL)
        
        request.responseJSON { (data) in
            switch data.result {
            case .success(let value):
                print(value)
                if let json = data.value as AnyObject? {
//                    let arrayResponse = json["data"] as? NSArray
                    let arrayObject = Mapper<HeroesModel>().mapArray(JSONArray: json as? [[String : Any]] ?? []);
                    self.presenter?.dataFetchedSuccess(dataArray: arrayObject)
                }
            case .failure(let error):
                print(error)
                self.presenter?.dataFetchFailed()
            }
        }
        
        
    }
}
