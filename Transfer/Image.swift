//
//  Image.swift
//  Transfer
//
//  Created by Vineeth Yeevani on 10/7/17.
//  Copyright © 2017 Vineeth Yeevani. All rights reserved.
//

import Foundation
import UIKit

class Image{
    
    //Variable to store the actual image
    var image : UIImage?
    
    //Variable to hold the image data of the image
    var imageData: Data?
    
    //Variable to store the string representation of the image
    var stringRepresentation : String?
    
    //Variable to hold all the string representations of the image
    var textArray : [Text]!
    
    init(image : UIImage) {
        self.image = image
    }
    
    //Convert the Image to the ImageData format
    func convertData(){
        self.imageData = UIImageJPEGRepresentation(self.image!, 0.7)
    }
    
    //Convert the Image to the text format
    func convertText(){
        let base64 = imageData?.base64EncodedData()
        print(self.imageData?.count)
        self.stringRepresentation = String(data: base64!, encoding: .utf8)
        print(stringRepresentation!)
    }
    
    //Convert everything using methods created
    func convert(){
        convertData()
        convertText()
    }
    
    //Build the textArray out of objects
    func convertTextObject(){
        
    }
}
