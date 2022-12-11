//
//  RadioView.swift
//  Mellionare
//
//  Created by Aleksandr Derevenskih on 01.12.2022.
//

import UIKit


protocol RadioViewDelegate: AnyObject {
    func switchChanged(sender: RadioView, index: Int)
    func textChanged(sender: RadioView, index: Int, text: String)
}

@IBDesignable
class RadioView: UIView {

    var strings: [String] = []
    var selectedIndex: Int = 0
    var delegate: RadioViewDelegate?

    private let elementHeigth = 36.0
    private var elementsCount = 0
    private var elements: [RadioElementView] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareElements([""], selectedIndex: 0)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        prepareElements([""], selectedIndex: 0)
    }

    public func prepareElements(_ strings: [String], selectedIndex: Int) {
        clearSubviews()
        elementsCount = strings.count
        self.strings = strings

        self.selectedIndex = (selectedIndex < elementsCount && selectedIndex >= 0) ? selectedIndex : 0

        for i in 0..<elementsCount {
            let elementFrame = CGRect(x: 0.0, y: CGFloat(i) * elementHeigth, width: frame.width, height: elementHeigth)
            let element = RadioElementView(frame: elementFrame)
            element.delegate = self
            element.setOn(i == selectedIndex)
            element.setText(strings[i])
            element.setPlaceholder("Вариант ответа \(i)")
            element.tag = i
            element.isUserInteractionEnabled = true
            elements.append(element)
            addSubview(element)
        }
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        prepareElements(["Value 1", "Value 2", "value3", "value-4"], selectedIndex: 2)
    }

    private func clearSubviews() {
        for element in elements {
            element.removeFromSuperview()
        }
        elements = []
    }
}

extension RadioView: RadioElementViewDelegate {
    func switchChanged(sender: RadioElementView, isOn: Bool) {
        selectedIndex = sender.tag
        for i in 0..<elementsCount {
            elements[i].setOn( i == selectedIndex)
        }
        delegate?.switchChanged(sender: self, index: selectedIndex)
    }
    func textChanged(sender: RadioElementView, text: String) {
        selectedIndex = sender.tag
        strings[selectedIndex] = text
        delegate?.textChanged(sender: self, index: selectedIndex, text: text)
    }
}
