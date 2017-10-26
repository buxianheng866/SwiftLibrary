//
//  LPLiveStreamController.swift
//  SwiftLib
//
//  Created by nb616 on 2017/10/24.
//  Copyright © 2017年 nb616. All rights reserved.
//

import UIKit
import LFLiveKit
import AVFoundation
class LPLiveStreamController: UIViewController {

    @IBOutlet weak var liveSender: UIButton!
    @IBOutlet weak var linkingState: UILabel!
    var ipAddress = "192.168.99.117"
    var suffix = "bxhrtmplive"
    lazy var session: LFLiveSession = {
       
          /***   默认分辨率368 ＊ 640  音频：44.1 iphone6以上48  双声道  方向竖屏 ***/
        let videoConfig = LFLiveVideoConfiguration.defaultConfiguration(for: LFLiveVideoQuality.low3)
//        videoConfig?.videoSize = CGSize(width: 360, height: 640)
//        videoConfig?.videoBitRate = 800 * 1024
//        videoConfig?.videoMaxBitRate = 1000 * 1024
//        videoConfig?.videoMinBitRate = 500 * 1024
//        videoConfig?.videoFrameRate = 24
//        videoConfig?.videoMaxKeyframeInterval = 48
        
        /** 定制声道 单双*/
        let audioConfig = LFLiveAudioConfiguration.default()
//        audioConfig?.numberOfChannels = 1
//        audioConfig?.audioBitrate = ._32Kbps
//        audioConfig?.audioSampleRate = ._44100Hz
        
        
        let session = LFLiveSession(audioConfiguration: audioConfig, videoConfiguration: videoConfig)
        session?.delegate = self
        session?.preView = self.view
        return session!
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.orange
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.requestAccessForMedia()
        self.requestAccessForVideo()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    @IBAction func backAction(_ sender: Any) {
        self.stopLive()
        self.navigationController?.popViewController(animated: true)
    }
    
  
    @IBAction func changeCamera(_ sender: Any) {
        let position = self.session.captureDevicePosition
        self.session.captureDevicePosition = position == .back ? .front : .back
    }
    
    @IBAction func ControlStreamLive(_ sender: Any) {
        let btn = sender as! UIButton
        if btn.isSelected {
           self.stopLive()
        } else {
            self.startLive()
        }
        btn.isSelected = !btn.isSelected
    }
    
    @IBAction func openmeiyan(_ sender: Any) {
        self.session.beautyFace = !self.session.beautyFace;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

extension LPLiveStreamController {
    func startLive() -> Void {
        let stream = LFLiveStreamInfo()
        stream.url = "rtmp://\(self.ipAddress):1935/\(self.suffix)/piaodadie"
        self.session.startLive(stream)
        
    }
    
    func stopLive() -> Void {
        self.session.stopLive()
    }
    
    func requestAccessForVideo() -> Void {
        let state = AVCaptureDevice.authorizationStatus(for: .video)
        switch state {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { [weak self] granted in
                guard granted else { return }
                DispatchQueue.main.async(execute: {
                    self?.session.running = true
                })
            })
        case .authorized:
            DispatchQueue.main.async(execute: { [weak self] in
                self?.session.running = true
            })
        default:
            printLog("other")
        }
    }
    
    func requestAccessForMedia() -> Void {
        let status = AVCaptureDevice.authorizationStatus(for: .audio)
        switch status {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .audio, completionHandler: { [weak self] granted in
                 guard granted else { return }
                 DispatchQueue.main.async(execute: {
                    
                    self?.session.running = true
                 })
                
            })
        case .authorized:
            DispatchQueue.main.async(execute: { [weak self] in
                self?.session.running = true
            })
        default:
            print("other")
        }
        
    }
    
}

extension LPLiveStreamController: LFLiveSessionDelegate {
    func liveSession(_ session: LFLiveSession?, liveStateDidChange state: LFLiveState) {
        switch state {
        case .ready:
            self.linkingState.text = "准备中"
        case .pending:
            self.linkingState.text = "连接中..."
        case .start:
            self.linkingState.text = "直播中"
        case .stop:
            self.linkingState.text = "断开连接"
        case .error:
            self.linkingState.text = "连接错误"
        case .refresh:
            self.linkingState.text = "正在刷新"
        }
    }
    
    func liveSession(_ session: LFLiveSession?, debugInfo: LFLiveDebug?) {
        printLog("debugInfo---->\(String(describing: debugInfo))")
    }
    
