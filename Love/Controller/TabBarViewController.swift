//
//  TabBarViewController.swift
//  Love
//
//  Created by Saruar on 17.06.2023.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        
        let vc1 = UINavigationController(rootViewController: ProgressViewController())
        let vc2 = UINavigationController(rootViewController: CalendarViewController())
        let vc3 = UINavigationController(rootViewController: QuotesViewController())
        let vc4 = UINavigationController(rootViewController: PhotosViewController())
        
        
        
        vc1.tabBarItem.image = UIImage(systemName: "shift.fill")
        vc2.tabBarItem.image = UIImage(systemName: "calendar")
        vc3.tabBarItem.image = UIImage(systemName: "quote.bubble")
        vc4.tabBarItem.image = UIImage(systemName: "photo")
        
        
        vc1.title = "So Far"
        vc2.title = "Calendar"
        vc3.title = "Quotes"
        vc4.title = "Photos"
        
        let appearance = UITabBarAppearance()
        appearance.backgroundEffect = UIBlurEffect(style: .light)
        tabBar.scrollEdgeAppearance = appearance
        
        tabBar.tintColor = .label
        
        
        setViewControllers([vc1, vc2, vc3, vc4], animated: true)
    }
    

}
