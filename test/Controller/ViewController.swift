//
//  ViewController.swift
//  test
//
//  Created by Abdullah on 14.09.17.
//  Copyright © 2017 Abdullah. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    

    @IBAction func action(_ sender: Any) {
        let content = UNMutableNotificationContent()
        content.title = "О те, которые уверовали!"
        content.body = "Благославляйте Пророка Мухаммада!"
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        UNUserNotificationCenter.current().requestAuthorization(options: [ .alert, .sound, .badge], completionHandler: {didAllow, error in})
        
        let content = UNMutableNotificationContent()
        content.title = "О те, которые уверовали!"
        content.body = "Благославляйте Пророка Мухаммада!"
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        var dateComponents = DateComponents()
        dateComponents.hour = 22
        dateComponents.minute = 10
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

