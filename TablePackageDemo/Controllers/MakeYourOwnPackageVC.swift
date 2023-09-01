//
//  MakeYourOwnPackageVC.swift
//  TablePackageDemo
//
//  Created by AnkurPipaliya on 22/08/23.
//

import UIKit

class MakeYourOwnPackageVC: UIViewController
{
    @IBOutlet weak var tblPackage: UITableView!
    @IBOutlet weak var lblTitleHeader: UILabel!
    @IBOutlet weak var activityView: UIView!
    @IBOutlet weak var btnTotal: UIButton!
    
    let viewModel = ViewModel()
    var callBack: ((_ totalPackage: String)-> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.registerCells()
        self.fetchData()
    }
    
    func setupUI() {
        self.tblPackage.separatorStyle = .none
        self.activityView.layer.cornerRadius = 5
    }
    
    func registerCells() {
        tblPackage.register(UINib(nibName: "ApartmentCell", bundle: nil), forCellReuseIdentifier: "ApartmentCell")
        tblPackage.register(UINib(nibName: "CheckBoxCell", bundle: nil), forCellReuseIdentifier: "CheckBoxCell")
        tblPackage.register(UINib(nibName: "SectionHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "SectionHeaderView")
    }
    
    func fetchData() {
        self.activityView.isHidden = false
        self.viewModel.fetchDataFromJSON { success, errorMessage in
            self.activityView.isHidden = true
            if success {
                self.lblTitleHeader.text = self.viewModel.formModel?.name[0]
                self.tblPackage.reloadData()
                self.updateTotal()
            } else {
                let alert = UIAlertController(title: errorMessage, message: nil, preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func updateTotal() {
        self.viewModel.calculateGrandTotal {
            let totalString = String(format: "%.2f", viewModel.grandTotal)
            btnTotal.setTitle("Add to cart: \(totalString)", for: .normal)
        }
    }
    
    @IBAction func btnTotalTapped(_ sender: Any) {
        self.viewModel.calculateGrandTotal {
            let totalString = String(format: "%.2f", viewModel.grandTotal)
            callBack?(totalString)
            print(totalString)
            navigationController?.popViewController(animated: true)
        }
    }
}

extension MakeYourOwnPackageVC : UITableViewDataSource, UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.formModel?.specifications.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = self.tblPackage.dequeueReusableHeaderFooterView(withIdentifier: "SectionHeaderView") as! SectionHeaderView
        headerView.frame = CGRect(x: 0, y: 0, width: 1000, height: 70)
        if let specification = viewModel.formModel?.specifications[section] {
            headerView.configureHeaderView(specification: specification)
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let specification = viewModel.formModel?.specifications[section]
        return specification?.list.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //condition for cell
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ApartmentCell") as! ApartmentCell
            if let specification = viewModel.formModel?.specifications[indexPath.section] {
                let list = specification.list[indexPath.row]
                cell.configureCell(list)
                cell.tapCallback = {
                    for listObject in specification.list {
                        listObject.isDefaultSelected = false
                    }
                    list.isDefaultSelected = true
                    self.tblPackage.reloadData()
                    self.updateTotal()
                }
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CheckBoxCell") as! CheckBoxCell
            if let specification = viewModel.formModel?.specifications[indexPath.section] {
                let list = specification.list[indexPath.row]
                cell.configureCell(list)
                cell.tapCallback = {
                    list.isDefaultSelected = !list.isDefaultSelected
                    if !list.isDefaultSelected {
                        list.quantity = 0
                    }
                    self.tblPackage.reloadData()
                    self.updateTotal()
                }
//                cell.checkBoxTapped = {
//                    list.quantity = Int(list.price) + list.quantity
//                    let indexPath = IndexPath(row: indexPath.row, section: indexPath.section)
//                    tableView.reloadRows(at: [indexPath], with: .none)
//                    self.updateTotal()
//                }
                cell.plusTapped = {
                    
                    list.quantity = list.quantity+1
                    let indexPath = IndexPath(row: indexPath.row, section: indexPath.section)
                    tableView.reloadRows(at: [indexPath], with: .none)
                    self.updateTotal()
                }
                cell.minusTapped = {
                    if list.quantity == 0 { return }
                    list.quantity = list.quantity-1
                    let indexPath = IndexPath(row: indexPath.row, section: indexPath.section)
                    tableView.reloadRows(at: [indexPath], with: .none)
                    self.updateTotal()
                }
                
                if list.quantity >= 1 {
                    print("list one")
                }
            }
            return cell
        }
    }
}
