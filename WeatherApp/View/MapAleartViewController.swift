//
//  MapAleartViewController.swift
//  WeatherApp
//
//  Created by cmStudent on 2019/12/19.
//  Copyright © 2019 19cm0119. All rights reserved.
//

import UIKit
import MapKit

class MapAleartViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var modalView: UIView!
    
    var lon: CLLocationDegrees = 0
    var lat: CLLocationDegrees = 0
    
    @IBAction func buttonOK(_ sender: Any) {
        let mainView = self.presentingViewController as! ViewController
        mainView.setVarious(lat: "\(lat)", lon: "\(lon)")
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func buttonCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        modalView.layer.cornerRadius = 30
        mapView.layer.cornerRadius = 30
        //中心の設定
        let center = CLLocationCoordinate2DMake(lat, lon)
        //表示範囲
        let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        //中心座標と表示範囲をマップに登録する。
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.setRegion(region, animated:true)
        
        //ピンの生成、追加
        let pin = MKPointAnnotation()
        pin.coordinate = CLLocationCoordinate2DMake(lat, lon)
        mapView.addAnnotation(pin)
        
    }
    

}
