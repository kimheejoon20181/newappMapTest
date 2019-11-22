//
//  DetailViewController.swift
//  Test1
//
//  Created by 방문 사용자 on 2019. 11. 22..
//  Copyright © 2019년 방문 사용자. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
    
    var dTitle: String?
    var dAddress: String?

    @IBOutlet weak var detailMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("dTitle = \(String(describing: dTitle))")
        print("dAddress = \(String(describing: dAddress))")
        
        self.title = dTitle
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(dAddress!, completionHandler: {plackmarks, error in
            
            if error != nil{
                print(error!)
            }
            
            if plackmarks != nil {
                let myPlacemark = plackmarks?[0]
                
                if (myPlacemark?.location) != nil{
                    let myLat = myPlacemark?.location?.coordinate.latitude
                    let myLong = myPlacemark?.location?.coordinate.longitude
                    let center = CLLocationCoordinate2DMake(myLat!, myLong!)
                    let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                    let region = MKCoordinateRegion(center: center, span: span)
                    self.detailMapView.setRegion(region, animated: true)
                    
                    let anno = MKPointAnnotation()
                    anno.title = self.dTitle
                    anno.subtitle = self.dAddress
                    anno.coordinate = (myPlacemark?.location?.coordinate)!
                    self.detailMapView.addAnnotation(anno)
                    self.detailMapView.selectAnnotation(anno, animated: true)
                    
                }
            }
        
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
