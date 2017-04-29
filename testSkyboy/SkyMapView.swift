//
//  SkyMapView.swift
//  testSkyboy
//
//  Created by xianbin lin on 2017/4/29.
//  Copyright © 2017年 lin. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class SkyMapView: MKMapView {
    
    var spotAnnotations : [MKAnnotation] = [MKAnnotation]()
    // mapview zoom level
    let latDelta : CLLocationDegrees = 0.05
    let lonDelta : CLLocationDegrees = 0.05
    
    /// setup mapview after init
    func setup(){
        self.delegate = self
        self.mapType  = .standard
    }
    
    /// drop annotations in mapview
    ///
    /// - Parameter spots: spots struct which contain coordinate
    func dropSpots(spots:[Spot]){
        // clean map
        self.removeAnnotations(self.annotations)
        self.spotAnnotations.removeAll()
        // crea new annotations
        for spot in spots {
            let location          = CLLocationCoordinate2DMake(spot.coordinate.lat, spot.coordinate.long)
            let annotation        = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title      = spot.information
            annotation.subtitle   = spot.title
            self.spotAnnotations.append(annotation)
        }
        self.addAnnotations(self.spotAnnotations)
        // move mapview to first spot
        self.moveCamera(toLocation: self.spotAnnotations[0].coordinate)
    }
    
    
    /// move mapview camera to location
    ///
    /// - Parameter location: location to move to
    func moveCamera(toLocation location:CLLocationCoordinate2D){
        let span   = MKCoordinateSpanMake(latDelta, lonDelta)
        let region = MKCoordinateRegionMake(location, span)
        self.setRegion(region, animated: false)
    }
}

extension SkyMapView : MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // check weather is a system annotation
        if annotation .isKind(of: MKUserLocation.self){ return nil }
        let identifier = "spot"
        var view: MKPinAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKPinAnnotationView {
            // resue view
            dequeuedView.annotation = annotation
            view                    = dequeuedView
        } else {
            // create a new view
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        view.pinTintColor = UIColor.purple
        view.animatesDrop = true
        return view
    }

}



