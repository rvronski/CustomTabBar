//
//  CustomTabBarViewController.swift
//  CustomTabBar
//
//  Created by ROMAN VRONSKY on 31.12.2022.
//

import UIKit

class CustomTabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    
    
    
    override func viewDidLoad() {
        self.setupTabBar()
    }
    
    func setupTabBar() {
        let firstVC = UINavigationController(rootViewController: ViewController())
        let secondVC = UINavigationController(rootViewController: SecondViewController())
        let thirdVC = UINavigationController(rootViewController: ThirdViewController())
        self.viewControllers = [firstVC, secondVC, thirdVC]
        let itemsArray = ["house", "plus", "person"]
        guard let items = self.tabBar.items else {return}
        for i in 0..<items.count {
            items[i].image = UIImage(systemName: itemsArray[i])
        }
        
    }
    
}
