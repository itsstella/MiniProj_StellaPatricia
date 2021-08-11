//
//  HeroesModel.swift
//  NostraTest_Stella
//
//  Created by Stella Patricia on 11/08/21.
//  Copyright © 2021 Stella Patricia. All rights reserved.
//

import Foundation
import ObjectMapper

class HeroesModel: Mappable {
    var id: Int?
    var name: String?
    var localizedNamed: String?
    var primaryAttr: String?
    var attackType: String?
    var roles: [String]?
    var img: String?
    var icon: String?
    var baseHealth: Double?
    var baseHealthRegen: Double?
    var baseMana: Double?
    var baseManaRegen: Double?
    var baseArmor: Double?
    var baseMr: Double?
    var baseAttackMin: Double?
    var baseAttackMax: Double?
    var baseStr: Double?
    var baseAgi: Double?
    var baseInt: Double?
    var strGain: Double?
    var agiGain: Double?
    var intGain: Double?
    var attackRange: Double?
    var projecttileSpeed: Double?
    var attackRate: Double?
    var moveSpeed: Double?
    var turnRate: Double?
    var cmEnabled: Bool = false
    var legs: Bool?
    var heroId: Int?
    var turboPicks: Int?
    var turboWins: Int?
    var proWin: Int?
    var proPick: Int?
    var proBan: Int?
    var pick1: Int?
    var win1: Int?
    var pick2: Int?
    var win2: Int?
    var pick3: Int?
    var win3: Int?
    var pick4: Int?
    var win4: Int?
    var pick5: Int?
    var win5: Int?
    var pick6: Int?
    var win6: Int?
    var pick7: Int?
    var win7: Int?
    var pick8: Int?
    var win8: Int?
    var nullPick: Int?
    var nullWin: Int?
    
    required init?(map:Map) {
        mapping(map: map)
    }
   
    func mapping(map:Map){
        id <- map["id"]
        name <- map["name"]
        localizedNamed <- map["localized_name"]
        primaryAttr <- map["primary_attr"]
        attackType <- map["attack_type"]
        roles <- map["roles"]
        img <- map["img"]
        icon <- map["icon"]
        baseHealth <- map["base_health"]
        baseHealthRegen <- map["base_health_regen"]
        baseMana <- map["base_mana"]
        baseManaRegen <- map["base_mana_regen"]
        baseArmor <- map["base_armor"]
        baseMr <- map["base_mr"]
        baseAttackMin <- map["base_attack_min"]
        baseAttackMax <- map["base_attack_max"]
        baseStr <- map["base_str"]
        baseAgi <- map["base_agi"]
        baseInt <- map["base_int"]
        strGain <- map["str_gain"]
        agiGain <- map["agi_gain"]
        intGain <- map["int_gain"]
        attackRange <- map["attack_range"]
        projecttileSpeed <- map["projectile_speed"]
        attackRate <- map["attack_rate"]
        moveSpeed <- map["move_speed"]
        turnRate <- map["turn_rate"]
        cmEnabled <- map["cm_enabled"]
        legs <- map["legs"]
        heroId <- map["hero_id"]
        turboPicks <- map["turbo_picks"]
        turboWins <- map["turbo_wins"]
        proWin <- map["pro_win"]
        proPick <- map["pro_pick"]
        proBan <- map["pro_ban"]
        pick1 <- map["1_pick"]
        win1 <- map["1_win"]
        pick2 <- map["2_pick"]
        win2 <- map["2_win"]
        pick3 <- map["3_pick"]
        win3 <- map["3_win"]
        pick4 <- map["4_pick"]
        win4 <- map["4_win"]
        pick5 <- map["5_pick"]
        win5 <- map["5_win"]
        pick6 <- map["6_pick"]
        win6 <- map["6_win"]
        pick7 <- map["7_pick"]
        win7 <- map["7_win"]
        pick8 <- map["8_pick"]
        win8 <- map["8_win"]
        nullPick <- map["null_pick"]
        nullWin <- map["null_win"]
    }
}

