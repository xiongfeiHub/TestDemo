
//
//  XFAnnotion.swift
//  TestDemo
//
//  Created by 熊飞 on 2016/12/2.
//  Copyright © 2016年 熊飞. All rights reserved.
//

import MapKit

class XFAnnotion: NSObject ,MKAnnotation{
    
    // 确定大头针标题.
     var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(0, 0)
    // Title and subtitle for use by selection UI.
     var title: String?
     var subtitle: String?
    
}
