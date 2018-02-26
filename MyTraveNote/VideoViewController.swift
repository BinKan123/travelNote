//
//  VideoViewController.swift
//  MyTraveNote
//
//  Created by user134225 on 2018-02-08.
//  Copyright © 2018 user134225. All rights reserved.
//

import UIKit
import  AVFoundation
import AVKit

class VideoViewController: UIViewController,AVCaptureFileOutputRecordingDelegate{
    var avSession = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer!
    var videoFileOutput: AVCaptureMovieFileOutput!
    var isRecording = false    

    @IBOutlet weak var recordBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSession()
        // Do any additional setup after loading the view.
    }
    
    func setUpSession() {
        var discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back)
        
        guard let captureDevice = discoverySession.devices.first else {
            print("Camera is not found")
            return
        }
        
        discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInMicrophone], mediaType: AVMediaType.audio, position: .unspecified)
        
        guard let audioDevice = discoverySession.devices.first else {
            print("Micro is not found")
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            avSession.addInput(input)
            avSession.sessionPreset = AVCaptureSession.Preset.high
            
            let inputAudio = try AVCaptureDeviceInput(device: audioDevice)
            avSession.addInput(inputAudio)
            
            videoFileOutput = AVCaptureMovieFileOutput()
            avSession.addOutput(videoFileOutput)
            
            let audioFileOutput = AVCaptureAudioDataOutput()
            avSession.addOutput(audioFileOutput)
            
        } catch {
            print(error)
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: avSession)
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewLayer.frame = UIScreen.main.bounds
        view.layer.addSublayer(previewLayer)
        
        view.bringSubview(toFront: recordBtn)
        avSession.startRunning()
    }
    
  
    @IBAction func captureVideo(_ sender: Any) {
        if !isRecording {
            isRecording = true
            recordBtn.setImage(UIImage(named: "stop_rec"), for: UIControlState.normal)
            let outputPath = NSTemporaryDirectory() + "output.mov"
            let outputFileURL = URL(fileURLWithPath: outputPath)
            videoFileOutput.startRecording(to: outputFileURL, recordingDelegate: self)
        } else {
            isRecording = false
            recordBtn.setImage(UIImage(named: "record"), for: UIControlState.normal)
            videoFileOutput.stopRecording()
        }
    }
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        guard error == nil else {
            print(error!)
            return
        }
        
        //        performSegue(withIdentifier: "showPlayer", sender: outputFileURL)
        performSegue(withIdentifier: "showCustomPlayer", sender: outputFileURL)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  

}
