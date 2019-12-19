//
//  cityNameTextField.swift
//  WeatherApp
//
//  Created by cmStudent on 2019/12/19.
//  Copyright © 2019 19cm0119. All rights reserved.
//

import UIKit

class CityNameTextField: UITextField {

    let underline: UIView = UIView()
    
    //デザインを変更する
    override func layoutSubviews() {
        //高さを設定
        self.frame.size.height = 30
        composeUnderline()
        //外枠をなくす
        self.borderStyle = .none
        //リターンキーを完了ボタンにする
        self.returnKeyType = .done
    }

    
    private func composeUnderline() {
        //ボーダーラインのサイズと位置を指定
        self.underline.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width, height: 2.5)
        //ボーダーラインの色を指定
        self.underline.backgroundColor = UIColor(red:0.36, green:0.61, blue:0.93, alpha:1.0)
        //テキストフィールドにボーダーラインを追加
        self.addSubview(self.underline)
        self.bringSubviewToFront(self.underline)
    }

}
