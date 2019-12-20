//
//  WeatherCollectionViewExtension.swift
//  WeatherApp
//
//  Created by cmStudent on 2019/12/20.
//  Copyright © 2019 19cm0119. All rights reserved.
//

import UIKit

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //今日の天気データ分の個数表示する
        return todayWeather.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //セルの生成
        let cell = weatherCollectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        //indexPathごとにセルの設定をするために使う天気データ
        let weather = todayWeather[indexPath.row]
        //セルを設定する関数に天気データを渡す
        cell.setWeatherCell(weather: weather)
        
        return cell
    }
    
}
