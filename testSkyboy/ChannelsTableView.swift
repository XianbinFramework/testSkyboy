//
//  ChannelsTableView.swift
//  testSkyboy
//
//  Created by xianbin lin on 2017/4/29.
//  Copyright © 2017年 lin. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

/// ContactTableView is a subclass of UITableView, create this class to handle UITableView delegate. In order to avoid too many code in ContactViewController
class ChannelsTableView : UITableView {
    // data resource
    var channels : [ChannelModel]     = [ChannelModel]()
    var elements : [ElementModelView] = [ElementModelView]()
    // flow control
    var isShowingSpots       : Bool = false
    weak var skyViewDelegate : SkyViewDelegate?
    
    /// Configurate contact tableView after its init
    func setup() {
        self.dataSource      = self
        self.delegate        = self
        self.backgroundColor = .clear
        self.tableFooterView = UIView(frame : .zero)
    }
    
    /// init channel data after got json file
    ///
    /// - Parameter jsonData: json data from json file
    func initChannelsWithJsonData(jsonData : Data){
        let json         = JSON(jsonData)
        let channelsJson = json["channels"]
        self.channels    = channelsJson.map{ ChannelModel(channelJson : $0.1) }
        self.elements    = channels.map{ ElementModelView(channel: $0) }
    }
    
    /// go back to channels list from spots list
    func backToChannels(){
        self.elements       = channels.map{ ElementModelView(channel : $0) }
        self.isShowingSpots = false
        self.reloadData()
    }
}


extension ChannelsTableView:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ChannelCell.self)) as! ChannelCell
        cell.configure(element: self.elements[indexPath.row])
        return cell
    }
}

extension ChannelsTableView:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !isShowingSpots {
            isShowingSpots = true
            // load spots
            let spots      = self.channels[indexPath.row].spots
            self.elements  = spots.map{ ElementModelView(spot :$0) }
            self.reloadData()
            self.skyViewDelegate?.dropSpots(spots: spots)
            // show back button
            self.skyViewDelegate?.toogleBackButton(hide: false)
            // show mapview
            self.skyViewDelegate?.setMapviewHide(hide: false)
        } else {
            // when click on a spot, move to the spot
            // TODO : get spot coordinate
        }
    }
}
