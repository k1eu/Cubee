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
    var mainController : ViewController?
    let settings : [SettingsCell] = [
    SettingsCell(labelText: "Nickname", imgName: "account"),
    SettingsCell(labelText: "Kostka1", imgName: nil),
    SettingsCell(labelText: nil, imgName: "account"),
    SettingsCell(labelText: nil, imgName: "options")
    ]
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = menuCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        let setting = settings[indexPath.item]
        cell.setting = setting
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height/4.3)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let setting = settings[indexPath.item]
        print(setting.imgName)
        switch setting.imgName {
        case "account":
            initializeNewController(withIdentifier: "account")
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
        menuCollectionView.backgroundColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1.0)
        menuCollectionView.alpha = 1
        
        UIView.animate(withDuration: 0.5, animations: {
            self.menuCollectionView.frame = endPosition
        })
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
