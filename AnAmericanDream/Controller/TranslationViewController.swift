//
//  TranslationViewController.swift
//  AnAmericanDream
//
//  Created by Hugues Fils Caparos on 07/02/2020.
//  Copyright © 2020 Hugues Fils Caparos. All rights reserved.
//

import UIKit

class TranslationViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var langageSelector: UISegmentedControl!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var tradButton: UIButton!
    @IBOutlet weak var tradLabel: UILabel!
    
    let service = TranslationService()
    
    private var source = "fr"
    private var destination = "en"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customLayout()
        textView.text = "Enter text here"
        textView.textColor = .lightGray
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.returnKeyType = .continue
        textView.delegate = self
    }
    
    // MARK: - UITextViewDelegates
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Enter text here" {
            textView.text = ""
            textView.textColor = .black
        }
    }
 
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter text here"
            textView.textColor = .lightGray
            textView.returnKeyType = .continue
        }
    }
    
    @IBAction private func tappedSegmentedIndex(_ sender: UISegmentedControl) {
        switch langageSelector.selectedSegmentIndex {
        case 0:   source = "fr"; destination = "en"
        case 1:  source = "en"; destination = "fr"
        default:
            break
        }
    }
    
    @IBAction private func tappedTradButton () {
        service.getTranslation(text: textView.text, from: source, to: destination) { (response, error) in
            guard self.textView.text != "Enter text here" else {
                return
            }
            guard error == nil else {
                return
            }
            guard let translatedText = response?.data?.translations.first?.translatedText else {
                return
            }
            self.tradLabel.text = translatedText
        }
    }
    private func customLayout () {
        tradButton.customButton()
    }
    
    @IBAction private func dissmissKeyBoard(_ sender: UITapGestureRecognizer) {
        textView.resignFirstResponder()
    }
}
