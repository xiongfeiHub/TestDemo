//
//  CustonTabBarVC.swift
//  TestDemo
//
//  Created by 熊飞 on 2016/12/3.
//  Copyright © 2016年 熊飞. All rights reserved.
//

import UIKit

class CustonTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        initTabbar()
    }
    
    func initTabbar() {
        tabBarAddChildVC(vc:ViewController() , title: "工作台", imgeName: "job_ normal", selectImageName: "job_selected")
        tabBarAddChildVC(vc:DaoHangViewController() , title: "服务", imgeName: "service_normol", selectImageName: "service_selected")
        self.selectedIndex = 0
    }
    
    fileprivate func tabBarAddChildVC(vc:UIViewController,title:String,imgeName:String,selectImageName:String) {
        vc.tabBarItem = UITabBarItem(title: title, image: UIImage(named:imgeName), selectedImage: UIImage(named:selectImageName))
        // 去掉tabbaritem渲染色，显示原图片
        vc.tabBarItem.selectedImage = UIImage(named:selectImageName)!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        // 整体渲染色
        self.tabBar.tintColor = UIColor.red
        let nav = UINavigationController(rootViewController: vc)
        addChildViewController(nav)
        
    }


}
