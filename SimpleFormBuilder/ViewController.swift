//
//  ViewController.swift
//  SimpleFormBuilder
//
//  Created by Nutan Niraula on 4/14/19.
//  Copyright © 2019 Nutan Niraula. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var formTableView: FormTableView!
    @IBOutlet weak var formButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formTableView.formDelegate = self
        formTableView.formDataSource = self
    }

}

extension ViewController: FormTableDataSource, FormTableDelegate {
    
    func baseFormData(for tableView: UITableView) -> [BaseFormModel] {
        return [ProfileInformationType.fullName.model,
                ProfileInformationType.email.model,
                ProfileInformationType.address.model,
                ProfileInformationType.city.model,
                ProfileInformationType.state.model,
                ProfileInformationType.zip.model,
                ProfileInformationType.phone.model]
    }
    
    func tableView(_ tableView: FormTableView, textAtRow: String, row: Int) {
        print("The text at row \(row) that is being typed is \(textAtRow)")
    }
    
    func tableView(_ tableView: FormTableView, isValidForm: Bool) {
        formButton.isUserInteractionEnabled = isValidForm
        formButton.alpha = isValidForm ? 1.0 : 0.5
    }
    
}
