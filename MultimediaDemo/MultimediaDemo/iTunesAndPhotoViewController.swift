//
//  iTunesAndPhotoViewController.swift
//  MultimediaDemo
//
//  Created by Cody on 2015. 1. 3..
//  Copyright (c) 2015년 tiekle. All rights reserved.
//

import MediaPlayer
import MobileCoreServices

class iTunesAndPhotoViewController: UIViewController, MPMediaPickerControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var musicPlayer : MPMusicPlayerController?
    @IBOutlet var backgroundImageView : UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        musicPlayer = MPMusicPlayerController.systemMusicPlayer()
        musicPlayer?.repeatMode = MPMusicRepeatMode.One
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func touchediTunes(sender:UIButton) {
        var mediaPickerController = MPMediaPickerController(mediaTypes: MPMediaType.AnyAudio)
        mediaPickerController.delegate = self
        mediaPickerController.allowsPickingMultipleItems = false
        mediaPickerController.prompt = "Select Song for BGM"
        presentViewController(mediaPickerController, animated: true, completion: nil)
    }
    
    func mediaPicker(mediaPicker: MPMediaPickerController!, didPickMediaItems mediaItemCollection: MPMediaItemCollection!) {
        
        musicPlayer?.setQueueWithItemCollection(mediaItemCollection)
        musicPlayer?.prepareToPlay()
        musicPlayer?.play()
        mediaPicker.dismissViewControllerAnimated(true, completion: nil)
    }
    func mediaPickerDidCancel(mediaPicker: MPMediaPickerController!) {
        mediaPicker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func touchedPhoto(sender:UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            var imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
            imagePickerController.mediaTypes = [kUTTypeImage]
            imagePickerController.allowsEditing = false
            presentViewController(imagePickerController, animated: true, completion: nil)
        }
        else {
            UIAlertView(title: "Camera", message: "사용할 수 있는 카메라 장치가 없습니다.", delegate: nil, cancelButtonTitle: "확인").show()
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            backgroundImageView?.image = image
            picker.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}
