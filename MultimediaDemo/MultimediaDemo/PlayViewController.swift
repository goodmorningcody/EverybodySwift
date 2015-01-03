//
//  PlayViewController.swift
//  MultimediaDemo
//
//  Created by Cody on 2015. 1. 3..
//  Copyright (c) 2015년 tiekle. All rights reserved.
//

import UIKit
import MediaPlayer
import AVFoundation

class PlayViewController: UIViewController, AVAudioPlayerDelegate {

    var audioPlayer : AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func touchedPlayVideo(sender: UIButton) {
        if let path = NSBundle.mainBundle().pathForResource("video", ofType: "mov") {
            let moviePlayerViewController = MPMoviePlayerViewController()
            presentMoviePlayerViewControllerAnimated(moviePlayerViewController)
            let moviePlayer = moviePlayerViewController.moviePlayer
            moviePlayer.contentURL = NSURL(fileURLWithPath: path)
            moviePlayer.controlStyle = MPMovieControlStyle.None
            moviePlayer.movieSourceType = MPMovieSourceType.File
            moviePlayer.play()
        }
    }
    
    @IBAction func touchedPlayAudio(sender: UIButton) {
        if let path = NSBundle.mainBundle().pathForResource("music", ofType:"mp3") {
            var url = NSURL(fileURLWithPath: path)
            audioPlayer = AVAudioPlayer(contentsOfURL:url, error:nil)
            audioPlayer?.delegate = self
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        }
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        println("오디오 재생이 종료되었습니다.")
    }
}
