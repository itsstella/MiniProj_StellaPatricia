//
//  HeroDetailViewController.swift
//  NostraTest_Stella
//
//  Created by Stella Patricia on 11/08/21.
//  Copyright © 2021 Stella Patricia. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class HeroDetailViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var rolesLbl: UILabel!
    @IBOutlet weak var attackTypeLbl: UILabel!
    @IBOutlet weak var attributeLbl: UILabel!
    @IBOutlet weak var baseHealthLbl: UILabel!
    @IBOutlet weak var baseAttackLbl: UILabel!
    @IBOutlet weak var baseManaLbl: UILabel!
    @IBOutlet weak var baseSpeedLbl: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    
    var hero: HeroesModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgView.sd_setImage(with: URL(string: API_CONSTANT.BASE_URL + (hero?.img ?? "" )), placeholderImage: nil)
        nameLbl.text = hero?.localizedNamed ?? ""
        var roles = ""
        for i in 0..<(hero?.roles?.count ?? 0) {
            if i == (hero?.roles?.count ?? 0)-1 {
                roles += hero?.roles?[i] ?? ""
            } else {
                roles += (hero?.roles?[i] ?? "")+", "
            }
        }
        rolesLbl.text = roles
        
        let defaults = UserDefaults.standard
        let likeList = defaults.array(forKey: "LikeArray") as? [Int] ?? [Int]()
        if likeList.contains(hero?.id ?? 0) {
            likeBtn.setImage(IMG_CONSTANT.LIKE_ICON, for: .normal)
        } else {
            likeBtn.setImage(IMG_CONSTANT.UNLIKE_ICON, for: .normal)
        }
        
        attackTypeLbl.text = hero?.attackType
        attributeLbl.text = hero?.primaryAttr
        baseHealthLbl.text = "\(hero?.baseHealth ?? 0)"
        baseAttackLbl.text = "\(hero?.baseAttackMin ?? 0)" + " - " + "\(hero?.baseAttackMax ?? 0)"
        baseManaLbl.text = "\(hero?.baseMana ?? 0)"
        baseSpeedLbl.text = "\(hero?.moveSpeed ?? 0)"
        
    }
    
    @IBAction func previousBtnTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func likeBtnTapped(_ sender: Any) {
        let defaults = UserDefaults.standard
        var likeList = defaults.array(forKey: "LikeArray") as? [Int] ?? [Int]()
        if likeList.contains(hero?.id ?? 0) {
            likeBtn.setImage(IMG_CONSTANT.UNLIKE_ICON, for: .normal)
            
            likeList = likeList.filter { $0 != hero?.id ?? 0 }
        } else {
            likeBtn.setImage(IMG_CONSTANT.LIKE_ICON, for: .normal)
            
            likeList.append(hero?.id ?? 0)
        }
        defaults.set(likeList, forKey: "LikeArray")
    }
}
