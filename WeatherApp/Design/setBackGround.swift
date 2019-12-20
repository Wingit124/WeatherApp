//
//  setBackGround.swift
//  WeatherApp
//
//  Created by cmStudent on 2019/12/20.
//  Copyright © 2019 19cm0119. All rights reserved.
//

import UIKit

//背景を画像にする処理
extension UIView {
    
    func setBackGround(imageName: String){
        //画面サイズを取得
        let widht = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        //画面サイズに合わせてimageViewを追加
        let backGroundImage = UIImageView(frame: CGRect(x: 0, y: 0, width: widht, height: height))
        //引数でもらった画像の名前をセット
        backGroundImage.image = UIImage(named: imageName)
        //画像を画面にフィットさせる
        backGroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        //画面に画像を追加
        self.addSubview(backGroundImage)
        //画面の一番下の層に行くようにする
        self.sendSubviewToBack(backGroundImage)
        
    }
    
    
    
}
