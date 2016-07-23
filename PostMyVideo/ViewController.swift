//
//  ViewController.swift
//  PostMyVideo
//
//  Created by gold on 9/25/15.
//  Copyright (c) 2015 gold. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var login_subView: UIView!

    @IBOutlet weak var email_input: UITextField!
    @IBOutlet weak var psw_input: UITextField!
    @IBOutlet weak var login_btn: UIButton!
    
    
    @IBOutlet weak var signup_subView: UIView!
    
    @IBOutlet weak var username_register: UITextField!
    @IBOutlet weak var email_register: UITextField!
    @IBOutlet weak var psw_register: UITextField!
    @IBOutlet weak var confirm_psw_register: UITextField!
    @IBOutlet weak var signup_btn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.login_subView.hidden = false;
        self.signup_subView.hidden = true;
        
        self.email_input.delegate = self
        self.psw_input.delegate = self
        self.username_register.delegate = self
        self.email_register.delegate = self
        self.psw_register.delegate = self
        self.confirm_psw_register.delegate = self
        
        self.login_btn.layer.cornerRadius = 5
        self.signup_btn.layer.cornerRadius = 5
        
        //swip action - between left and right direction
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        
        leftSwipe.direction = .Left
        rightSwipe.direction = .Right
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleSwipes(sender:UISwipeGestureRecognizer) {
        if (sender.direction == .Left) {
            print("Swipe Left")
            let tutorialController = self.storyboard!.instantiateViewControllerWithIdentifier("tutorialVC") as! TutorialPageViewController
            self.navigationController!.pushViewController(tutorialController, animated: true)
        }
        
        if (sender.direction == .Right) {
            print("Swipe Right")
        }
    }
    
    //Login party
    @IBAction func fb_login_click(sender: AnyObject) {
    }
    
    @IBAction func twitter_login_click(sender: AnyObject) {
    }
    
    @IBAction func google_login_click(sender: AnyObject) {
    }
    
    @IBAction func yahoo_login_click(sender: AnyObject) {
    }
    
    @IBAction func login_btn_click(sender: AnyObject) {
        
        
        
        let secondViewController = self.storyboard!.instantiateViewControllerWithIdentifier("addVC") as! AddViewController
        self.navigationController!.pushViewController(secondViewController, animated: true)
    }
    
    @IBAction func forgot_psw_click(sender: AnyObject) {
    }
    
    @IBAction func create_acc_click(sender: AnyObject) {
        self.signup_subView.hidden = false
    }
    
    @IBAction func cancel_login_click(sender: AnyObject) {
    }
    
    
    //Signup party
    @IBAction func signup_btn_click(sender: AnyObject) {
        
        
        
        let secondViewController = self.storyboard!.instantiateViewControllerWithIdentifier("addVC") as! AddViewController
        self.navigationController!.pushViewController(secondViewController, animated: true)
    }
    
    @IBAction func go_to_login(sender: AnyObject) {
        self.login_subView.hidden = false
        self.signup_subView.hidden = true
    }
    
    
    //UITextField Delegate Method
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