    func liveSession(_ session: LFLiveSession?, errorCode: LFLiveSocketErrorCode) {
        printLog("errorCode----->\(errorCode)")
    }
}
/*
 /**    自己定制单声道  */
 /*
 LFLiveAudioConfiguration *audioConfiguration = [LFLiveAudioConfiguration new];
 audioConfiguration.numberOfChannels = 1;
 audioConfiguration.audioBitrate = LFLiveAudioBitRate_64Kbps;
 audioConfiguration.audioSampleRate = LFLiveAudioSampleRate_44100Hz;
 _session = [[LFLiveSession alloc] initWithAudioConfiguration:audioConfiguration videoConfiguration:[LFLiveVideoConfiguration defaultConfiguration]];
 */
 
 /**    自己定制高质量音频96K */
 /*
 LFLiveAudioConfiguration *audioConfiguration = [LFLiveAudioConfiguration new];
 audioConfiguration.numberOfChannels = 2;
 audioConfiguration.audioBitrate = LFLiveAudioBitRate_96Kbps;
 audioConfiguration.audioSampleRate = LFLiveAudioSampleRate_44100Hz;
 _session = [[LFLiveSession alloc] initWithAudioConfiguration:audioConfiguration videoConfiguration:[LFLiveVideoConfiguration defaultConfiguration]];
 */
 
 /**    自己定制高质量音频96K 分辨率设置为540*960 方向竖屏 */
 
 /*
 LFLiveAudioConfiguration *audioConfiguration = [LFLiveAudioConfiguration new];
 audioConfiguration.numberOfChannels = 2;
 audioConfiguration.audioBitrate = LFLiveAudioBitRate_96Kbps;
 audioConfiguration.audioSampleRate = LFLiveAudioSampleRate_44100Hz;
 
 LFLiveVideoConfiguration *videoConfiguration = [LFLiveVideoConfiguration new];
 videoConfiguration.videoSize = CGSizeMake(540, 960);
 videoConfiguration.videoBitRate = 800*1024;
 videoConfiguration.videoMaxBitRate = 1000*1024;
 videoConfiguration.videoMinBitRate = 500*1024;
 videoConfiguration.videoFrameRate = 24;
 videoConfiguration.videoMaxKeyframeInterval = 48;
 videoConfiguration.orientation = UIInterfaceOrientationPortrait;
 videoConfiguration.sessionPreset = LFCaptureSessionPreset540x960;
 
 _session = [[LFLiveSession alloc] initWithAudioConfiguration:audioConfiguration videoConfiguration:videoConfiguration];
 */
 
 
 /**    自己定制高质量音频128K 分辨率设置为720*1280 方向竖屏 */
 
 /*
 LFLiveAudioConfiguration *audioConfiguration = [LFLiveAudioConfiguration new];
 audioConfiguration.numberOfChannels = 2;
 audioConfiguration.audioBitrate = LFLiveAudioBitRate_128Kbps;
 audioConfiguration.audioSampleRate = LFLiveAudioSampleRate_44100Hz;
 
 LFLiveVideoConfiguration *videoConfiguration = [LFLiveVideoConfiguration new];
 videoConfiguration.videoSize = CGSizeMake(720, 1280);
 videoConfiguration.videoBitRate = 800*1024;
 videoConfiguration.videoMaxBitRate = 1000*1024;
 videoConfiguration.videoMinBitRate = 500*1024;
 videoConfiguration.videoFrameRate = 15;
 videoConfiguration.videoMaxKeyframeInterval = 30;
 videoConfiguration.landscape = NO;
 videoConfiguration.sessionPreset = LFCaptureSessionPreset360x640;
 
 _session = [[LFLiveSession alloc] initWithAudioConfiguration:audioConfiguration videoConfiguration:videoConfiguration];
 */
 
 
 /**    自己定制高质量音频128K 分辨率设置为720*1280 方向横屏  */
 
 /*
 LFLiveAudioConfiguration *audioConfiguration = [LFLiveAudioConfiguration new];
 audioConfiguration.numberOfChannels = 2;
 audioConfiguration.audioBitrate = LFLiveAudioBitRate_128Kbps;
 audioConfiguration.audioSampleRate = LFLiveAudioSampleRate_44100Hz;
 
 LFLiveVideoConfiguration *videoConfiguration = [LFLiveVideoConfiguration new];
 videoConfiguration.videoSize = CGSizeMake(1280, 720);
 videoConfiguration.videoBitRate = 800*1024;
 videoConfiguration.videoMaxBitRate = 1000*1024;
 videoConfiguration.videoMinBitRate = 500*1024;
 videoConfiguration.videoFrameRate = 15;
 videoConfiguration.videoMaxKeyframeInterval = 30;
 videoConfiguration.landscape = YES;
 videoConfiguration.sessionPreset = LFCaptureSessionPreset720x1280;
 
 _session = [[LFLiveSession alloc] initWithAudioConfiguration:audioConfiguration videoConfiguration:videoConfiguration];
 */
 
 */
