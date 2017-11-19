//
//  FrontViewController.swift
//  Wathakkir
//
//  Created by Abdullah on 29.09.17.
//  Copyright © 2017 Abdullah. All rights reserved.
//

import UIKit
import UserNotifications



class FrontViewController: UIViewController {
    @IBOutlet weak var post_title: UILabel!
    @IBOutlet weak var post_body: UILabel!
    
    @IBOutlet weak var menuButton: UIButton!

    var Post: Post?
    var history: [Post] = []

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenus()
        loadPost()
        
        
       
    }
//        UNUserNotificationCenter.current().requestAuthorization(options: [ .alert, .sound, .badge], completionHandler: {didAllow, error in})
//
//
//        let hours: [Int] = [18]
//        for hour in hours {
//            for minute in stride(from: 47, to: 50, by: 1){
//                let content = UNMutableNotificationContent()
//                content.title = "заголовок"
//                content.body = "текст"
//                //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//                var dateComponents = DateComponents()
//                dateComponents.hour = hour
//                dateComponents.minute = minute
//                print(dateComponents)
//                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//                let request = UNNotificationRequest(identifier: ("\(hour)"+"\(minute)"+"timerDone"), content: content, trigger: trigger)
//                let center = UNUserNotificationCenter.current()
//                center.add(request, withCompletionHandler: nil)
//                center.getPendingNotificationRequests(completionHandler: { requests in
//                    for request in requests {
//                        print(request.trigger!)
//                    }
//                })
//                center.removeAllPendingNotificationRequests()
//            }
//        }
        
        
    func loadPost(){
        let id = 1
        
        ServerManager.getPost(id: id) { (post, error) in
            if error != nil {
                return
            }
            guard let myPost = post else {
                return
            }
            self.Post = myPost
            
            if let myTitle = self.Post?.title {
                self.post_title.text = myTitle
            } else { return }
            
            if let myBody = self.Post?.body {
                self.post_body.text = myBody
            } else { return }
        }
    }
        
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sideMenus() {
        if revealViewController() != nil {
            menuButton.addTarget(revealViewController, action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
            revealViewController().rearViewRevealWidth = 300
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
}
