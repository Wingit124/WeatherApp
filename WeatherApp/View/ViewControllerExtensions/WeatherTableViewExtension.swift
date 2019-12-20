//
//  WeatherTableViewExtension.swift
//  WeatherApp
//
//  Created by cmStudent on 2019/12/20.
//  Copyright © 2019 19cm0119. All rights reserved.
//

import UIKit

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todayWeatherDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //セルの生成
        let row = weatherTableView.dequeueReusableCell(withIdentifier: "WeatherRow", for: indexPath) as! WeatherRow
        row.setData(data: todayWeatherDetails[indexPath.row])
        return row
    }
    
}
