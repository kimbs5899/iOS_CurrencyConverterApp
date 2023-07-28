//
//  ListViewController.swift
//  CurrencyConverterApp
//
//  Created by Designer on 2023/06/26.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var inputUsbValue: UITextField!
    @IBOutlet weak var currencyTabelView: UITableView!
    
    var rates: [(String, Double)]?
    
    var usdValue: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputUsbValue.delegate = self
        currencyTabelView.delegate = self
        currencyTabelView.dataSource = self
        self.navigationItem.title = "Currency Converter List"
        
        let currencyCelNib = UINib(nibName: "CurrencyCell", bundle: nil)
        
        currencyTabelView.register(currencyCelNib, forCellReuseIdentifier: "CurrencyCell")
        fetchJson()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    func fetchJson() {
        NetworkLayer.fetchJson { model in
            self.rates = model.rates?.sorted{ $0 < $1 }
            DispatchQueue.main.async {
                self.currencyTabelView.reloadData()
            }
        }
    }
}

extension ListViewController : UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        usdValue = Double(textField.text ?? "")
        currencyTabelView.reloadData()
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rates?.count ?? 0
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath) as! CurrencyCell
        if let rate = self.rates?[indexPath.row]{
            cell.presentCurrency(rate: rate, usdValue: usdValue ?? 0)
        }
        return cell
    }
    func hideKeyboardWhenTappedAround() {
        let _: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
