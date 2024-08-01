//
//  FlutterAVPlayer.swift
//  flutter_to_airplay
//
//  Created by Junaid Rehmat on 22/08/2020.
//

import Foundation
import AVKit
import AVFoundation
import MediaPlayer
import Flutter

class FlutterAVPlayer: NSObject, FlutterPlatformView {
    private var _flutterAVPlayerViewController : AVPlayerViewController;
    
    private var looper : AVPlayerLooper?
    private var playerItem: AVPlayerItem?

    init(frame:CGRect,
          viewIdentifier: CLongLong,
          arguments: Dictionary<String, Any>,
          binaryMessenger: FlutterBinaryMessenger) {
        let autoLoop = arguments["autoLoop"] as? Bool ?? false

        _flutterAVPlayerViewController = AVPlayerViewController()
        _flutterAVPlayerViewController.viewDidLoad()
        
        let queuePlayer = AVQueuePlayer()

        if let urlString = arguments["url"] {
            let url = URL(string: urlString as! String)!
            playerItem = AVPlayerItem(url: url)
        } else if let filePath = arguments["file"] {
            let appDelegate = UIApplication.shared.delegate as! FlutterAppDelegate
            let vc = appDelegate.window.rootViewController as! FlutterViewController
            let lookUpKey = vc.lookupKey(forAsset: filePath as! String)
            
            if let path = Bundle.main.path(forResource: lookUpKey, ofType: nil) {
                playerItem = AVPlayerItem(url: URL(fileURLWithPath: path))
            } else {
                playerItem = AVPlayerItem(url: URL(fileURLWithPath: filePath as! String))
            }
        }
        
        if let playerItem = playerItem {
            if (autoLoop){
                looper = AVPlayerLooper(player: queuePlayer, templateItem: playerItem)
                _flutterAVPlayerViewController.player = queuePlayer
            } else {
                _flutterAVPlayerViewController.player = AVPlayer(playerItem: playerItem)
            }
            
            _flutterAVPlayerViewController.player?.play()
        }
    }

    func view() -> UIView {
        return _flutterAVPlayerViewController.view;
    }

}

