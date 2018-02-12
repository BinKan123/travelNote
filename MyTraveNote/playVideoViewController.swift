//
//  playVideoViewController.swift
//  MyTraveNote
//
//  Created by user134225 on 2018-02-12.
//  Copyright © 2018 user134225. All rights reserved.
//

import UIKit
import  AVFoundation

class playVideoViewController: UIViewController {

    @IBOutlet weak var playBtn: UIButton!
    
    @IBOutlet weak var resetBtn: UIButton!
    
    var videoPlayer: AVPlayer!
    var isPlaying = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPlayer()
    }
    
    func setUpPlayer() {
        let videourl = URL(fileURLWithPath: NSTemporaryDirectory() + "output.mov")
        let asset = AVURLAsset(url: videourl, options: nil)
        let playerItem = AVPlayerItem(asset: asset)
        videoPlayer = AVPlayer(playerItem: playerItem)
        
        let playerLayer = AVPlayerLayer(player: videoPlayer)
        playerLayer.frame = UIScreen.main.bounds
        playerLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(playerLayer)
        
        view.bringSubview(toFront: playBtn)
        view.bringSubview(toFront: resetBtn)
    }
    
    @IBAction func playVideo(_ sender: Any) {
        if isPlaying {
            videoPlayer.pause()
            playBtn.setImage(UIImage(named: "play"), for: UIControlState.normal)
        } else {
            videoPlayer.play()
            playBtn.setImage(UIImage(named: "pause"), for: UIControlState.normal)
        }
        isPlaying = !isPlaying
    }
    
    
    @IBAction func resetVideo(_ sender: Any) {
        videoPlayer.seek(to: kCMTimeZero)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
