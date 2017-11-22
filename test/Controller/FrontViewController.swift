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

    var post: Post?
    var posts = [PostCD]()
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenus()
        saveNewPost()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        do {
            posts = try context.fetch(PostCD.fetchRequest())
            let sort = NSSortDescriptor(keyPath: \PostCD.id, ascending: true)
//            request.sort
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo) ")
        }
    }

        
        
    func saveNewPost(){
        let id = 1
        
        ServerManager.getPost(id: id) { (post, error) in
            if error != nil {
                return
            }
            guard let myPost = post else {
                return
            }
            self.post = myPost
            let postCD = PostCD(entity: PostCD.entity(), insertInto: self.context)
            
            
            if let myID = self.post?.id {
                postCD.id = Int16(myID)
                self.post_title.text = postCD.title
            } else { return }
            
            if let myTitle = self.post?.title {
                postCD.title = myTitle
//                self.post_title.text = postCD.title
            } else { return }
            
            if let myBody = self.post?.body {
                postCD.body = myBody
//                self.post_body.text = postCD.body
            } else { return }
            self.appDelegate.saveContext()
        }
    }
    
    func viewNewPost(){
        
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
