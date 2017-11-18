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
    
    @IBOutlet weak var menuButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenus()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [ .alert, .sound, .badge], completionHandler: {didAllow, error in})
        
        
        let hours: [Int] = [18]
        for hour in hours {
            for minute in stride(from: 47, to: 50, by: 1){
                let content = UNMutableNotificationContent()
                content.title = "заголовок"
                content.body = "текст"
                //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                var dateComponents = DateComponents()
                dateComponents.hour = hour
                dateComponents.minute = minute
                print(dateComponents)
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                let request = UNNotificationRequest(identifier: ("\(hour)"+"\(minute)"+"timerDone"), content: content, trigger: trigger)
                let center = UNUserNotificationCenter.current()
                center.add(request, withCompletionHandler: nil)
                center.getPendingNotificationRequests(completionHandler: { requests in
                    for request in requests {
                        print(request.trigger!)
                    }
                })
                center.removeAllPendingNotificationRequests()
            }
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
