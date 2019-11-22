//
//  TotalViewController.swift
//  Test1
//
//  Created by 방문 사용자 on 2019. 11. 22..
//  Copyright © 2019년 방문 사용자. All rights reserved.
//

import UIKit
import MapKit

class TotalViewController: UIViewController {

    @IBOutlet weak var totalMapView: MKMapView!
    var dContent: NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("dContent = \(String(describing: dContent))")
        
        var annos = [MKPointAnnotation]()
        
        if let myItems = dContent{
            for item in myItems{
                let address = (item as AnyObject).value(forKey: "address")
                let title = (item as AnyObject).value(forKey: "title")
                let geoCoder = CLGeocoder()
                
                geoCoder.geocodeAddressString(address as! String, completionHandler: { placemarks, error in
                    if error != nil {
                        print(error!)
                        return
                    }
                    
                    if let myPlacemarks = placemarks {
                        let myPlacemark = myPlacemarks[0]
                        
                        let anno = MKPointAnnotation()
                        anno.title = title as? String
                        anno.subtitle = address as? String
                        
                        if let myLocation = myPlacemark.location {
                            anno.coordinate = myLocation.coordinate
                            annos.append(anno)
                        }
                        
                    }
                    
                    self.totalMapView.showAnnotations(annos, animated: true)
                    self.totalMapView.addAnnotations(annos)
                })
            }
        }else{
            print("dContent의 값은 없음")
        }
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
