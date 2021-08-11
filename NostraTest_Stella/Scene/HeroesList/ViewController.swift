//
//  ViewController.swift
//  NostraTest_Stella
//
//  Created by Stella Patricia on 11/08/21.
//  Copyright © 2021 Stella Patricia. All rights reserved.
//

import UIKit
import  SDWebImage

class ViewController: UIViewController {

    var presenter: HomeViewViewToPresenterProtocol?

    @IBOutlet weak var collView: UICollectionView!
    @IBOutlet weak var clearSearchBtn: UIButton!
    @IBOutlet weak var sortByHealthBtn: UIButton!
    @IBOutlet weak var sortByAttackBtn: UIButton!
    @IBOutlet weak var sortByManaBtn: UIButton!
    @IBOutlet weak var sortBySpeedBtn: UIButton!
    @IBOutlet weak var searchTF: UITextField!
    
    // FILTER UI
    @IBOutlet weak var filterBackgroundView: UIView!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var filterCarryBtn: UIButton!
    @IBOutlet weak var filterDisablerBtn: UIButton!
    @IBOutlet weak var filterDurableBtn: UIButton!
    @IBOutlet weak var filterEscapeBtn: UIButton!
    @IBOutlet weak var filterInitiatorBtn: UIButton!
    @IBOutlet weak var filterJunglerBtn: UIButton!
    @IBOutlet weak var filterNukkerBtn: UIButton!
    @IBOutlet weak var filterPusherBtn: UIButton!
    @IBOutlet weak var filterSupportBtn: UIButton!
    
    var heroes: [HeroesModel]?
    var filteredHeroes: [HeroesModel]?
    
    var sort: sortType = sortType.none
    var sortOrder: sortTypeOrder = sortTypeOrder.highest
    
    var filterList: [String] = []
    var likeList: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        clearSearchBtn.isHidden = true
        
        collView.delegate = self
        collView.dataSource = self
        
        collView.register(UINib(nibName: "HeroCell", bundle: nil), forCellWithReuseIdentifier: "heroCell")
        
        presenter = HomeViewRouter.initPresenter(vc: self)
        
        closeFilterView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        let defaults = UserDefaults.standard
        likeList = defaults.array(forKey: "LikeArray") as? [Int] ?? [Int]()
        
