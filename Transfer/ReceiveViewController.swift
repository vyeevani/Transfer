//
//  ReceiveViewController.swift
//  Transfer
//
//  Created by Vineeth Yeevani on 10/7/17.
//  Copyright © 2017 Vineeth Yeevani. All rights reserved.
//

import UIKit
import AVFoundation

class ReceiveViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    //Capture Session to read qr codes
    var captureSession: AVCaptureSession!
    
    //Preview layer to see what is being scanned
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    //Array to hold the Text Json objects
    var textArray: [Text] = []
    
    var textArrayKeys : [String]! = []
    
    var imageString : String! = ""
    //Variable to hold the temp image scanned before adding to array
    var tempTextObject : Text?
    
    
    
    
    /* Post Image Processing Variables */
    
    var imageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        createQrScanner()
    }
    
    //Function to generate the preview layer
    func createQrScanner() {
        
        //Create the capture session
        captureSession = AVCaptureSession()
        
        //Create the capture device
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        
        //Create the input
        let videoInput : AVCaptureDeviceInput
        do{
            videoInput = try AVCaptureDeviceInput(device: captureDevice)
        } catch { return }
        
        //Set the input
        captureSession.addInput(videoInput)
        
        /* Start metadata creation */
        
        //Create the metadata variable
        let metadataOutput = AVCaptureMetadataOutput()
        
        captureSession.addOutput(metadataOutput)
        metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        metadataOutput.metadataObjectTypes = [.qr]
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
        
        
    }
    
    //Execute this whenever a qr code is seen by the camera
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        /* Check to make sure that the metadata object exists and is in the first index of the
         array of metadata objects */
        if let metadataObject = metadataObjects.first {
            
            /*  Description --
                 Read the Object and then cast into a string and then a json object in order to make it more readable
             */
            
            
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            
            print(readableObject)
            
            tempTextObject = Text(text: stringValue)
            
            if((tempTextObject?.key)! == "Finish"){
                //Do all post image processing things here
                for i in textArray {
                    imageString = imageString + i.value
                }
                
                print(imageString)
                captureSession.stopRunning()
                previewLayer.removeFromSuperlayer()
                
                postImageProcessing()
            }
            
            if(textArrayKeys.contains((tempTextObject?.key)!)){}
            else {
                textArrayKeys.append((tempTextObject?.key!)!)
                textArray.append(tempTextObject!)
                print("Read")
            }
        }
    }
    
    
    /* Post Image Processing */
    
    func postImageProcessing() {
        createImageView()
        setImage()
    }
    
    //Creates the Image View
    func createImageView(){
        imageView = UIImageView(frame: CGRect(x:0, y:0, width: view.frame.width, height: view.frame.width))
        view.addSubview(imageView)
    }
    
    //Sets the image for the image view by restitching the string together
    func setImage(){
        let imageData = Data(base64Encoded: imageString, options: .ignoreUnknownCharacters)
        imageView.image = UIImage(data: imageData!)
    }
    
    
}
