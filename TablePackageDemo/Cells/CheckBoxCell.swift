//
//  CheckBoxCell.swift
//  TablePackageDemo
//
//  Created by AnkurPipaliya on 22/08/23.
//

import UIKit

class CheckBoxCell: UITableViewCell {

    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var btnCheckBoxClick: UIButton!
    @IBOutlet weak var lblBHK: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
        
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var lblQuantity: UILabel!

    var tapCallback: (() -> Void)?
    var plusTapped: (() -> Void)?
    var minusTapped: (() -> Void)?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureUI()
    }
    
    func configureUI() {
        self.selectionStyle = .none
        self.btnPlus.layer.cornerRadius = 17
        self.btnMinus.layer.cornerRadius = 17
        btnCheckBoxClick.addTarget(self, action: #selector(checkBoxButtonTapped), for: .touchUpInside)
        btnPlus.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        btnMinus.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
    }
    
    func configureCell(_ list: List) {
        self.lblBHK.text = list.name[0]
        let stringPrice = String(format: "%.2f", list.price)
        self.lblPrice.text = "₹" + " " + stringPrice
        self.btnCheckBoxClick.isSelected = list.isDefaultSelected
        self.lblQuantity.text = " \(list.quantity + 1 )" 
        
        if list.isDefaultSelected {
            self.stackView.isHidden = false
        } else {
            self.stackView.isHidden = true
        }
//button property hide show
//        if list.quantity >= 1 {
//            btnMinus.isEnabled = true
//        } else {
//            btnMinus.isEnabled = false
//            //btnMinus.backgroundColor = .brown
//        }
    }

    @objc private func checkBoxButtonTapped() {
        tapCallback?()
    }
    
    @objc private func plusButtonTapped() {
        plusTapped?()
    }
    
    @objc private func minusButtonTapped() {
        minusTapped?()
    }
}
