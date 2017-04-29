
//
//  ChannelCell.swift
//  testSkyboy
//
//  Created by xianbin lin on 2017/4/29.
//  Copyright © 2017年 lin. All rights reserved.
//

import Foundation
import UIKit


/// custom tableview cell for channel
class ChannelCell: UITableViewCell {
    
    @IBOutlet weak var thumbnail       : UIImageView!
    @IBOutlet weak var headingLabel    : UILabel!
    @IBOutlet weak var subheadingLabel : UILabel!
    
    var isInited : Bool = false
    
    func configure(element: ElementModelView){
        if !isInited {
            isInited                           = true
            self.backgroundColor               = .black
            self.thumbnail.layer.cornerRadius  = 10
            self.thumbnail.layer.masksToBounds = true
        }
        
        self.headingLabel.text    = element.headingLabel.text
        self.subheadingLabel.text = element.subheadingLabel.text
        self.thumbnail.image      = #imageLiteral(resourceName: "img_notreDame.png")
    }
}
