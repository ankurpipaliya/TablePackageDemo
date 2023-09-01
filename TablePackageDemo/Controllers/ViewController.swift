//
//  ViewController.swift
//  TablePackageDemo
//
//  Created by AnkurPipaliya on 21/08/23.
//

import UIKit

class ViewController: UIViewController {
    
    let viewModel = ViewModel()
    var total : String?
    
    @IBOutlet weak var lblPackageTotal: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
   
    @IBAction func btnCustomizeAction(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "MakeYourOwnPackageVC") as! MakeYourOwnPackageVC
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromTop
        self.navigationController?.view.layer.add(transition, forKey: nil)
        viewController.callBack = { vals in
            print(vals)
            self.lblPackageTotal.text = "₹" + " " + vals
        }
        self.navigationController?.pushViewController(viewController, animated: false)
    }
}
    


