//
//  FrontViewController.swift
//  Wathakkir
//
//  Created by Abdullah on 29.09.17.
//  Copyright © 2017 Abdullah. All rights reserved.
//

import UIKit
import UserNotifications
import Realm
import RealmSwift

class FrontViewController: UIViewController {
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var menuButton: UIButton!

    var post: Post?
    var posts = [RealmPost]()
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(Realm.Configuration.defaultConfiguration.fileURL!)

        sideMenus()
        getLastPost()
    }
    
    func getTodayData() -> String{
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: today)
        return result
    }
    
    func getLastPost(){
        let posts = realm.objects(RealmPost.self)
        //print(Realm.Configuration.defaultConfiguration.fileURL!)
        let sorted = posts.sorted(byKeyPath: "id")
        let last = sorted.last
        let post = last
        let formatter = DateFormatter()
        let postData: String
        formatter.dateFormat = "dd.MM.yyyy"
        if (post == nil) {
            saveNewPost(id: 1)
        } else {
            if let sData = post?.date_added {
                postData = formatter.string(from: sData)
            } else { return }
            if (postData == getTodayData()) {
                viewLastPost()
            } else {
                if let sId = post?.id {
                    saveNewPost(id: (sId + 1))
                } else { return }
            }
        }
    }
    
    func saveNewPost(id: Int){
        ServerManager.getPost(id: id) { (post, error) in
            if error != nil {
                return
            }
            guard let myPost = post else {
                return
            }
            self.post = myPost
            let rPost = RealmPost()
            
            if let myId = self.post?.id, let myTitle = self.post?.title, let myBody = self.post?.body {
                rPost.id = myId
                rPost.title = myTitle
                rPost.body = myBody
            } else { return }
            
//            if let myTitle = self.post?.title {
//                rPost.title = myTitle
//            } else { return }
//
//            if let myBody = self.post?.body {
//                rPost.body = myBody
//            } else { return }
//            
            rPost.date_added = Date()
            
            try! self.realm.write {
                self.realm.add(rPost)
            }
            self.viewLastPost()
        }
    }

    
    func viewLastPost(){
        let posts = realm.objects(RealmPost.self)
        let sorted = posts.sorted(byKeyPath: "id")
        let last = sorted.last
        let post = last
        
        if let myTitle = post?.title {
            titleLabel.text = myTitle
        } else { return }

        if let myBody = post?.body {
            bodyLabel.text = myBody
        } else { return }

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
