//
//  DaoHangViewController.swift
//  TestDemo
//
//  Created by 熊飞 on 2016/12/3.
//  Copyright © 2016年 熊飞. All rights reserved.
//

import UIKit
import MapKit
class DaoHangViewController: UIViewController {

    lazy var geoCoder : CLGeocoder = {
        return CLGeocoder()
    }()
    override func viewDidLoad() {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        navigationItem.title = "系统导航使用"
       
        // 地理编码
        geoCoder.geocodeAddressString("广州") { (pls: [CLPlacemark]?, error: Error?) -> Void in
            if error == nil {
                let gzPL = pls?.first
            
                self.geoCoder.geocodeAddressString("上海") { (pls: [CLPlacemark]?, error: Error?) -> Void in
                    if error == nil {
                        let shPL = pls?.first
                        
                        self.beginNav(srartPLCL: gzPL!, endPLCL: shPL!)

                    }
                }

            }
        }
        
       

    }
    
    
    func beginNav(srartPLCL : CLPlacemark,endPLCL : CLPlacemark) {
        // 起点和终点
        let plMk:MKPlacemark = MKPlacemark(placemark: srartPLCL)
        let startItem:MKMapItem = MKMapItem(placemark: plMk)
        
        
        let plMk1:MKPlacemark = MKPlacemark(placemark: endPLCL)

        let endItem:MKMapItem = MKMapItem(placemark: plMk1)
        
        
        let mapItem :[MKMapItem] = [startItem,endItem]
        
        //设置导航字典
        
        let dic :[String : Any] = [
            MKLaunchOptionsDirectionsModeKey:
            MKLaunchOptionsDirectionsModeDriving,
            MKLaunchOptionsMapTypeKey:MKMapType.standard,
            MKLaunchOptionsShowsTrafficKey:true
            
        ]
        
        MKMapItem.openMaps(with: mapItem, launchOptions: dic)
    }
}
