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
    
    @IBOutlet var scrollView: UIView!
    func getImages(){
        Alamofire.request("https://chex-triplebyte.herokuapp.com/api/cats?page=0").responseJSON { response in
            
            if let json = response.result.value {
                var y_offset : CGFloat = 0
                for anItem in json as! [[String: Any]] {
                    let picName = anItem["title"] as! String
                    let url = anItem["image_url"] as! String
                    Alamofire.request(url).responseData { picData in
                        if let imgData = picData.data {
                            let image = UIImage(data: imgData)
                            if let image = image {
                                let image1 = UIImageView()
                                image1.image = image
                                image1.frame.size.width = self.scrollView.frame.size.width
                                image1.frame.size.height = (image.size.height/image.size.width) * image1.frame.size.width
                                image1.frame.origin.x = 0
                                image1.frame.origin.y = y_offset
                                self.scrollView.addSubview(image1)
                                y_offset += image1.frame.size.height

                                self.scrollView!.sizeThatFits(CGSize(width: image1.frame.size.width,height: y_offset))
                            }
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

