//
//  TabBarController.swift
//  TinyApp-GetEmCold!
//
//  Created by C4Q on 2/24/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    //Actual tabs are created in storyBoard but this just hold a reference to that storyboard
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public static func storyboardInstance() -> TabBarController {
        let storyboard = UIStoryboard(name: "TabBar", bundle: nil) //name of the storyboard file
        let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController //name of VC file
        return tabBarController
    }
    
}
