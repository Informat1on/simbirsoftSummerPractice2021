//
//  ThingsCell.swift
//  iosEveryDayer
//
//  Created by Арсений Щербак on 24.06.2021.
//  Copyright © 2021 Arseniy Shcherbak. All rights reserved.
//

import UIKit

class ThingsCell: UITableViewCell {

    @IBOutlet weak var thingView: UIView!
    @IBOutlet weak var thingTimeView: UILabel!
    @IBOutlet weak var thingDescriptionView: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {

        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func didSelect(indexPath: IndexPath) {
        print("cell is selected")
        thingView.backgroundColor = #colorLiteral(red: 0.9287882447, green: 1, blue: 0.7569417357, alpha: 1)
            // perform some actions here
}
}
