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
        //テーブルビューにカスタムセルを適用
        weatherTableView.register(UINib(nibName: "WeatherRow", bundle: nil), forCellReuseIdentifier: "WeatherRow")
        //天気データをセットする関数に座標を渡す
        setVarious(lat: "35.689506", lon: "139.6917")
        //背景を設定する
        nowWeatherStr = nowWeather.getWeatherInfo()!.weather[0].main
        setBackGround(nowWeatherStr: nowWeatherStr, isChange: false)
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
        //背景画像を変える
        nowWeatherStr = nowWeather.getWeatherInfo()!.weather[0].main
        setBackGround(nowWeatherStr: nowWeatherStr, isChange: true)
        //テーブルとコレクションのデータを更新
        weatherTableView.reloadData()
        weatherCollectionView.reloadData()
    }
    
    var imageName: String!
    var nowWeatherStr: String!
    //背景を設定
    func setBackGround(nowWeatherStr: String, isChange: Bool){
        
        //すでに背景が設定してある場合は一旦イメージビューを消してから再表示する
        if isChange {
            for v in view.subviews {
                // オブジェクトの型がUIImageView型で、タグ番号が999番のオブジェクトを取得する
                if let v = v as? UIImageView, v.tag == 999 {
                    // そのオブジェクトを親のviewから取り除く
                    v.removeFromSuperview()
                }
            }
        }
        
        if nowWeatherStr == "Clear" {
            imageName = "clearBG"
            weatherLabel.text = "晴れ"
        } else if nowWeatherStr == "Clouds" {
            imageName = "cloudBG"
            weatherLabel.text = "曇り"
        } else if nowWeatherStr == "Snow" {
            imageName = "snowBG"
            weatherLabel.text = "雪"
        } else {
            imageName = "rainBG"
            weatherLabel.text = "雨"
        }

        //画面サイズを取得
        let widht = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        //画面サイズに合わせてimageViewを追加
        let backGroundImage = UIImageView(frame: CGRect(x: 0, y: 0, width: widht, height: height))
        //引数でもらった画像の名前をセット
        backGroundImage.image = UIImage(named: imageName)
        backGroundImage.tag = 999
        //画像を画面にフィットさせる
        backGroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        //画面に画像を追加
        self.view.addSubview(backGroundImage)
        //画面の一番下の層に行くようにする
        self.view.sendSubviewToBack(backGroundImage)
    }

    
}

