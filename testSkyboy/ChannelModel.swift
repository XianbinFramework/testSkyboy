//
//  ChannelModel.swift
//  testSkyboy
//
//  Created by xianbin lin on 2017/4/29.
//  Copyright © 2017年 lin. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ChannelModel {
    let id    : String
    let name  : String
    var spots : [Spot] = [Spot]()
    
    init(channelJson:JSON) {
        self.id   = channelJson["id"].stringValue
        self.name = channelJson["name"].stringValue
        // spots
        for (_, spot) in channelJson["spots"] {
            self.spots.append( Spot(spotJson: spot) )
        }
    }
}

struct Spot {
    let id          : String
    let title       : String
    let information : String
    let video_url   : String
    let coordinate  : Coordinate
    var subtitles   : [Subtitle] = [Subtitle]()
    
    init(spotJson:JSON){
        self.id          = spotJson["id"].stringValue
        self.title       = spotJson["title"].stringValue
        self.information = spotJson["information"].stringValue
        self.video_url   = spotJson["video_url"].stringValue
        self.coordinate  = Coordinate(coordinateJson : spotJson["coordinates"])
        for (_ , subtitle) in spotJson["subtitles"] {
            self.subtitles.append( Subtitle(subtitleJson: subtitle) )
        }
        
    }
}

struct Coordinate {
    let lat  : Double
    let long : Double
    
    init(coordinateJson:JSON){
        self.lat  = coordinateJson[0].doubleValue
        self.long = coordinateJson[1].doubleValue
    }
}

struct Subtitle {
    let id       : String
    let language : String
    let url      : String
    
    init(subtitleJson:JSON){
        self.id       = subtitleJson["id"].stringValue
        self.language = subtitleJson["language"].stringValue
        self.url      = subtitleJson["url"].stringValue
    }
}
