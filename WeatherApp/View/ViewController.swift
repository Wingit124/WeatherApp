//
//  ViewController.swift
//  WeatherApp
//
//  Created by cmStudent on 2019/12/16.
//  Copyright © 2019 19cm0119. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    //1日のて三時間おきのデータがここに入っている
    var todayWeather: [WeatherList]!
    //テーブルビューに表示するための情報が入っている
    var todayWeatherDetails: [[String]]!
    
    @IBOutlet weak var cityNameTextField: CityNameTextField!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!
    
    @IBOutlet weak var weatherCollectionView: UICollectionView!
    @IBOutlet weak var weatherTableView: UITableView!
    
    var weather: WeatherInfoClass!
    var nowWeather: NowWeatherInfoClass!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //コレクションビューにカスタムしたセルを適用
        weatherCollectionView.register(UINib(nibName: "WeatherCell", bundle: nil), forCellWithReuseIdentifier: "WeatherCell")
        weatherCollectionView.layer.borderColor = UIColor.lightGray.cgColor
        weatherCollectionView.layer.borderWidth = 3
        //テーブルビューにカスタムセルを適用
        weatherTableView.register(UINib(nibName: "WeatherRow", bundle: nil), forCellReuseIdentifier: "WeatherRow")
        //色々天気からデータをもらって表示する
        setVarious(lat: "35.689506", lon: "139.6917")
        //テキストフィールドデリゲートを設定
        cityNameTextField.delegate = self
    }
    
    
    func setVarious(lat: String, lon: String) {
        //ウェザークラスをインスタンス化
        weather = WeatherInfoClass(lat: lat, lon: lon)
        nowWeather = NowWeatherInfoClass(lat: lat, lon: lon)
        
        //今日の天気データを取得(コレクションビューで使う)
        todayWeather = weather.getTodayData()
        //テーブルビューで使う
        todayWeatherDetails = nowWeather.getDetails()
        
        //天気情報をセット
        weatherLabel.text = nowWeather.getWeatherInfo()!.weather[0].main
        //今の温度をセット
        tempLabel.text = nowWeather.getTemp()
        //最高気温をセット
        tempMaxLabel.text = weather.getTempMax()
        //最低気温をセット
        tempMinLabel.text = weather.getTempMin()
        
        //テーブルとコレクションのデータを更新
        weatherTableView.reloadData()
        weatherCollectionView.reloadData()
    }
    
}


//テーブルビューのエクステンション
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


//コレクションビューのエクステンション
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


//テキストフィールドのリターンキーを押した時の動作を変えたい
extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let inputText: String = textField.text ?? ""
        
        let geoCoder: CLGeocoder = CLGeocoder()
        
        //ジオコーディングを使って地名を座標に変換する
        geoCoder.geocodeAddressString(inputText, completionHandler: {(placemarks, error) in
            if(error == nil) {
                
                for placemark in placemarks! {
                    //ストーリーボードを取得
                    let storyboard: UIStoryboard = self.storyboard!
                    //遷移先ViewControllerのインスタンス取得
                    let nextView = storyboard.instantiateViewController(withIdentifier: "modal") as! MapAleartViewController
                    //遷移先のフィールドに値をセット
                    nextView.lat = placemark.location!.coordinate.latitude
                    nextView.lon = placemark.location!.coordinate.longitude
                    //画面遷移
                    self.present(nextView, animated: true, completion: nil)
                }
                
            } else {
                //入力された地名が見つからなかった時の処理
                if inputText != "" {
                    print("error")
                }
                print("close")
            }})
        
        //キーボードを閉じる処理
        textField.resignFirstResponder()
        return false
    }
    
}

