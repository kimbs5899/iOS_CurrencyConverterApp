//
//  ViewController.swift
//  CurrencyConverterApp
//
//  Created by Designer on 2023/06/23.
//

import UIKit

class PickerViewController: UIViewController {
    
    @IBOutlet weak var usdTextField: UITextField!
    @IBOutlet weak var selectedCurrency: UITextField!
    @IBOutlet weak var selectedCurrencyName: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var rates: [(String, Double)]?
    
    var selectedRow = 0 {
        didSet {
            selectedCurrencyName.text = rates?[selectedRow].0
            selectedCurrency.text = calculateCurrency()
        }
    }
    
    func calculateCurrency() -> String {
        let selectedValue = rates?[selectedRow].1 ?? 0
        let usdValue = Double(usdTextField.text ?? "") ?? 0
        let resultValue = String(format: "%.2f", (selectedValue * usdValue))
        
        return resultValue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Currency Converter Picker"
        
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        
        usdTextField.delegate = self
        
        fetchJson()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    func fetchJson() {
        // closure 타입
        //        NetworkLayer.fetchJson { model in
        //            self.rates = model.rates?.sorted{ $0 < $1 }
        //
        //            DispatchQueue.main.async {
        //                self.currencyPicker.reloadAllComponents()
        //            }
        //        }
        
        // async await 타입
        Task {
            do{
                let model = try await NetworkLayer.fetchJsonAsyncAwait()
                self.rates = model.rates?.sorted{ $0 < $1 }
                self.currencyPicker.reloadAllComponents()
            }catch{
                print("error", error)
            }
        }
    }
}

extension PickerViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        selectedCurrency.text = calculateCurrency()
    }
}

extension PickerViewController: UIPickerViewDelegate,
                                UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return rates?.count ?? 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let key = rates?[row].0 ?? ""
        let value = rates?[row].1.description ?? ""
        
        return key + "   " + value
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = row
    }
    func hideKeyboardWhenTappedAround() {
        let _: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
