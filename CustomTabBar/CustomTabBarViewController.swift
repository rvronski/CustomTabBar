//
//  CustomTabBarViewController.swift
//  CustomTabBar
//
//  Created by ROMAN VRONSKY on 31.12.2022.
//

import UIKit

class CustomTabBarViewController: UITabBarController, UITabBarControllerDelegate {
   private var layerHeight = CGFloat()
    private var buttonIsTapped = false
    private lazy var middleButton: UIButton = {
        let button = UIButton()
        let image = UIImage.SymbolConfiguration(pointSize: 15, weight: .heavy, scale: .large)
        button.setImage(UIImage(systemName: "plus", withConfiguration: image), for: .normal)
        button.imageView?.tintColor = .white
        button.backgroundColor = #colorLiteral(red: 0.8919453621, green: 0.4421625409, blue: 0.6338356567, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    override func viewDidLoad() {
        self.setupTabBar()
    }
    
    func setupTabBar() {
        let layer = CAShapeLayer()
        
       
        let firstVC = UINavigationController(rootViewController: ViewController())
        let secondVC = UINavigationController(rootViewController: SecondViewController())
        let thirdVC = UINavigationController(rootViewController: ThirdViewController())
        self.viewControllers = [firstVC, secondVC, thirdVC]
        let itemsImage = ["house", "plus", "person"]
        let selectedImage = ["house.fill", "plus.circle.fill", "person.fill"]
        guard let items = self.tabBar.items else {return}
        for i in 0..<items.count {
            items[i].image = UIImage(systemName: itemsImage[i])
            items[i].selectedImage = UIImage(systemName: selectedImage[i])
        }
        
        let x: CGFloat = 10
        let y: CGFloat = 20
        
        let width = self.tabBar.bounds.width - x * 2
        let height = self.tabBar.bounds.height + y * 1.5
        layerHeight = height
        layer.fillColor = UIColor.black.cgColor
        layer.path = UIBezierPath(roundedRect: CGRect(x: x,
                                              y: self.tabBar.bounds.minY - y,
                                              width: width,
                                              height: height),
                                  cornerRadius: height / 2).cgPath
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 1
        
        self.tabBar.layer.insertSublayer(layer, at: 0)
        self.tabBar.tintColor = #colorLiteral(red: 0.8919453621, green: 0.4421625409, blue: 0.6338356567, alpha: 1)
        self.tabBar.itemWidth = width/6
        self.tabBar.itemPositioning = .centered
        self.tabBar.unselectedItemTintColor = .lightGray
        
        addMiddleButton()
    }
    
    private func addMiddleButton() {
        
        DispatchQueue.main.async {
            if let items = self.tabBar.items {
                items[1].isEnabled = false
            }
        }
        self.tabBar.addSubview(self.middleButton)
        let size = CGFloat(50)
        let constant: CGFloat = -20 + (layerHeight / 2) - 5
        
        NSLayoutConstraint.activate([
            self.middleButton.centerXAnchor.constraint(equalTo: self.tabBar.centerXAnchor),
            self.middleButton.centerYAnchor.constraint(equalTo: self.tabBar.topAnchor, constant: constant),
            self.middleButton.heightAnchor.constraint(equalToConstant: size),
            self.middleButton.widthAnchor.constraint(equalToConstant: size)


        ])
        
        self.middleButton.layer.cornerRadius = size / 2
        self.middleButton.addTarget(self, action: #selector(middleButtonDidTap), for: .touchUpInside)
    }
    
    @objc private func middleButtonDidTap() {
        if buttonIsTapped == false {
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.middleButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 4)
                self?.middleButton.backgroundColor = .white
                self?.middleButton.imageView?.tintColor = #colorLiteral(red: 0.8919453621, green: 0.4421625409, blue: 0.6338356567, alpha: 1)
                self?.middleButton.layer.borderWidth = 5
                self?.middleButton.layer.borderColor = #colorLiteral(red: 0.8919453621, green: 0.4421625409, blue: 0.6338356567, alpha: 1)
                self?.buttonIsTapped = true
                
            }
            
        } else {
            UIView.animate(withDuration: 0.15, animations: ({[weak self]
                self?.middleButton.transform = CGAffineTransform(rotationAngle: 0)
                self?.middleButton.backgroundColor = #colorLiteral(red: 0.8919453621, green: 0.4421625409, blue: 0.6338356567, alpha: 1)
                self?.middleButton.layer.borderWidth = 0
                self?.middleButton.imageView?.tintColor = .white
                
                
                self.buttonIsTapped = false
                
                
                
            }))
        }
    }
}
//#colorLiteral(red: 1, green: 0.8409774303, blue: 0.8370974064, alpha: 1)
