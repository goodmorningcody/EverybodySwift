//
//  RecordViewController.swift
//  MultimediaDemo
//
//  Created by Cody on 2015. 1. 5..
//  Copyright (c) 2015년 tiekle. All rights reserved.
//

import UIKit
import AVFoundation

class RecordViewController: UIViewController {

    private var audioRecorder : AVAudioRecorder?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func createAudioRecorder() {
        var recordSettings = [
            AVFormatIDKey : kAudioFormatAppleLossless,
            AVEncoderAudioQualityKey : AVAudioQuality.Medium.rawValue,
            AVEncoderBitRateKey : 320000,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey : 44100.0
        ]
        
        audioRecorder = AVAudioRecorder(URL: NSURL(fileURLWithPath: getRecordingFilePath()), settings: recordSettings, error: nil)
        audioRecorder?.prepareToRecord()
    }
    private func getRecordingFilePath() -> String {
        var dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        var docsDir: AnyObject = dirPaths[0]
        return docsDir.stringByAppendingPathComponent("test-record.m4a")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func touchedRecord(sender: UIButton) {
        if sender.selected==false {
            AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
                if granted {
                    let session:AVAudioSession = AVAudioSession.sharedInstance()
                    session.setCategory(AVAudioSessionCategoryRecord, error: nil)
                    session.setActive(true, error: nil)
                    self.createAudioRecorder()
                    self.audioRecorder?.record()
                }
                else {
                    println("마이크 사용 권한 획득에 실패했습니다.")
                }
            })
        }
        else {
            audioRecorder?.stop()
            audioRecorder = nil
        }
        
        sender.selected = !sender.selected
    }
   
}
