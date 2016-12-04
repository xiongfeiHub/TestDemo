//
//  ViewController.swift
//  TestDemo
//
//  Created by 熊飞 on 2016/12/1.
//  Copyright © 2016年 熊飞. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {

   lazy var mapView: MKMapView = {
        let mapView: MKMapView = MKMapView()
        mapView.delegate = self
        mapView.frame =  CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        mapView.mapType = MKMapType.standard
       // 以下为地图样式
                mapView.isRotateEnabled = true
        mapView.isScrollEnabled = true
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.showsBuildings = true
        mapView.showsPointsOfInterest = true
    
    //用户的追踪模式
    // 不会放大地图用户位置移动不会跟着跑，地图不会跟踪
     mapView.showsUserLocation = true
    
    // 跟上面相反 但是不灵光
    //     mapView.userTrackingMode = MKUserTrackingMode.followWithHeading
    
    if #available(iOS 9.0, *) {
        mapView.showsScale = true
        mapView.showsCompass = true
        mapView.showsTraffic = true
    }

        return mapView
    
    }()
    
    lazy var locationManger: CLLocationManager = {
        let locationManger = CLLocationManager()
        locationManger.requestAlwaysAuthorization()
        return locationManger
    }()
    
    
    lazy var geoCoder: CLGeocoder = {
        return CLGeocoder()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        _ = locationManger
        view.addSubview(mapView)
       navigationItem.title = "定位以及大头针的使用"
        // 导航按钮
        let item = MKUserTrackingBarButtonItem(mapView: mapView)
        navigationItem.leftBarButtonItem = item
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//       
//        // 获取当前位置
//        let poingt = touches.first?.location(in: mapView)
//        let coored = mapView.convert(poingt!, toCoordinateFrom: mapView)
//        
//        
//        // 返地理编码
//        let loaction = CLLocation(latitude: coored.latitude, longitude: coored.longitude)
//       
//       
//        // 调用自定义方法
//     let ann = addAnntion(coordinte: coored, title: "lulu", sutitle: "aini")
//        geoCoder.reverseGeocodeLocation(loaction) { (pls: [CLPlacemark]?, error: Error?) -> Void in
//            
//            if error == nil {
//                let pl = pls?.first
//                ann.title = pl?.locality
//                ann.subtitle = pl?.name
//            }
//        }
//    }
    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let ans = mapView.annotations
//        mapView.removeAnnotations(ans)
//        
//    }
    
    func addAnntion(coordinte:CLLocationCoordinate2D, title:String, sutitle:NSString) -> XFAnnotion {
        // 自定义大头针
        let annotion: XFAnnotion = XFAnnotion()
        annotion.coordinate = coordinte
        annotion.title = title
        annotion.subtitle = sutitle as String
        mapView.addAnnotation(annotion)

        return annotion
    }
}

extension ViewController:MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let annotaion = view.annotation
        
        print("选中\(annotaion?.title)")
        
    }
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        // MKUserLocation大头针数据模型
        //蓝点 大头针视图
        userLocation.title = "haha"//biaoti
        userLocation.subtitle = "hehe"//fu biaoti
        //调整地图位置中心
        mapView.setCenter((userLocation.location?.coordinate)!, animated: true)
        //设置显示区域
        var reg = MKCoordinateRegion()
        reg.center = (userLocation.location?.coordinate)!
        reg.span = MKCoordinateSpanMake(0.0220309095907041, 0.0160932555656075)
        
        mapView.setRegion(reg, animated: true)
    }
    
    // 地图区域改变
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print(mapView.region.span.latitudeDelta,mapView.region.span.longitudeDelta)
    }

    
    
    //自定义大头针
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // yaobu使用MKAnnotationView 或者自己自定义
        let id = "anntion"
        
        var annntionView = mapView.dequeueReusableAnnotationView(withIdentifier: id) as? MKPinAnnotationView
        if annntionView == nil {
            annntionView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: id
            )
        }
        // 非常重要
        annntionView?.annotation = annotation
        annntionView?.image = UIImage(named: "mmmm")
        // 设置中心偏移量
        annntionView?.centerOffset = CGPoint(x: 10, y: 10)
        //tankuang
        annntionView?.canShowCallout = true
        // 弹框偏移量
        annntionView?.calloutOffset = CGPoint(x: 10, y: 10)
        
        //设置弹框的左侧视图
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.image = UIImage(named: "mmmm")
        annntionView?.leftCalloutAccessoryView = imageView
        
        let imageView1 = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView1.image = UIImage(named: "lllll")
        annntionView?.rightCalloutAccessoryView = imageView1
        
        let imageView3 = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 10))
        imageView3.image = UIImage(named: "heheh")
        if #available(iOS 9.0, *) {
            annntionView?.detailCalloutAccessoryView = imageView3
        } else {
            // Fallback on earlier versions
        }
        
        return annntionView

    }
    //添加模型就会自动调用一个代理方法来查找大头针视图
    
    // 如果这个方法没有实现，就会使用系统默认的视图
    func mapView2(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        // 大头针视图和cell一样，有一个循环服用机制
        let id = "anntion"
        
        var annntionView = mapView.dequeueReusableAnnotationView(withIdentifier: id) as? MKPinAnnotationView
        if annntionView == nil {
            annntionView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: id
            )
        }
        
        // 显示弹框
        annntionView?.canShowCallout = true
        if #available(iOS 9.0, *) {
            annntionView?.pinTintColor = UIColor.black
        } else {
            // Fallback on earlier versions
             annntionView?.pinColor = MKPinAnnotationColor.green
        }
        
        // 设置下落动画
        annntionView?.animatesDrop = true
        return annntionView
    }
}

