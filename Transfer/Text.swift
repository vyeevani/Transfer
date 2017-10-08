//
//  Text.swift
//  Transfer
//
//  Created by Vineeth Yeevani on 10/7/17.
//  Copyright © 2017 Vineeth Yeevani. All rights reserved.
//


import Foundation
import UIKit

class Text{
    
    //Dictionary that the string is transfered in
    var dictionary: [String: String] = [:]
    
    var key: String!
    
    var value: String!
    
    //Actual text of the string
    var text: String = String()
    
    //Data from the text
    var textData: Data = Data()
    
    //Filter to convert to QR code for the CIImage
    var filter: CIFilter = CIFilter()
    
    //QR code generated
    var qrCode: CIImage = CIImage()
    
    //Image to be outputted
    var image: UIImage = UIImage()
    
    init(text: String) {
        
        if let data = text.data(using: .utf8) {
            do {
                print("fail 1")
                self.dictionary = try JSONSerialization.jsonObject(with: data, options: []) as! [String: String]
                print("Fail 2")
                self.key = self.dictionary.keys.first!
                print("Frail 3")
                self.value = self.dictionary[self.key]!
                print("fail 4")
            } catch {
                print("fail 5")
                self.text = text
            }
        }
        
        //Sets the filter attributes for the class
        self.filter = CIFilter(name: "CIQRCodeGenerator")!
        self.filter.setValue("Q", forKey: "inputCorrectionLevel")
    }
    
    
    //Convert the text into a qr code
    func qrConvert(){
        self.textData = self.text.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)!
        self.filter.setValue(self.textData, forKey: "inputMessage")
        self.image = UIImage(ciImage: (self.filter.outputImage)!)
    }
    
}
