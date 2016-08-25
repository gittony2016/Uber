//
//  AppDelegate.swift
//  Uber
//
//  Created by Tony on 16/4/22.
//  Copyright © 2016年 Tony. All rights reserved.
//

import UIKit
import UberRides

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var vc: ViewController!
    var window: UIWindow?
    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        /*let s = url.absoluteString
        let str=(s as NSString).substringFromIndex(32)
        let s1 = str.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        print(s1)
        let request = NSMutableURLRequest(URL: NSURL(string: "https://login.uber.com/oauth/v2/token?client_secret=vmrx6KHaCRUUtBXHxOSBJaxUzTfgzLr9erk11gad&client_id=uyoGbOAJTjHcXq98KQemB3jLEwgraDK0&grant_type=authorization_code&code=\(s1)")!)
        //request.addValue("Token QTqspSAw4vK4jero1440LTWh34u0ooE2HncHqOoV", forHTTPHeaderField: "Authorization")
        request.HTTPMethod = "POST" // or POST or whatever
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) in
            // handle your data here
            let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print(dataString)
        }
        //print(str)*/
        /*if let code = url.query {
            let request = NSMutableURLRequest(URL: NSURL(string: "https://login.uber.com/oauth/v2/token?\(code)&client_secret=vmrx6KHaCRUUtBXHxOSBJaxUzTfgzLr9erk11gad&client_id=uyoGbOAJTjHcXq98KQemB3jLEwgraDK0&grant_type=authorization_code")!)
            request.HTTPMethod = "POST"
            //request.setValue("application/json", forHTTPHeaderField: "Accept")
            NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
                if let httpResponse = response as? NSHTTPURLResponse {
                    do {
                    //var jsonError: NSError?
                    if let rootObject = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String : AnyObject], token = rootObject["access_token"] as? String {
                        //Save and handle the token
                        print(token)
                    }
                    }catch {
                        print("error in response")
                    }
                }
            }).resume()
        }*/
        let s = url.absoluteString
        //print(s)
        let str=(s as NSString).substringFromIndex(31)
        var s1 = str.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        var s2 = ""
        //print(s1)

        let request = NSMutableURLRequest(URL: NSURL(string: "https://login.uber.com/oauth/v2/token")!)
        request.HTTPMethod = "POST"
        var postString = "client_secret=vmrx6KHaCRUUtBXHxOSBJaxUzTfgzLr9erk11gad&client_id=uyoGbOAJTjHcXq98KQemB3jLEwgraDK0&grant_type=authorization_code&code=\(s1)&redirect_uri=dev://Devhub-Pty-Ltd.Uber&scope=request"
        //print(postString)
        postString = postString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())!
        //print(postString)
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        //print(request.HTTPBody)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {
                // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                //print("statusCode should be 200, but is \(httpStatus.statusCode)")
                //print("response = \(response)")
            }
            
            //let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            //print("responseString = \(responseString)")
            //func deal_Json() {
            do {
                //获取JSON数据
                //let data = try NSData(contentsOfURL: u!,options:NSDataReadingOptions.DataReadingUncached)
                let json:AnyObject = try NSJSONSerialization.JSONObjectWithData(data!,options:NSJSONReadingOptions.AllowFragments)
                
                //解析获取JSON字段值
                let access_token:AnyObject = json.objectForKey("access_token")! //json结构字段名。
                let refresh_token:AnyObject = json.objectForKey("refresh_token")!
                //let city:AnyObject = weatherInfo.objectForKey("city")!
                //以此类推获取其他字段的信息,再此我就不过多赘述了。
                s1 = access_token as! String
                s2 = refresh_token as! String
                //print("s2 ========= ",s2)
                //然后把获取到的json值赋值个相应的控件即可。
                //lb.text = "城市:\(city)" //使用\()可以将变量嵌入到相应的字符串
            } catch {
                //lb.text = "Unavailable to collect data!"
            }
            // }
            
            /*let config = NSURLSessionConfiguration.defaultSessionConfiguration()
            //let userPasswordString = "username@gmail.com:password"
            //let userPasswordData = userPasswordString.dataUsingEncoding(NSUTF8StringEncoding)
            //let base64EncodedCredential = userPasswordData!.base64EncodedStringWithOptions(nil)
            let authString = "Bearer \(s1)"
            //print(s1)
            config.HTTPAdditionalHeaders = ["Authorization ": authString]
            let session = NSURLSession(configuration: config)
            
           // var running = false
            let url1 = NSURL(string: "https://sandbox-api.uber.com/v1/requests/current")
            let task1 = session.dataTaskWithURL(url1!) {
                (let data, let response, let error) in
                if let httpResponse = response as? NSHTTPURLResponse {
                    let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    
                    //"https://login.uber.com/oauth/v2/token"
                    //var data:NSData! =  NSKeyedArchiver.archivedDataWithRootObject(params)
                    //"refresh_token=\(s2)&redirect_uri=dev://Devhub-Pty-Ltd.Uber&grant_type=refresh_token&client_id=uyoGbOAJTjHcXq98KQemB3jLEwgraDK0&client_secret=vmrx6KHaCRUUtBXHxOSBJaxUzTfgzLr9erk11gad".stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())!.dataUsingEncoding(NSUTF8StringEncoding)
                    //println(request)
                    print("datastring = ",  dataString)
                }
              //  running = false
            }
            //running = tru
            task1.resume()*/
            
            
            let request = NSMutableURLRequest(URL: NSURL(string: "https://sandbox-api.uber.com/v1/requests")!)
            request.HTTPMethod = "POST"
            request.addValue("Bearer \(s1)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.HTTPBody = "{\"start_latitude\":\"37.334381\",\"start_longitude\":\"-121.89432\",\"end_latitude\":\"37.77703\",\"end_longitude\":\"-122.419571\"}".dataUsingEncoding(NSUTF8StringEncoding)
            //print(request.HTTPBody)
            let task1 = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
                guard error == nil && data != nil else {
                    // check for fundamental networking error
                    print("error=\(error)")
                    return
                }
                
                if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {
                    
                }
                
                //let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                //print("datastring ================== \(dataString)")
            }
            task1.resume()
            
            
            
            let url2:NSURL = NSURL(string: "https://login.uber.com/oauth/v2/token")!
            //let session = NSURLSession.sharedSession()
            
            let request1 = NSMutableURLRequest(URL: url2)
            request1.HTTPMethod = "POST"
            //request1.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
            
            let paramString = "refresh_token=\(s2)&redirect_uri=dev://Devhub-Pty-Ltd.Uber&grant_type=refresh_token&client_id=uyoGbOAJTjHcXq98KQemB3jLEwgraDK0&client_secret=vmrx6KHaCRUUtBXHxOSBJaxUzTfgzLr9erk11gad".stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())!
            request1.HTTPBody = paramString.dataUsingEncoding(NSUTF8StringEncoding)
            //print("http ============ ",paramString,"   request1 ============== ", request1.HTTPBody)
            let task2 = NSURLSession.sharedSession().dataTaskWithRequest(request1) {
                (
                let data1, let response, let error) in
                if let httpResponse = response as? NSHTTPURLResponse {
                    //let dataString1 = NSString(data: data1!, encoding: NSUTF8StringEncoding)
                    do {
                        //获取JSON数据
                        //let data = try NSData(contentsOfURL: u!,options:NSDataReadingOptions.DataReadingUncached)
                        let json:AnyObject = try NSJSONSerialization.JSONObjectWithData(data1!,options:NSJSONReadingOptions.AllowFragments)
                        
                        //解析获取JSON字段值
                        let access_token:AnyObject = json.objectForKey("access_token")! //json结构字段名。
                        let refresh_token:AnyObject = json.objectForKey("refresh_token")!
                        //let city:AnyObject = weatherInfo.objectForKey("city")!
                        //以此类推获取其他字段的信息,再此我就不过多赘述了。
                        s1 = (access_token as! String).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
                        s2 = (refresh_token as! String).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
                        //print("s2 ========= ",s2)
                        //然后把获取到的json值赋值个相应的控件即可。
                        //lb.text = "城市:\(city)" //使用\()可以将变量嵌入到相应的字符串
                    } catch {
                        //lb.text = "Unavailable to collect data!"
                    }
                    //print(" res ======= ",dataString1)
                    //print("access_token ======= ",s1)
                    
                    //re-postlet request = NSMutableURLRequest(URL: NSURL(string: "https://login.uber.com/oauth/v2/token")!)
                    
                    
                    
                    
                    let request = NSMutableURLRequest(URL: NSURL(string: "https://sandbox-api.uber.com/v1/requests/current")!)
                    request.HTTPMethod = "GET"
                    request.addValue("Bearer \(s1)", forHTTPHeaderField: "Authorization")
                    //print(request.HTTPBody)
                    let task3 = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
                        guard error == nil && data != nil else {
                            // check for fundamental networking error
                            print("error=\(error)")
                            return
                        }
                        
                        if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {
                            
                        }
                        
                        //let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                        //print("response ================== \(dataString)")
                        do {
                            //获取JSON数据
                            //let data = try NSData(contentsOfURL: u!,options:NSDataReadingOptions.DataReadingUncached)
                            let json:AnyObject = try NSJSONSerialization.JSONObjectWithData(data!,options:NSJSONReadingOptions.AllowFragments)
                            
                            //解析获取JSON字段值
                            //let access_token:AnyObject = json.objectForKey("access_token")! //json结构字段名。
                            let get = json.objectForKey("surge_multiplier")!
                            //self.vc.txtView.text = "\(get)"
                            print(get)
                            
                            //let rootViewController = self.window!.rootViewController
                            //let self.window!.rootViewController = self.vc
                            //let firstVC = ViewController(nibName:nil,bundle: nil)
                            dispatch_sync(dispatch_get_main_queue())
                            {
                            self.vc.txtView?.text = "\(get)"
                            }
                            
                        } catch {
                            //lb.text = "Unavailable to collect data!"
                        }

                    }
                    task3.resume()
                    
                    
                }
            }
            task2.resume()
            
        }
        task.resume()
        
        
        
       
        
        
        
        
        return true
    }

    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // China based apps should specify the region
        //Configuration.setRegion(.China)
        // If true, all requests will hit the sandbox, useful for testing
        Configuration.setSandboxEnabled(true)
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

