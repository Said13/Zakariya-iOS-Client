//
//  SettingsPopUpViewController.swift
//  Wathakkir
//
//  Created by Abdullah on 09.10.17.
//  Copyright © 2017 Abdullah. All rights reserved.
//

import UIKit

class SettingsPopUpViewController: UITableViewController {
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    @IBAction func closeView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        
        setupNavigationBarItems()
        
        
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }


    private func setupNavigationBarItems() {
        
        navigationItem.title = "Настройки"
        let textAttributes = [NSForegroundColorAttributeName:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.barTintColor = UIColor(red: 21/225, green: 22/225, blue: 26/225, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
        let height: CGFloat = 50 //whatever height you want
        let bounds = self.navigationController!.navigationBar.bounds
        navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height + height)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
