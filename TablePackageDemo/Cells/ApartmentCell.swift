//
//  ApartmentCell.swift
//  TablePackageDemo
//
//  Created by AnkurPipaliya on 22/08/23.
//

import UIKit

class ApartmentCell: UITableViewCell {

    @IBOutlet weak var btnRadioClick: UIButton!
    @IBOutlet weak var lblBHK: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
        
    var tapCallback: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        btnRadioClick.addTarget(self, action: #selector(radioButtonTapped), for: .touchUpInside)
    }
    
    func configureCell(_ list: List) {
        self.lblBHK.text = list.name[0]
        let stringPrice = String(format: "%.2f", list.price)
        self.lblPrice.text = "₹" + " " + stringPrice
        self.btnRadioClick.isSelected = list.isDefaultSelected  
    }

    @objc private func radioButtonTapped() {
        tapCallback?()
    }
}
