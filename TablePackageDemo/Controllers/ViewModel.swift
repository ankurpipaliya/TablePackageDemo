//
//  ViewModel.swift
//  TablePackageDemo
//
//  Created by AnkurPipaliya on 26/08/23.
//

import Foundation
import UIKit

class ViewModel
{
    typealias CompletionHandlerData = (_ success: Bool, _ errorMessage: String?) -> Void
    typealias CompletionHandlerTotal = () -> Void

    var formModel: FormModel?
    var grandTotal: Double = 0.0

    func fetchDataFromJSON(completion: @escaping CompletionHandlerData) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if let url = Bundle.main.url(forResource: "item_data", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    self.formModel = try JSONDecoder().decode(FormModel.self, from: data)
                    completion(true, nil)
                } catch {
                    completion(false, "Error while loading JSON file")
                }
            }
        }
    }
    
    func calculateGrandTotal(completion: CompletionHandlerTotal) {
        grandTotal = 0
        guard let specifications = self.formModel?.specifications else { return }
        for specification in specifications {
            for list in specification.list {
                if list.isDefaultSelected {
                    if specification.type == 1 {
                        grandTotal = grandTotal + list.price
                    } else {
                        //added line for suggested change in default selection of checkbox.
                        grandTotal = grandTotal + list.price
                        grandTotal = grandTotal + (list.price * Double(list.quantity))
                    }
                }
            }
        }
        completion()
    }
}

