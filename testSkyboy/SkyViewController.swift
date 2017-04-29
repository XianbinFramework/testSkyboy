//
//  ViewController.swift
//  testSkyboy
//
//  Created by xianbin lin on 2017/4/29.
//  Copyright © 2017年 lin. All rights reserved.
//

import UIKit
import MapKit


class SkyViewController: UIViewController {

    @IBOutlet weak var channelsTableView: ChannelsTableView!{
        didSet{
            channelsTableView.setup()
            channelsTableView.skyViewDelegate = self
        }
    }
    
    @IBOutlet weak var skyMapview: SkyMapView!{
        didSet{
            skyMapview.setup()
        }
    }
    
    @IBOutlet weak var backBtn: UIButton!
    
    
    
    /// main entrace of app
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        pullChainesJSON()
    }
    
    /// pull json file and setup tableview
    func pullChainesJSON(){
        let urlString = "http://app.sky-boy.com/test/test.json"
        let url       = URL(string  : urlString)
        // http request for JSON file
        URLSession.shared.dataTask(with:url!) {
            (jsonData, response, error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            if let jsonData = jsonData{
                // Init data resource for table view
                self.channelsTableView.initChannelsWithJsonData(jsonData: jsonData)
                // Refrech table view
                DispatchQueue.main.async {
                    self.channelsTableView.reloadData()
                    self.channelsTableView.isHidden = false
                }
            } else {
                print("pull chaines json file fail")
            }
        }.resume()
    }
    
    /// setup conteact ViewControoler UI
    fileprivate func setupUI(){
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "img_backgroud.png"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // ###################################################################
    // MARK: *Actions*
    // ###################################################################
    
    @IBAction func clickBackBtn(_ sender: UIButton) {
        self.backBtn.isHidden = true
        self.channelsTableView.backToChannels()
        self.setMapviewHide(hide: true)
    }
    
}

protocol SkyViewDelegate : class {
    func dropSpots(spots:[Spot])
    func toogleBackButton(hide : Bool)
    func setMapviewHide(hide : Bool)
    func moveCamera(toLocation location:Coordinate)
}

extension SkyViewController : SkyViewDelegate {
    func dropSpots(spots: [Spot]) {
        self.skyMapview.dropSpots(spots: spots)
    }
    
    func toogleBackButton(hide: Bool) {
        self.backBtn.isHidden = hide
    }
    
    func setMapviewHide(hide: Bool) {
        self.skyMapview.isHidden = hide
    }
    
    func moveCamera(toLocation location:Coordinate) {
    let location = CLLocationCoordinate2DMake(location.lat, location.long)
        self.skyMapview.moveCamera(toLocation: location)
    }
    
}

