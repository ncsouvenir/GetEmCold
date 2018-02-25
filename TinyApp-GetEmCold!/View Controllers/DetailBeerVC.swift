//
//  DetailBeerVC.swift
//  TinyApp-GetEmCold!
//
//  Created by C4Q on 2/23/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class DetailBeerVC: UIViewController {
    
    @IBOutlet weak var beerName: UILabel!
    @IBOutlet weak var beerABV: UILabel!
    @IBOutlet weak var beerDescription: UITextView!
    @IBOutlet weak var beerImg: UIImageView!
    
    //inject beer object from Beer VC
    
    var thisBeer: Beer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setUpDetailView()
        setUpImage()
    }
    
    func setUpDetailView(){
        beerName.text = thisBeer.name
        beerABV.text = String(thisBeer.abv)
        beerDescription.text = thisBeer.description
        beerImg.image = #imageLiteral(resourceName: "bookImg")
    }
    
    func setUpImage(){
        let imageEndpoint = thisBeer.image_url
        //set completion for image
        let getImageFromOnline: (UIImage)-> Void = {(onlineImage: UIImage) in
            self.beerImg.image = onlineImage
        }
        //call ImageAPIClient
        ImageHelper.manager.getImage(from: imageEndpoint,
                                     completionHandler: getImageFromOnline,
                                     errorHandler: {print($0)})
    }
}
