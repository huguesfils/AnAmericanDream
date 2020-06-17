//
//  TabBarController.swift
//  AnAmericanDream
//
//  Created by Hugues Fils Caparos on 13/02/2020.
//  Copyright © 2020 Hugues Fils Caparos. All rights reserved.
//

import Foundation
import UIKit

let appDelegate = UIApplication.shared.delegate as! AppDelegate

class TabBarController: UITabBarController {

    override func viewDidAppear(_ animated: Bool) {
        if appDelegate.hasAlreadyLaunched == true {
            //set hasAlreadyLaunched to false
            appDelegate.sethasAlreadyLaunched()
            //display segue
            super.viewDidAppear(animated)
            performSegue(withIdentifier: "showHome", sender: nil)
        }
    }
}
