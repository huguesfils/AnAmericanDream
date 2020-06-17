//
//  WelcomeViewController.swift
//  AnAmericanDream
//
//  Created by Hugues Fils Caparos on 07/02/2020.
//  Copyright © 2020 Hugues Fils Caparos. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var welcomeTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customWelcome()
        customLayout()
    }
    
    func customWelcome() {
        welcomeTextView.text = """
        Welcome !
        \n
        AnAmericanDream is the perfect companion app for your travel to the US.
        You can translate text from English to French and vice versa.
        Get weather conditions for your current location and convert euro to US dollar.
        \n
        AnAmericanDeam est la parfaite application pour votre voyage aux US.
        Vous pouvez traduire du texte de l'anglais vers le français et inversement.
        Récupérer les conditions météo de votre position et convertir des euros en dollard.
        \n
        Enjoy !
        """
    }
    
    @IBAction private func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
    
    private func customLayout () {
           okButton.customButton()
       }
}
