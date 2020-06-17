//
//  CurrencyViewController.swift
//  AnAmericanDream
//
//  Created by Hugues Fils Caparos on 07/02/2020.
//  Copyright © 2020 Hugues Fils Caparos. All rights reserved.
//

import UIKit

class CurrencyViewController: UIViewController {
    
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var eurTextField: UITextField!
    @IBOutlet weak var usdTextField: UITextField!
    
    let service = CurrencyService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customLayout()
    }
    
    @IBAction private func tappedConvertButton() {
        service.getCurrency {(currencyResponse, error) in
            if let currencyResponse = currencyResponse {
                self.update(currencyResponse: currencyResponse)
            } else {
                self.presentAlert()
            }
        }
    }
    
    private func update(currencyResponse: CurrencyResponse) {
        guard let eurText = eurTextField.text?.replacingOccurrences(of: ",", with: "."), // currency formater text formater format currency swift
            let usdText = usdTextField.text?.replacingOccurrences(of: ",", with: "."),
            let usdRate = currencyResponse.rates["USD"]
            else { return }
        let newRate = 1 / usdRate
        if eurText.isEmpty == false {
            guard let userEurValue = Double(eurText) else { return }
            usdTextField.text = String(usdRate * userEurValue)
        } else {
            guard let userUsdValue = Double(usdText) else { return }
            eurTextField.text = String(userUsdValue * newRate)
        }
    }
    
    private func customLayout() {
        eurTextField.addShadow()
        usdTextField.addShadow()
        convertButton.customButton()
    }
    
    private func presentAlert() {
        let alertVC = UIAlertController(title: "Error", message: "Rates download failed.", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction private func dissmissKeyBoard(_ sender: UITapGestureRecognizer) {
        eurTextField.resignFirstResponder()
        usdTextField.resignFirstResponder()
    }
}
