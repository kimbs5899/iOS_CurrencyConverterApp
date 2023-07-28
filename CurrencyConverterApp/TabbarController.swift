//
//  TabbarController.swift
//  CurrencyConverterApp
//
//  Created by Designer on 2023/06/26.
//

import Foundation
import UIKit

class TabbarContoller: UITabBarController {
    override func viewDidLoad() {
        self.tabBar.items?[0].title = "Picker"
        self.tabBar.items?[0].image = UIImage(systemName: "filemenu.and.selection")
        
        self.tabBar.items?[1].title = "Table"
        self.tabBar.items?[1].image = UIImage(systemName: "list.bullet")
    }
    
}
