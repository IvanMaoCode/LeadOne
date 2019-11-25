//
//  ButtonRotation.swift
//  Lead
//
//  Created by Kluth on 2019/11/23.
//  Copyright © 2019 lorenzotech. All rights reserved.
//

import UIKit

class ButtonRotation: UIView {
    func addRotationAnim(){
          //1.创建k动画
          //CAKeyframeAnimation
          let rotationAnima = CABasicAnimation(keyPath: "transform.rotation.z")
          //2.设置动画的属性
          rotationAnima.fromValue = 0
          rotationAnima.toValue = Double.pi * 2
          rotationAnima.repeatCount = MAXFLOAT
          rotationAnima.duration = 2
          rotationAnima.isRemovedOnCompletion = false
          //3.将动画添加到layerzhong
//          rotationVIew.layer.add(rotationAnima, forKey: nil)
      }

}
