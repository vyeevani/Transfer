//
//  ViewController.swift
//  Transfer
//
//  Created by Vineeth Yeevani on 10/7/17.
//  Copyright © 2017 Vineeth Yeevani. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    //Button to go to send image
    var sendImage: UIButton!
    //Button to go to receive image
    var receiveImage: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createButtons()
    }
    
    //Create the buttons
    func createButtons(){

        //Create the button to go the send image view
        sendImage = UIButton(frame: CGRect(x: view.frame.width * 0.1, y: view.frame.height * 0.6, width: view.frame.width * 0.8, height: view.frame.height * 0.1))
        sendImage.setTitle("Send an Image", for: .normal)
        sendImage.setTitleColor(Constants.blueColor, for: .normal)
        sendImage.addTarget(self, action: #selector(sendImageView), for: .touchUpInside)
        sendImage.layer.cornerRadius = 8
        view.addSubview(sendImage)

        //Create the button to go to the recieve image view
        receiveImage = UIButton(frame: CGRect(x: view.frame.width * 0.1, y: view.frame.height * 0.73, width: view.frame.width * 0.8, height: view.frame.height * 0.1))
        receiveImage.setTitle("Receive an Image", for: .normal)
        receiveImage.setTitleColor(Constants.blueColor, for: .normal)
        receiveImage.addTarget(self, action: #selector(receiveImageView), for: .touchUpInside)
        receiveImage.layer.cornerRadius = 8
        view.addSubview(receiveImage)
    }
    
    //Segue to Send Image View
    @objc func sendImageView(){
        self.performSegue(withIdentifier: "toSend", sender: self)
    }
    
    //Segue to Receive Image View
    @objc func receiveImageView(){
        self.performSegue(withIdentifier: "toReceive", sender: self)
    }
}
