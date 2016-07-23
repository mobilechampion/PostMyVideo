//
//  ShoppingCartViewController.swift
//  PostMyVideo
//
//  Created by gold on 9/26/15.
//  Copyright (c) 2015 gold. All rights reserved.
//

import UIKit

class ShoppingCartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back_btn(sender: AnyObject) {
        self.navigationController!.popViewControllerAnimated(true)
    }
    
    
    @IBAction func payment_btn(sender: AnyObject) {
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
