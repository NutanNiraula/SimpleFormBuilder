//
//  BaseFormTableViewCell.swift
//  Hopper
//
//  Created by Nutan Niraula on 2/7/19.
//  Copyright © 2019 Nutan Niraula. All rights reserved.
//

import UIKit

protocol FormCellDelegate: class {
    func textChanged(inTextField textField: HighlightedTextField, text: String, isValidText: Bool, atRow row: Int)
}

class BaseFormTableViewCell: UITableViewCell, ViewIdentifiable, NibLoadable {

    @IBOutlet var formTextField: HighlightedTextField!
    @IBOutlet var textFieldTopConstraint: NSLayoutConstraint!
    @IBOutlet var textFieldBottomConstraint: NSLayoutConstraint!
    
    let constraintWithoutTitle: CGFloat = 10
    let constraintWithTitle: CGFloat = 18
    
    weak var delegate: FormCellDelegate?
    
    func set(formData: BaseFormModel?) {
        guard let data = formData else { return }
        tag = data.tag
        formTextField.validityDelegate = self
        formTextField.type = data.textType
        formTextField.placeholder = data.placeholder
        formTextField.text = data.text
        formTextField.titleLabel.alpha = data.hasTitleLabel ? 1.0 : 0.0
        textFieldTopConstraint.constant = data.hasTitleLabel ? constraintWithTitle : constraintWithoutTitle
        textFieldBottomConstraint.constant = data.hasTitleLabel ? constraintWithTitle : constraintWithoutTitle
        formTextField.setEnabled(state: data.isEnabled)
        delegate?.textChanged(inTextField: formTextField, text: data.text, isValidText: data.text.validate(rule: formTextField.validationRule).isValid, atRow: tag)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        formTextField.layoutSubviews()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //resetting these values to avoid problems on reusing cells
        formTextField.inputView = nil
        formTextField.validationRule = .none
    }
    
}

extension BaseFormTableViewCell: HighlightedTextFieldValidityDelegate {
    
    func text(in textField: HighlightedTextField, isValid: Bool, text: String) {
        delegate?.textChanged(inTextField: textField, text: textField.text ?? "", isValidText: isValid, atRow: tag)
    }
    
}
