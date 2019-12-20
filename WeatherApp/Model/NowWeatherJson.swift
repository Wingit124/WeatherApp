//
//  TodayWeatherJson.swift
//  WeatherApp
//
//  Created by 高橋翼 on 2019/12/17.
//  Copyright © 2019 高橋翼. All rights reserved.
//

//今現在の天気情報が入ってくる

import Foundation

struct NowWeatherInfo: Codable {
    var coord: NowCoord
    var weather: [NowWeather]
    var base: String
    var main: NowMain
    var visibility: Int?
    var wind: NowWind
    var clouds: NowClouds
    var dt: Int
    var sys: NowSys
    var timezone: Int
    var id: Int
    var name: String
    var cod: Int
}

struct NowCoord: Codable {
    var lon: Float
    var lat: Float
}

struct NowWeather: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

struct NowMain: Codable {
    var temp: Float
    var feels_like: Float
    var temp_min: Float
    var temp_max: Float
    var pressure: Int
    var humidity: Int
}

struct NowWind: Codable {
    var speed: Float
    var deg: Int?
}

struct NowClouds: Codable {
    var all: Int
}

struct NowSys: Codable {
    var type: Int?
    var id: Int?
    var country: String
    var sunrise: Int
    var sunset: Int
}


class NowWeatherInfoClass {
    
    var lat: String!
    var lon: String!
    
    init(lat: String, lon: String) {
        self.lat = lat
        self.lon = lon
    }
    
    func getWeatherInfo() -> NowWeatherInfo? {
        
        let appId: String = "b98b85052a48d89f2bc5c24a1af33454"
        let lat_lon: String = "lat=\(lat!)&lon=\(lon!)"
        let baseUrlString: String = "http://api.openweathermap.org/data/2.5/weather?\(lat_lon)&units=metric&APPID="
        let urlString: String = baseUrlString + appId
        //文字列をURLにキャスト,できなかったらnilを返す
        guard let url: URL = URL(string: urlString) else { return nil }
        //非同期処理に使う
        let semaphore = DispatchSemaphore(value: 0)
        //戻り値で返すWetherListを生成
        var nowWeatherInfo: NowWeatherInfo? = nil
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
                nowWeatherInfo = try JSONDecoder().decode(NowWeatherInfo.self, from: data!)
                semaphore.signal()
                
            } catch (let message){
                print("error")
                print(message)
                return
            }
            
        })
        
        task.resume()
        semaphore.wait()
        return nowWeatherInfo
    }
    
    func getTemp() -> String {
        
        let temp: String = String(round(getWeatherInfo()!.main.temp)).replacingOccurrences(of: ".0", with: "°")
        
        return temp
    }
    
    func getDetails() -> [[String]] {
        
        let weather = getWeatherInfo()!
        
        let pressure = String(weather.main.pressure) + "hPa"
        let humidity = String(weather.main.humidity) + "%"
        
        let windSpeed = String(weather.wind.speed) + "m/s"
        let feelTemp = String(round(weather.main.feels_like)).replacingOccurrences(of: ".0", with: "°")
        
        var visivility = ""
        if weather.visibility == nil {
            visivility = "情報無し"
        } else {
            visivility = String((weather.visibility! / 100)) + "km"
        }
        
        var windDeg = ""
        if weather.wind.deg == nil {
            windDeg = "情報無し"
        } else {
            windDeg = String(weather.wind.deg!) + "°"
        }
        
        let content: [[String]] = [
            ["気圧","湿度",pressure,humidity],
            ["体感温度","視界",feelTemp,visivility],
            ["風","風向き",windSpeed,windDeg]
        ]
        
        return content
    }
    
}
