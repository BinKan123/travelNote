//
//  createViewController.swift
//  MyTraveNote
//
//  Created by user134225 on 2018-02-07.
//  Copyright © 2018 user134225. All rights reserved.
//

import UIKit
import  AVFoundation
import AVKit

class createViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,AVCaptureFileOutputRecordingDelegate{
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    var imagePicker = UIImagePickerController()
    
    var avSession = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer!
    var videoFileOutput: AVCaptureMovieFileOutput!
    var isRecording = false
    
    
    @IBOutlet weak var photoSource: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func chooseOption(_ sender: Any) {
        switch photoSource.selectedSegmentIndex
        {
        case 0:
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                print("Button capture")
                
                imagePicker.delegate = self
                imagePicker.sourceType = .savedPhotosAlbum;
                imagePicker.allowsEditing = false
                
                self.present(imagePicker, animated: true, completion: nil)
            }
        case 1:
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .camera;
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true, completion: nil)
            }
        case 2:
            if !isRecording {
                isRecording = true
                saveBtn.setImage(UIImage(named: "stop_rec"), for: UIControlState.normal)
                let outputPath = NSTemporaryDirectory() + "output.mov"
                let outputFileURL = URL(fileURLWithPath: outputPath)
                videoFileOutput.startRecording(to: outputFileURL, recordingDelegate: self)
            } else {
                isRecording = false
                saveBtn.setImage(UIImage(named: "record"), for: UIControlState.normal)
                videoFileOutput.stopRecording()
            }
            
        default:
            break
        }
    }
    
    //pick from gallery
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismiss(animated: true, completion: { () -> Void in
            
        })
        
        imageView.image = image
    }
    
    //show taken picture
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imgView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        dismiss(animated:true, completion: nil)
    }
   
    @IBAction func savePic(_ sender: Any) {
        if let img =  imgView.image {
            UIImageWriteToSavedPhotosAlbum( img , nil, nil, nil)
        }
        
    }
    
    //Video
    func setUpSession() {
        var discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back)
        
        guard let captureDevice = discoverySession.devices.first else {
            print("Hittar inte kameran")
            return
        }
        
        discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInMicrophone], mediaType: AVMediaType.audio, position: .unspecified)
        
        guard let audioDevice = discoverySession.devices.first else {
            print("Hittar inte miccen")
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
        
        view.bringSubview(toFront:saveBtn)
        avSession.startRunning()
    }
    
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        guard error == nil else {
            print(error!)
            return
        }
    }
    
    @IBAction func currentAddress(_ sender: Any) {
        performSegue(withIdentifier: "toMap", sender: <#T##Any?#>)
    
        
    }
    
    
}
