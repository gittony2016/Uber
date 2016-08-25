//
//  ViewController.swift
//  Uber
//
//  Created by Tony on 16/4/22.
//  Copyright © 2016年 Tony. All rights reserved.
//

import UIKit
import UberRides
import CoreLocation
import Foundation
//import requests

class ViewController: UIViewController {

    @IBOutlet weak var txtView: UITextView!
    @IBAction func btnGet(sender: UIButton) {
        //
        let authURL = NSURL(string: "https://login.uber.com/oauth/v2/authorize?client_id=uyoGbOAJTjHcXq98KQemB3jLEwgraDK0&response_type=code&scope=request")
        UIApplication.sharedApplication().openURL(authURL!)
        //
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        /*let behavior = RideRequestViewRequestingBehavior(presentingViewController: self)
        // Optional, defaults to using the user’s current location for pickup
        let location = CLLocation(latitude: 37.787654, longitude: -122.402760)
        let parameters = RideParametersBuilder().setPickupLocation(location).build()
        let button = RideRequestButton(rideParameters: parameters, requestingBehavior: behavior)
        self.view.addSubview(button)
        // Do any additional setup after loading the view, typically from a nib.
        
        if UIApplication.sharedApplication().canOpenURL(NSURL(fileURLWithPath: "uber://")) {
            // Uber app is installed, construct and open deep link.
        }else{
            // No Uber app, open the mobile site.
        }*/
        /*let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        //let userPasswordString = "username@gmail.com:password"
        //let userPasswordData = userPasswordString.dataUsingEncoding(NSUTF8StringEncoding)
        //let base64EncodedCredential = userPasswordData!.base64EncodedStringWithOptions(nil)
        let authString = "Token QTqspSAw4vK4jero1440LTWh34u0ooE2HncHqOoV"
        config.HTTPAdditionalHeaders = ["Authorization ": authString]
        let session = NSURLSession(configuration: config)
        
        var running = false
        let url = NSURL(string: "https://api.uber.com/v1/products?latitude=37.7759792&longitude=-122.41823")
        let task = session.dataTaskWithURL(url!) {
            (let data, let response, let error) in
            if let httpResponse = response as? NSHTTPURLResponse {
                let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print(dataString)
            }
            running = false
        }
        
        running = true
        task.resume()
        
        while running {
            print("waiting...")
            sleep(1)
        }*/
        /*if let url = NSURL(string:"https://login.uber.com/oauth/v2/authorize?client_id=uyoGbOAJTjHcXq98KQemB3jLEwgraDK0&response_type=code") {
            
            let request = NSURLRequest(URL: url)
            //let response =
            webView.loadRequest(request)
            
        }
        
        let request = NSMutableURLRequest(URL: NSURL(string: "https://login.uber.com/oauth/v2/token")!)
        //request.addValue("Token QTqspSAw4vK4jero1440LTWh34u0ooE2HncHqOoV", forHTTPHeaderField: "Authorization")
        request.HTTPMethod = "GET" // or POST or whatever
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) in
            // handle your data here
            let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print(dataString)
        }*/
        
        //setViewtxt(txtget)
        txtView.text = "0"
        let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appdelegate.vc = self
        
    }
    //var txtget = ""
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
   
    

}

