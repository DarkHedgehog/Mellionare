//
//  AnswerTableViewCell.swift
//  Mellionare
//
//  Created by Aleksandr Derevenskih on 28.11.2022.
//

import UIKit

class AnswerTableViewCell: UITableViewCell {

    @IBOutlet var answerText: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
