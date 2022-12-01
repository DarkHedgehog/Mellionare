//
//  RadioElementViewCell.swift
//  Mellionare
//
//  Created by Aleksandr Derevenskih on 01.12.2022.
//

import UIKit

class QuestionEditViewCell: UITableViewCell {

    @IBOutlet weak var questionText: UITextField!
    @IBOutlet weak var answersVariations: RadioView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
