//
//  SecondViewController.swift
//  Wathakkir
//
//  Created by Abdullah on 26.11.17.
//  Copyright © 2017 Abdullah. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var tableview: UITableView!
    
    let posts = try! Realm().objects(RealmPost.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenus()
        self.tableview.dataSource = self
        self.tableview.delegate = self
        
//        print(posts.count)
//        print(posts)
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
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HistoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HistoryTableViewCell
        let post = posts[indexPath.row]
        cell.textLabel?.text = post.title
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
    
   
}


//func setupNavigationBar() {
//    let textAttributes = [NSForegroundColorAttributeName:UIColor.white]
//    navigationController?.navigationBar.titleTextAttributes = textAttributes
//    navigationItem.title = "История"
//    //        UINavigationBar.appearance().barTintColor = UIColor.init(red: 45/255, green: 45/255, blue: 42/255, alpha: 1.0)
//    navigationController?.navigationBar.barTintColor = UIColor.init(red: 45/255, green: 45/255, blue: 42/255, alpha: 1.0)
//    navigationController?.navigationBar.tintColor = UIColor.white
//    navigationController?.navigationBar.isTranslucent = false
//    
//}

