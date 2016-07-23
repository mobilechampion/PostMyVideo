//
//  AddViewController.swift
//  PostMyVideo
//
//  Created by gold on 9/26/15.
//  Copyright (c) 2015 gold. All rights reserved.
//

import UIKit
import MobileCoreServices
import MediaPlayer
import AVFoundation

extension AddViewController: UIImagePickerControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        dismissViewControllerAnimated(true, completion: nil)
        
        if mediaType == kUTTypeMovie {
            if video_recorded {                             //to play
                let moviePlayer = MPMoviePlayerViewController(contentURL: info[UIImagePickerControllerMediaURL] as! NSURL)
                moviePlayer.moviePlayer.view.sizeToFit()
                moviePlayer.moviePlayer.scalingMode = MPMovieScalingMode.Fill
                moviePlayer.moviePlayer.fullscreen = true
                moviePlayer.moviePlayer.controlStyle = MPMovieControlStyle.None
                moviePlayer.moviePlayer.movieSourceType = MPMovieSourceType.File
                moviePlayer.moviePlayer.repeatMode = MPMovieRepeatMode.One
                moviePlayer.moviePlayer.play()
                self.presentMoviePlayerViewControllerAnimated(moviePlayer)
            }else {                                         //to record
                let path = (info[UIImagePickerControllerMediaURL] as! NSURL).path
                if UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(path!) {
                    UISaveVideoAtPathToSavedPhotosAlbum(path!, self, nil, nil)
//                    var image = info[UIImagePickerControllerOriginalImage] as! UIImage
//                    self.video_btn.setBackgroundImage(image, forState: UIControlState.Normal)
                    
                    var url = info[UIImagePickerControllerMediaURL] as! NSURL
                    var asset : AVAsset = AVAsset(URL: url)
                    var assetImgGenerate : AVAssetImageGenerator = AVAssetImageGenerator(asset: asset)
                    assetImgGenerate.appliesPreferredTrackTransform = true
                    var error       : NSError? = nil
                    var time        : CMTime = CMTimeMake(1, 30)
                    var img         : CGImageRef
                    do {
                        img = try; assetImgGenerate.copyCGImageAtTime(time, actualTime: nil)
                    } catch var error1; as NSError {
                        error = error1
                        img = (CGImage: nil)
                    }
                    var frameImg    : UIImage = UIImage(CGImage: img)!
                    
                    self.video_btn.setBackgroundImage(frameImg, forState: UIControlState.Normal)

                }
            }
            video_recorded = !video_recorded
        }
        else if mediaType == kUTTypeImage {
            var image = info[UIImagePickerControllerOriginalImage] as? UIImage
            self.photo_btn.setBackgroundImage(image, forState: UIControlState.Normal)
        }
    }
}

extension AddViewController: UINavigationControllerDelegate {
    
}


class AddViewController: UIViewController {

    
    @IBOutlet weak var video_btn: UIButton!
    @IBOutlet weak var photo_btn: UIButton!
    @IBOutlet weak var text_btn: UIButton!
    
    var video_recorded = false
    var photo_recorded = false
    var text_recorded = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.video_btn.layer.cornerRadius = self.video_btn.frame.size.height/2
        self.photo_btn.layer.cornerRadius = self.photo_btn.frame.size.height/2
        self.text_btn.layer.cornerRadius = self.text_btn.frame.size.height/2
        
        self.video_btn.clipsToBounds = true
        self.photo_btn.clipsToBounds = true
        self.text_btn.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func next_click(sender: AnyObject) {
        
        
        let nextViewController = self.storyboard!.instantiateViewControllerWithIdentifier("shopVC") as! ShoppingCartViewController
        self.navigationController!.pushViewController(nextViewController, animated: true)
    }

    @IBAction func video_record(sender: AnyObject) {
        if video_recorded {
            NSLog("start playing")
            self.startPlayingVideoFromViewController(self, usingDelegate: self)
        }else {
            NSLog("start recording")
            self.startRecordingVideoFromViewController(self, withDelegate: self)
        }
    }
    
    //video play section
    func startPlayingVideoFromViewController(viewController: UIViewController, usingDelegate delegate: protocol<UINavigationControllerDelegate, UIImagePickerControllerDelegate>) -> Bool {
        // 1
        if UIImagePickerController.isSourceTypeAvailable(.SavedPhotosAlbum) == false {
            return false
        }
        
        // 2
        let mediaUI = UIImagePickerController()
        mediaUI.sourceType = .SavedPhotosAlbum
        mediaUI.mediaTypes = [kUTTypeMovie as String]
        mediaUI.allowsEditing = true
        mediaUI.delegate = delegate
        
        // 3
        presentViewController(mediaUI, animated: true, completion: nil)
        return true
    }
    
    //video record section
    func startRecordingVideoFromViewController(viewController: UIViewController, withDelegate delegate: protocol<UIImagePickerControllerDelegate, UINavigationControllerDelegate>) -> Bool {
        // 1
        if UIImagePickerController.isSourceTypeAvailable(.Camera) == false {
            return false
        }
        // 2
        let cameraController = UIImagePickerController()
        cameraController.sourceType = .Camera
        cameraController.mediaTypes = [kUTTypeMovie as String]
        cameraController.allowsEditing = false
        cameraController.delegate = delegate
        
        presentViewController(cameraController, animated: true, completion: nil)
        return true
    }
    
    @IBAction func photo_record(sender: AnyObject) {
        // 1
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .ActionSheet)
        
        // 2
        let cameraAction = UIAlertAction(title: "Camera", style: .Default, handler: {
            (alert: UIAlertAction) -> Void in
            print("to camera")
            self.startTakePhotoFromViewController(self, withDelegate: self)
        })
        let albumAction = UIAlertAction(title: "Photo Album", style: .Default, handler: {
            (alert: UIAlertAction) -> Void in
            print("to album")
            self.startBrowserFromViewController(self, usingDelegate: self)
        })
        
        // 4
        optionMenu.addAction(cameraAction)
        optionMenu.addAction(albumAction)
        
        // 5
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }
    
    //Browse photo section
    func startBrowserFromViewController(viewController: UIViewController, usingDelegate delegate: protocol<UINavigationControllerDelegate, UIImagePickerControllerDelegate>) -> Bool {
        // 1
        if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) == false {
            return false
        }
        
        // 2
        let mediaUI = UIImagePickerController()
        mediaUI.sourceType = .PhotoLibrary
        mediaUI.mediaTypes = [kUTTypeImage as String]
        mediaUI.allowsEditing = true
        mediaUI.delegate = delegate
        
        // 3
        presentViewController(mediaUI, animated: true, completion: nil)
        return true
    }
    
    //Take photo section
    func startTakePhotoFromViewController(viewController: UIViewController, withDelegate delegate: protocol<UIImagePickerControllerDelegate, UINavigationControllerDelegate>) -> Bool {
        // 1
        if UIImagePickerController.isSourceTypeAvailable(.Camera) == false {
            return false
        }
        // 2
        let cameraController = UIImagePickerController()
        cameraController.sourceType = .Camera
        cameraController.mediaTypes = [kUTTypeImage as String]
        cameraController.allowsEditing = false
        cameraController.delegate = delegate
        
        presentViewController(cameraController, animated: true, completion: nil)
        return true
    }

    @IBAction func text_record(sender: AnyObject) {
        let nextViewController = self.storyboard!.instantiateViewControllerWithIdentifier("textRecordVC") as! TextRecordViewController
        self.navigationController!.pushViewController(nextViewController, animated: true)
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
