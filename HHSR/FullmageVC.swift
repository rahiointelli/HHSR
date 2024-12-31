//
//  FullmageVC.swift
//  iTask
//
//  Created by Intelli on 2020-01-22.
//  Copyright © 2020 Intelli. All rights reserved.
//

import UIKit
import SDWebImage

class FullmageVC: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    
    var imgURL : String = ""
    var imgToLoad : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(self.imgURL.count > 0)
        {
            self.imgView.sd_setImage(with: URL(string: self.imgURL)!, placeholderImage: nil, options: .refreshCached, completed: nil)
        }
        else
        {
            self.imgView.image = self.imgToLoad!
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnClose_Clicked(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: false)
    }

}
