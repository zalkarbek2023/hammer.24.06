//
//  TabBarViewController.swift
//  Hammer.23.06
//
//  Created by zalkarbek on 23/6/23.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.cornerRadius = 10
        view.backgroundColor = .systemGray5
        generateTabBar()
    }
    
    private func generateTabBar() {
        viewControllers = [
        generateVC(vc: ViewController(),
                       title: "Menu",
                       image: UIImage(systemName: "bag.circle")
                  ),
        generateVC(vc: ContactViewController(),
                   title: "Contact",
                   image: UIImage(systemName: "location.circle")
                  ),
        generateVC(vc: ProfileViewController(),
                   title: "Profile",
                   image: UIImage(systemName: "person.circle")
                  ),
        generateVC(vc: KorzinaViewController(),
                   title: "Korzina",
                   image: UIImage(systemName: "cart.circle")
                  )
        ]
    }
    
    private func generateVC(vc: UIViewController, title: String, image: UIImage?) -> UIViewController {
        vc.tabBarItem.title = title
        vc.tabBarItem.image = image
        return vc
    }
    
}
