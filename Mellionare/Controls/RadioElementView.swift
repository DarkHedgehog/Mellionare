//
//  RadioElementView.swift
//  Mellionare
//
//  Created by Aleksandr Derevenskih on 01.12.2022.
//

import UIKit

protocol RadioElementViewDelegate: AnyObject {
    func switchChanged(sender: RadioElementView, isOn: Bool)
    func textChanged(sender: RadioElementView, text: String)
}

@IBDesignable
class RadioElementView: UIView {    

    var delegate: RadioElementViewDelegate?

    private var switcher = UISwitch()
    private var textField = UITextField()

    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareElements()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        prepareElements()
    }


    public func setOn(_ on: Bool) {
        self.switcher.setOn(on, animated: true)
    }

    public func setPlaceholder(_ text: String) {
        textField.placeholder = text
    }

    public func setText(_ text: String) {
        textField.text = text
    }

    public func prepareElements() {
        switcher = UISwitch(frame: frame)
        switcher.setOn(true, animated: false)
        switcher.addAction(
            UIAction { _ in
                self.delegate?.switchChanged(sender: self, isOn: self.switcher.isOn)
            },
            for: .valueChanged)

        addSubview(switcher)

        switcher.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(
            item: switcher,
            attribute: NSLayoutConstraint.Attribute.centerY,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: self,
            attribute: NSLayoutConstraint.Attribute.centerY,
            multiplier: 1,
            constant: 0).isActive = true
        NSLayoutConstraint(
            item: switcher,
            attribute: NSLayoutConstraint.Attribute.left,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: self,
            attribute: NSLayoutConstraint.Attribute.left,
            multiplier: 1,
            constant: 5).isActive = true

        textField = UITextField(frame: frame)        
        textField.placeholder = "textField"
        textField.isUserInteractionEnabled = true
        textField.addAction(
            UIAction { _ in
                self.delegate?.textChanged(sender: self, text: self.textField.text ?? "")
            },
            for: .editingDidEnd)

        addSubview(textField)

        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(
            item: textField,
            attribute: NSLayoutConstraint.Attribute.centerY,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: self,
            attribute: NSLayoutConstraint.Attribute.centerY,
            multiplier: 1,
            constant: 0).isActive = true
        NSLayoutConstraint(
            item: textField,
            attribute: NSLayoutConstraint.Attribute.right,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: self,
            attribute: NSLayoutConstraint.Attribute.right,
            multiplier: 1,
            constant: -5).isActive = true
        NSLayoutConstraint(
            item: textField,
            attribute: NSLayoutConstraint.Attribute.left,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: switcher,
            attribute: NSLayoutConstraint.Attribute.right,
            multiplier: 1,
            constant: 5).isActive = true

        isUserInteractionEnabled = true
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
}
