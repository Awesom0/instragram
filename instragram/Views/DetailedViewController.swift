//
//  DetailedViewController.swift
//  instragram
//
//  Created by Felipe De La Torre on 10/20/18.
//  Copyright © 2018 Felipe De La Torre. All rights reserved.
//

import UIKit
import Parse

class DetailedViewController: UIViewController {
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var detailedCaptionView: UILabel!
    
    var post : Post?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let postImage : PFFile = post?.media{
            postImage.getDataInBackground { (data, error) in
                if (error != nil){
                    print(error.debugDescription)
                }
                else{
                    self.detailImageView.image = UIImage(data: data!)
                    
                }
            }
            
            detailedCaptionView.text = post?.caption
            let time = formatDate((post?.createdAt)!)
            timestampLabel.text = time
            
        }
    }
    
    //function to format Date from "createdAt"
    func formatDate(_ date : Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        let result = dateFormatter.string(from: date)
        return result
    }
    
    
    //back button action
    @IBAction func onBack(_ sender: Any) {
        self.performSegue(withIdentifier: "backSegue", sender: nil)

        
    }
    
}
