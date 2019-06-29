//
//  Menu.swift
//  Cubee
//
//  Created by Tomasz Kielar on 27/06/2019.
//  Copyright © 2019 Tomasz Kielar. All rights reserved.
//

import UIKit

class Menu : UICollectionViewFlowLayout,UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    var isMenuOpen : Bool = false
    let cellId = "cellId"
    let menuSettings = MenuOptions()
    var mainController : ViewController?
    let defaults = UserDefaults.standard
    let colors = Colors()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let settings = menuSettings.setSettingsTabs()
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = menuCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        let settings = menuSettings.setSettingsTabs()
        let setting = settings[indexPath.item]
        cell.setting = setting
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/1.2, height: collectionView.frame.width/1.2)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let settings = menuSettings.setSettingsTabs()
        let setting = settings[indexPath.item]
        print(setting.imgName)
        switch setting.imgName {
        case "account":
            initializeNewController(withIdentifier: "account")
        case "cube1":
            defaults.set("3x3", forKey: "cubeType")
            mainController?.sortingAlgorithmLabel.text = mainController?.makeSortingAlgorithm()
            initializeCubeChange()
        case "cube2":
            defaults.set("2x2", forKey: "cubeType")
            mainController?.sortingAlgorithmLabel.text = mainController?.makeSortingAlgorithm()
            initializeCubeChange()
        case "cube3":
            defaults.set("Piraminx", forKey: "cubeType")
            mainController?.sortingAlgorithmLabel.text = mainController?.makeSortingAlgorithm()
            initializeCubeChange()
        case "options":
            initializeNewController(withIdentifier: "options")
        default:
            print("nothing happens")
        }
        
    }
    
    let blackView = UIView()
    let menuCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    func darkenBackground (view : UIView) {
        
        blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        view.addSubview(blackView)
        blackView.frame = view.frame
        blackView.alpha = 0
        
        UIView.animate(withDuration: 0.5, animations: {
            self.blackView.alpha = 1
        })
        
    }
    func showMenu(view: UIView) {
        let startingMenuPosition = CGRect(x: 0, y: 0, width: 0, height: view.frame.height)
        let endPosition = CGRect(x: 0, y: 0, width: view.frame.width/1.85, height: view.frame.height)
        view.addSubview(menuCollectionView)
        menuCollectionView.frame = startingMenuPosition
        if let chosentheme = defaults.string(forKey: "theme"){
            if chosentheme == "light" {
                menuCollectionView.backgroundColor = colors.backgroundLight
            }
            else if chosentheme == "dark" {
                menuCollectionView.backgroundColor = colors.backgroundDark
                menuCollectionView.layer.masksToBounds = false
                menuCollectionView.layer.shadowColor = UIColor.white.cgColor
                menuCollectionView.layer.shadowOpacity = 0.5
                menuCollectionView.layer.shadowOffset = CGSize(width: 5, height: 0)
                menuCollectionView.layer.shadowRadius = 3
            }
        }
    
        menuCollectionView.alpha = 0
            UIView.animate(withDuration: 0.5, animations: {
            self.menuCollectionView.frame = endPosition
        })
        UIView.animate(withDuration: 0.5, delay: 0.15, options: [], animations: {
            self.menuCollectionView.alpha = 1
        }, completion:nil)
        isMenuOpen = true
    }
    func initializeNewController(withIdentifier : String ) {
        if let view = mainController?.view {
            let startingMenuPosition = CGRect(x: 0, y: 0, width: 0, height: view.frame.height)
            
            UIView.animate(withDuration: 0.5, animations: {
                self.blackView.alpha = 0
                self.menuCollectionView.frame = startingMenuPosition
            }, completion: {
                (idkwhatsthat : Bool ) in
                self.mainController?.performSegue(withIdentifier: withIdentifier, sender: self.mainController.self)
            })
            isMenuOpen = false
        }
    }
    func initializeCubeChange() {
        if let view = mainController?.view {
            let startingMenuPosition = CGRect(x: 0, y: 0, width: 0, height: view.frame.height)
            
            UIView.animate(withDuration: 0.5, animations: {
                self.blackView.alpha = 0
                self.menuCollectionView.frame = startingMenuPosition
            }, completion: {
                (idkwhatsthat : Bool ) in
                print("cube has been changed")
            })
            isMenuOpen = false
        }
    }
    
    override init() {
        super.init()
        menuCollectionView.dataSource = self
        menuCollectionView.delegate = self
        menuCollectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
