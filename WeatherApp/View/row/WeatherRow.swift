//
//  WeatherRow.swift
//  WeatherApp
//
//  Created by cmStudent on 2019/12/18.
//  Copyright © 2019 19cm0119. All rights reserved.
//

import UIKit

class WeatherRow: UITableViewCell {

    @IBOutlet weak var title1Label: UILabel!
    @IBOutlet weak var title2Label: UILabel!
    @IBOutlet weak var content1Label: UILabel!
    @IBOutlet weak var content2Label: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data: [String]) {
            title1Label.text = data[0]
            title2Label.text = data[1]
            content1Label.text = data[2]
            content2Label.text = data[3]
    }
    
}
