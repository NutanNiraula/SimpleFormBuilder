//
//  FormTableView.swift
//  Hopper
//
//  Created by Nutan Niraula on 2/7/19.
//  Copyright © 2019 Nutan Niraula. All rights reserved.
//

import UIKit

protocol FormTableDataSource: class {
    func baseFormData(for tableView: UITableView) -> [BaseFormModel]
}

protocol FormTableDelegate: class {
    func tableView(_ tableView: FormTableView, textAtRow: String, row: Int)
    func tableView(_ tableView: FormTableView, isValidForm: Bool)
}

class FormTableView: UITableView {
    
    weak var formDataSource: FormTableDataSource? {
        didSet {
            guard let formDS = formDataSource else { return }
            formData = formDS.baseFormData(for: self)
            formData.forEach { [weak self] data in
                self?.isValidTextFields.append(data.text.validate(rule: data.textType.getValidationRule()).isValid)
            }
            dataSource = self
        }
    }
    
    weak var formDelegate: FormTableDelegate?
    
    var formData = [BaseFormModel]() {
        didSet {
            formDelegate?.tableView(self, isValidForm: formData.reduce(true, { (result, prev) -> Bool in
                return result && prev.text.validate(rule: prev.textType.getValidationRule()).isValid
            }))
        }
    }
    private var isValidTextFields = [Bool]()
    var isValidForm = false
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupViewStyle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViewStyle()
    }
    
    private func setupViewStyle() {
        showsVerticalScrollIndicator = false
        separatorStyle = .none
        allowsSelection = false
        register(BaseFormTableViewCell.self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        isScrollEnabled = contentSize.height > frame.height
    }
    
}

extension FormTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return formData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BaseFormTableViewCell = tableView.dequeueReusableCell()
        cell.delegate = self
        cell.set(formData: self.formData[indexPath.row])
        return cell
    }
    
}

extension FormTableView: FormCellDelegate {
    
    func textChanged(inTextField textField: HighlightedTextField, text: String, isValidText: Bool, atRow row: Int) {
        isValidTextFields[row] = isValidText
        formDelegate?.tableView(self, isValidForm: !isValidTextFields.contains(false))
        formData[row].text = text
        formDelegate?.tableView(self, textAtRow: text, row: row)
    }
    
}

extension UITableView {
    
    func register<T: UITableViewCell>(_: T.Type) where T: ViewIdentifiable {
        register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func register<T: UITableViewCell>(_: T.Type) where T: ViewIdentifiable, T: NibLoadable {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        register(nib, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>() -> T where T: ViewIdentifiable {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier) as? T else {
            fatalError("Could not dequeue cell with identified: \(T.defaultReuseIdentifier)")
        }
        return cell
    }
    
}
