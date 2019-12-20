//
//  TextFieldExtension.swift
//  WeatherApp
//
//  Created by cmStudent on 2019/12/20.
//  Copyright © 2019 19cm0119. All rights reserved.
//

import UIKit
import MapKit

//キーボードのリターンキーを押した時の処理
extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //入力されている文字を取得
        let inputText: String = textField.text ?? ""
        //ジオコーダーをインスタンス化
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
                //何も入力されていなかった時
                print("close")
            }})
        
        //キーボードを閉じる処理
        textField.resignFirstResponder()
        return false
    }
    
}
