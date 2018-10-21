//
//  ViewController.swift
//  cats
//
//  Created by Reid Graham on 2018-10-07.
//  Copyright © 2018 Reid Gustavson. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    
    func getImages(){
        Alamofire.request("https://chex-triplebyte.herokuapp.com/api/cats?page=0").responseJSON { response in
            
            if let json = response.result.value {
                for anItem in json as! [[String: Any]] {
                    let picName = anItem["title"] as! String
                    let url = anItem["image_url"] as! String
                    Alamofire.request(url).responseData { picData in
                        if let imgData = picData.data {
                            let image = UIImage(data: imgData)
                            //let subView = UIImageView()
                            self.image1.image = image
                        }
                    }
                }
            }
        }
    }
                
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getImages()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

