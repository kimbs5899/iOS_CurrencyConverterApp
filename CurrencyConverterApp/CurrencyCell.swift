//
//  CurrencyCell.swift
//  CurrencyConverterApp
//
//  Created by Designer on 2023/06/27.
//

import UIKit

class CurrencyCell: UITableViewCell {

    @IBOutlet private var leftLabel: UILabel!
    @IBOutlet private var rightLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    var rates: (String, Double)?
    func presentCurrency(rate: (String, Double), usdValue: Double) {
        
        let changedValue = (rate.1) * (usdValue)
        let resultValue = String(format: "%.2f", changedValue)
        
        self.rightLabel.text = resultValue.description
        self.leftLabel.text = rate.0
    }
    
}
