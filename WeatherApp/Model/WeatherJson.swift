//
//  WeatherJson.swift
//  WeatherApp
//
//  Created by cmStudent on 2019/12/16.
//  Copyright © 2019 19cm0119. All rights reserved.
//

import Foundation

//五日分のデータが3時間ごとに入っている
//コレクションビューに三時間毎の天気を出すのにつかう

struct WeatherInfo: Codable {
    var cod: String
    var message: Int
    var cnt: Int
    var list: [WeatherList]
    var city: City
}

struct WeatherList: Codable {
    var dt: Int
    var main: Main
    var weather: [Weather]
    var clouds: Clouds
    var wind: Wind
    var sys: Sys?
    var dt_txt: String      //日付データ(例: "2019-12-17 06:00:00")
}

struct Main: Codable {
    var temp: Float         //気温
    var feels_like: Float   //体感温度
    var temp_min: Float     //最低気温
    var temp_max: Float     //最高気温
    var pressure: Float     //気圧
    var sea_level: Float    //気圧(海上?)
    var grnd_level: Float   //気圧(陸地?)
    var humidity: Float     //湿度
    var temp_kf: Float      //不明
}

struct Weather: Codable {
    var id: Int             //不明
    var main: String        //お天気情報(例: Clouds)
    var description: String //お天気詳細情報(例: overcast clouds)
    var icon: String        //画像をつけるときに使えるかも
}

struct Clouds: Codable {
    var all: Int           //不明
}

struct Wind: Codable {
    var speed: Float       //風速
    var deg: Int           //風向き(?)
}

struct Sys: Codable {
    var pod: String?        //不明
}

struct City: Codable {
    var id: Int            //都市id
    var name: String       //都市名
    var coord: Coord       //座標
    var country: String    //国
    var population: Int?    //人口(正確かどうかは不明)
    var timezone: Int      //タイムゾーン
    var sunrise: Int       //日の出
    var sunset: Int        //日の入り
}

struct Coord: Codable {
    var lat: Float         //緯度
    var lon: Float         //経度
}


class WeatherInfoClass {
    
    var lat: String!
    var lon: String!
    
    init(lat: String, lon: String) {
        self.lat = lat
        self.lon = lon
    }
    
    func getWeatherInfo() -> WeatherInfo? {
        
        let appId: String = "b98b85052a48d89f2bc5c24a1af33454"
        let lat_lon: String = "lat=\(lat!)&lon=\(lon!)"
        let baseUrlString: String = "http://api.openweathermap.org/data/2.5/forecast?\(lat_lon)&units=metric&APPID="
        let urlString: String = baseUrlString + appId
        //文字列をURLにキャスト,できなかったらnilを返す
        guard let url: URL = URL(string: urlString) else { return nil }
        //非同期処理に使う
        let semaphore = DispatchSemaphore(value: 0)
        //戻り値で返すWetherListを生成
        var weatherInfo: WeatherInfo? = nil
        //デコード処理
        let task = URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
            
            do{
                guard let response = response as? HTTPURLResponse else { return }
                //レスポンスの値がおかしい場合は処理を継続させない
                if response.statusCode != 200 {
                    print("サイトからのレスポンスコードが異常\(response.statusCode)")
                    return
                }
                //デコード
                weatherInfo = try JSONDecoder().decode(WeatherInfo.self, from: data!)
                semaphore.signal()
                
            } catch (let message){
                print("error")
                print(message)
                return
            }
            
        })
        
        task.resume()
        semaphore.wait()
        return weatherInfo
    }
    
    //今日の気温データを配列に入れて返す
    func getTodayData() -> [WeatherList] {
        
        var todayWeathers: [WeatherList] = []
        let weatherInfo = getWeatherInfo()
        let today = weatherInfo!.list[0].dt_txt.prefix(10)
        for weather in weatherInfo!.list {
            
            if weather.dt_txt.prefix(10) == today {
                todayWeathers.append(weather)
            }
            
        }
        return todayWeathers
    }
    
    func getTempMax() -> String {
        
        var tempMax: Float = 0.0
        let weather = getTodayData()
        
        for n in weather {
            if n.main.temp_max > tempMax {
                tempMax = n.main.temp_max
            }
        }
        
        let tempMaxStr = String(round(tempMax)).replacingOccurrences(of: ".0", with: "°")
        return tempMaxStr
    }
    
    func getTempMin() -> String {
        
        var tempMin: Float = 100.0
        let weather = getTodayData()
        
        for n in weather {
            if n.main.temp_min < tempMin {
                tempMin = n.main.temp_min
            }
        }
        
        let tempMinStr = String(round(tempMin)).replacingOccurrences(of: ".0", with: "°")
        return tempMinStr
    }
    
}

