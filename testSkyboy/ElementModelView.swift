//
//  ElementModelView.swift
//  testSkyboy
//
//  Created by xianbin lin on 2017/4/29.
//  Copyright © 2017年 lin. All rights reserved.
//

import Foundation
import UIKit


struct ElementModelView {
    let headingLabel    : UILabel = UILabel()
    let subheadingLabel : UILabel = UILabel()
    
    init(channel:ChannelModel) {
        self.headingLabel.text    = channel.name
        self.subheadingLabel.text = channel.id
    }
    
    init(spot:Spot){
        self.headingLabel.text    = spot.information
        self.subheadingLabel.text = spot.title
    }
}
