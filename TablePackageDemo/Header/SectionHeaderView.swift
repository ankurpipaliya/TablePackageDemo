//
//  SectionHeaderView.swift
//  TablePackageDemo
//
//  Created by AnkurPipaliya on 25/08/23.
//

import UIKit

class SectionHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var sectionTitleLabel: UILabel!
    @IBOutlet weak var sectionSubtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureHeaderView(specification: Specification) {
        sectionTitleLabel.text = specification.name[0]
        sectionSubtitleLabel.text = "Choose 1"
    }
}
