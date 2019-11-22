//
//  ViewController.swift
//  Test1
//
//  Created by 방문 사용자 on 2019. 11. 22..
//  Copyright © 2019년 방문 사용자. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mytable: UITableView!
    
    var content = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mytable.delegate = self
        mytable.dataSource = self
        
        self.title = "부산 맵"
        
        let path = Bundle.main.path(forResource: "Address2", ofType: "plist")
        content = NSArray(contentsOfFile: path!)!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = mytable.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        let myTitle = (content[indexPath.row] as AnyObject).value(forKey: "title")
        let myAddress = (content[indexPath.row] as AnyObject).value(forKey: "address")
        
        print(myAddress!)
        
        myCell.textLabel?.text = myTitle as? String
        myCell.detailTextLabel?.text = myAddress as? String
        
        return myCell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goDetail"{
            
            let detailMVC = segue.destination as! DetailViewController
            let selectedPath = mytable.indexPathForSelectedRow
            
            let myIndexedTitle = (content[(selectedPath?.row)!]as AnyObject).value(forKey: "title")
            let myIndexedAddress = (content[(selectedPath?.row)!]as AnyObject).value(forKey: "address")
            
            print("myIndexeTitle = \(String(describing: myIndexedTitle))")
            
            detailMVC.dTitle = myIndexedTitle as? String
            detailMVC.dAddress = myIndexedAddress as? String
            
        } else if segue.identifier == "goTotalMap"{
            print("여기는 토탈 맵뷰입니다")
            
            let totalMVC = segue.destination as! TotalViewController
            totalMVC.dContent = content
        }
    }
    


}

