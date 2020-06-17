//
//  ExtensionLayout.swift
//  AnAmericanDream
//
//  Created by Hugues Fils Caparos on 19/03/2020.
//  Copyright © 2020 Hugues Fils Caparos. All rights reserved.
//

import UIKit

extension UITextField {
    func addShadow () {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
}

extension UIButton {
    func customButton () {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.cornerRadius = 4
    }
}

extension UITextView {
    func customTextView () {
        let borderColor: UIColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.00)
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 4
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
}

extension UILabel {
    func customLocName () {
        self.font = UIFont.systemFont(ofSize: 38, weight: .heavy)
        self.textColor = UIColor.link
    }
    func customTemp () {
        self.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
    }
    func customMain () {
        self.font = UIFont.systemFont(ofSize: 25, weight: .medium)
    }
}
