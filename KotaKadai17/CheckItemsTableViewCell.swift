//
//  CheckItemsTableViewCell.swift
//  KotaKadai17
//
//  Created by 前田航汰 on 2022/03/28.
//

import UIKit

class CheckItemsTableViewCell: UITableViewCell {

    @IBOutlet private weak var checkImage: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!

    func config(checkItem: CheckItem) {
        checkImage.isHidden = !checkItem.isChecked
        nameLabel.text = checkItem.name
    }

}
