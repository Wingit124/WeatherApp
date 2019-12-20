//
//  CollectionViewCell.swift
//  WeatherApp
//
//  Created by cmStudent on 2019/12/17.
//  Copyright © 2019 19cm0119. All rights reserved.
//

import UIKit

class WeatherCell: UICollectionViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setWeatherCell(weather: WeatherList) {
        
        let time: String = String((String(weather.dt_txt.suffix(8))).prefix(2)) + "時"
        let temp: String = String(round(weather.main.temp)).replacingOccurrences(of: ".0", with: "°")
        
        var imageName: String = ""
        let weatherStr = weather.weather[0].main
        
        if weatherStr == "Clear" {
            imageName = "clear"
        } else if weatherStr == "Clouds" {
            imageName = "cloud"
        } else if weatherStr == "Snow" {
            imageName = "snow"
        } else {
            imageName = "rain"
        }
        
        self.timeLabel.text = time
        self.tempLabel.text = temp
        self.weatherImage.image = UIImage(named: imageName)
        
    }

}