        presenter?.startFetchingData()
        
    }
    
    @IBAction func searchTFEdited(_ sender: Any) {
        if searchTF.text == "" {
            clearSearchBtn.isHidden = true
        } else {
            clearSearchBtn.isHidden = false
        }
    }
    
    @IBAction func clearSearchBtnTapped(_ sender: Any) {
        searchTF.text = ""
        clearSearchBtn.isHidden = true
        filterHeroes()
    }
    
    @IBAction func searchBtnTapped(_ sender: Any) {
        filterHeroes()
    }
    
    @IBAction func filterBtnTapped(_ sender: Any) {
        openFilterView()
    }
    
    @IBAction func sortByHealthBtnTapped(_ sender: Any) {
        if sort != sortType.health || (sort == sortType.health && sortOrder == sortTypeOrder.lowest) {
            clearAllSort()
            sort = sortType.health
            sortOrder = sortTypeOrder.highest
            
            sortByHealthBtn.setImage(IMG_CONSTANT.UP_ICON, for: .normal)
        } else {
            sortOrder = sortTypeOrder.lowest
            
            sortByHealthBtn.setImage(IMG_CONSTANT.DOWN_ICON, for: .normal)
        }
        filterHeroes()
    }
    
    @IBAction func sortByAttackBtnTapped(_ sender: Any) {
        if sort != sortType.attack || (sort == sortType.attack && sortOrder == sortTypeOrder.lowest) {
            clearAllSort()
            sort = sortType.attack
            sortOrder = sortTypeOrder.highest
            
            sortByAttackBtn.setImage(IMG_CONSTANT.UP_ICON, for: .normal)
        } else {
            sortOrder = sortTypeOrder.lowest
            
            sortByAttackBtn.setImage(IMG_CONSTANT.DOWN_ICON, for: .normal)
        }
        filterHeroes()
    }
    
    @IBAction func sortByManaBtnTapped(_ sender: Any) {
        if sort != sortType.mana || (sort == sortType.mana && sortOrder == sortTypeOrder.lowest) {
            clearAllSort()
            sort = sortType.mana
            sortOrder = sortTypeOrder.highest
            
            sortByManaBtn.setImage(IMG_CONSTANT.UP_ICON, for: .normal)
        } else {
            sortOrder = sortTypeOrder.lowest
            
            sortByManaBtn.setImage(IMG_CONSTANT.DOWN_ICON, for: .normal)
        }
        filterHeroes()
    }
    
    @IBAction func sortBySpeedBtnTapped(_ sender: Any) {
        if sort != sortType.speed || (sort == sortType.speed && sortOrder == sortTypeOrder.lowest) {
            clearAllSort()
            sort = sortType.speed
            sortOrder = sortTypeOrder.highest
            
            sortBySpeedBtn.setImage(IMG_CONSTANT.UP_ICON, for: .normal)
        } else {
            sortOrder = sortTypeOrder.lowest
            
            sortBySpeedBtn.setImage(IMG_CONSTANT.DOWN_ICON, for: .normal)
        }
        filterHeroes()
    }
    
    @IBAction func clearSortBtnTapped(_ sender: Any) {
        filteredHeroes = heroes
        
        clearAllSort()
    }
    
    func clearAllSort() {
        
        sortByHealthBtn.setImage(nil, for: .normal)
        sortByAttackBtn.setImage(nil, for: .normal)
        sortByManaBtn.setImage(nil, for: .normal)
        sortBySpeedBtn.setImage(nil, for: .normal)
        
        sort = sortType.none
        sortOrder = sortTypeOrder.highest
        
        filterHeroes()
    }
    
    func filterHeroes() {
        filteredHeroes = heroes
        
        // SORT
        if sort == sortType.health {
            if sortOrder == sortTypeOrder.highest {
                filteredHeroes?.sort(by: { ($0.baseHealth ?? 0.0) > ($1.baseHealth ?? 0.0)})
            } else {
                filteredHeroes?.sort(by: { ($0.baseHealth ?? 0.0) < ($1.baseHealth ?? 0.0)})
            }
        } else if sort == sortType.attack {
            if sortOrder == sortTypeOrder.highest {
                filteredHeroes?.sort(by: { ($0.baseAttackMin ?? 0.0) > ($1.baseAttackMin ?? 0.0)})
            } else {
                filteredHeroes?.sort(by: { ($0.baseAttackMin ?? 0.0) < ($1.baseAttackMin ?? 0.0)})
            }
        } else if sort == sortType.mana {
            if sortOrder == sortTypeOrder.highest {
                filteredHeroes?.sort(by: { ($0.baseMana ?? 0.0) > ($1.baseMana ?? 0.0)})
            } else {
                filteredHeroes?.sort(by: { ($0.baseMana ?? 0.0) < ($1.baseMana ?? 0.0)})
            }
        } else if sort == sortType.speed {
            if sortOrder == sortTypeOrder.highest {
                filteredHeroes?.sort(by: { ($0.moveSpeed ?? 0.0) > ($1.moveSpeed ?? 0.0)})
            } else {
                filteredHeroes?.sort(by: { ($0.moveSpeed ?? 0.0) < ($1.moveSpeed ?? 0.0)})
            }
        }
        
        // FILTER
        if filterList != [] {
            var tempData: [HeroesModel] = []
            for i in 0..<( filteredHeroes?.count ?? 0 ) {
                var filterExist = false
                for j in 0..<filterList.count {
                    if (filteredHeroes?[i].roles ?? []).contains(filterList[j]) {
                        filterExist = true
                    }
                }
                if filterExist {
                    guard let data = filteredHeroes?[i] else { return }
                    tempData.append(data)
                }
            }
            filteredHeroes = tempData
        }
        
        // SEARCH
        if searchTF.text != "" {
            var tempData: [HeroesModel] = []
            for i in 0..<( filteredHeroes?.count ?? 0 ) {
                if (filteredHeroes?[i].name ?? "").contains(searchTF.text ?? "") {
                    guard let data = filteredHeroes?[i] else { return }
                    tempData.append(data)
                }
            }
            filteredHeroes = tempData
        }
        collView.reloadData()
    }
    
    @IBAction func filterCarryBtnTapped(_ sender: Any) {
        if filterList.contains("Carry") {
            filterList = filterList.filter { $0 != "Carry" }
            filterCarryBtn.setImage(IMG_CONSTANT.UNCHECK_ICON, for: .normal)
        } else {
            filterList.append("Carry")
            filterCarryBtn.setImage(IMG_CONSTANT.CHECK_ICON, for: .normal)
        }
    }
    
    @IBAction func filterDisablerBtnTapped(_ sender: Any) {
        if filterList.contains("Disabler") {
            filterList = filterList.filter { $0 != "Disabler" }
            filterDisablerBtn.setImage(IMG_CONSTANT.UNCHECK_ICON, for: .normal)
        } else {
            filterList.append("Disabler")
            filterDisablerBtn.setImage(IMG_CONSTANT.CHECK_ICON, for: .normal)
        }
    }
    
    @IBAction func filterDurableBtnTapped(_ sender: Any) {
        if filterList.contains("Durable") {
            filterList = filterList.filter { $0 != "Durable" }
            filterDurableBtn.setImage(IMG_CONSTANT.UNCHECK_ICON, for: .normal)
        } else {
            filterList.append("Durable")
            filterDurableBtn.setImage(IMG_CONSTANT.CHECK_ICON, for: .normal)
        }
    }
    
    @IBAction func filterEscapeBtnTapped(_ sender: Any) {
        if filterList.contains("Escape") {
            filterList = filterList.filter { $0 != "Escape" }
            filterEscapeBtn.setImage(IMG_CONSTANT.UNCHECK_ICON, for: .normal)
        } else {
            filterList.append("Escape")
            filterEscapeBtn.setImage(IMG_CONSTANT.CHECK_ICON, for: .normal)
        }
    }
    
    @IBAction func filterInitiatorBtnTapped(_ sender: Any) {
        if filterList.contains("Initiator") {
            filterList = filterList.filter { $0 != "Initiator" }
            filterInitiatorBtn.setImage(IMG_CONSTANT.UNCHECK_ICON, for: .normal)
        } else {
            filterList.append("Initiator")
            filterInitiatorBtn.setImage(IMG_CONSTANT.CHECK_ICON, for: .normal)
        }
    }
    
    @IBAction func filterJunglerBtnTapped(_ sender: Any) {
        if filterList.contains("Jungler") {
            filterList = filterList.filter { $0 != "Jungler" }
            filterJunglerBtn.setImage(IMG_CONSTANT.UNCHECK_ICON, for: .normal)
        } else {
            filterList.append("Jungler")
            filterJunglerBtn.setImage(IMG_CONSTANT.CHECK_ICON, for: .normal)
        }
    }
    
    @IBAction func filterNukkerBtnTapped(_ sender: Any) {
        if filterList.contains("Nukker") {
            filterList = filterList.filter { $0 != "Nukker" }
            filterNukkerBtn.setImage(IMG_CONSTANT.UNCHECK_ICON, for: .normal)
        } else {
            filterList.append("Nukker")
            filterNukkerBtn.setImage(IMG_CONSTANT.CHECK_ICON, for: .normal)
        }
    }
    
    @IBAction func filterPusherBtnTapped(_ sender: Any) {
        if filterList.contains("Pusher") {
            filterList = filterList.filter { $0 != "Pusher" }
            filterPusherBtn.setImage(IMG_CONSTANT.UNCHECK_ICON, for: .normal)
        } else {
            filterList.append("Pusher")
            filterPusherBtn.setImage(IMG_CONSTANT.CHECK_ICON, for: .normal)
        }
    }
    
    @IBAction func filterSupportBtnTapped(_ sender: Any) {
        if filterList.contains("Support") {
            filterList = filterList.filter { $0 != "Support" }
            filterSupportBtn.setImage(IMG_CONSTANT.UNCHECK_ICON, for: .normal)
        } else {
            filterList.append("Support")
            filterSupportBtn.setImage(IMG_CONSTANT.CHECK_ICON, for: .normal)
        }
    }
    
    @IBAction func filterCloseBtnTapped(_ sender: Any) {
        closeFilterView()
    }
    
    @IBAction func filterApplyBtnTapped(_ sender: Any) {
        filterHeroes()
        closeFilterView()
    }
    
    
    @IBAction func clearFilterBtnTapped(_ sender: Any) {
        filterList = []
        filterCarryBtn.setImage(IMG_CONSTANT.UNCHECK_ICON, for: .normal)
        filterDisablerBtn.setImage(IMG_CONSTANT.UNCHECK_ICON, for: .normal)
        filterDurableBtn.setImage(IMG_CONSTANT.UNCHECK_ICON, for: .normal)
        filterEscapeBtn.setImage(IMG_CONSTANT.UNCHECK_ICON, for: .normal)
        filterInitiatorBtn.setImage(IMG_CONSTANT.UNCHECK_ICON, for: .normal)
        filterJunglerBtn.setImage(IMG_CONSTANT.UNCHECK_ICON, for: .normal)
        filterNukkerBtn.setImage(IMG_CONSTANT.UNCHECK_ICON, for: .normal)
        filterPusherBtn.setImage(IMG_CONSTANT.UNCHECK_ICON, for: .normal)
        filterSupportBtn.setImage(IMG_CONSTANT.UNCHECK_ICON, for: .normal)
    }
    
    func closeFilterView() {
        filterView.isHidden = true
        filterBackgroundView.isHidden = true
    }
    
    func openFilterView() {
        filterView.isHidden = false
        filterBackgroundView.isHidden = false
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        let cellSize = CGSize(width: (screenWidth-24)/2, height: ((screenWidth-24)/2)*41/51)
        
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredHeroes?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "heroCell", for: indexPath) as? HeroCell
    
        cell?.imgView.sd_setImage(with: URL(string: API_CONSTANT.BASE_URL + (filteredHeroes?[indexPath.row].img ?? "" )), placeholderImage: nil)
        cell?.nameLbl.text = filteredHeroes?[indexPath.row].localizedNamed ?? "[NO_NAME_FOUND]"
        
        if likeList.contains(filteredHeroes?[indexPath.row].id ?? 0) {
            cell?.heartImg.isHidden = false
        } else {
            cell?.heartImg.isHidden = true
        }
        
        cell?.layoutIfNeeded()
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = HeroDetailViewController(nibName: "HeroDetailViewController", bundle: nil)
        vc.hero = filteredHeroes?[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: HomeViewPresenterToViewProtocol {
    func showData(array: Array<HeroesModel>?) {
        heroes = array
        filteredHeroes = array
        collView.reloadData()
    }
    
    func showError() {
        
    }
}
