//
//  BarcodeViewController.swift
//  BarCodeReader
//
//  Created by Kakha Sepashvili on 2/27/22.
//

import UIKit
import AVFoundation


class BarcodeViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var barcodeText: String = ""
    let captureSession =  AVCaptureSession()
    let frameImage = UIImageView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Camera mode"
        UINavigationBar.appearance().tintColor  = .white
        let barImage = UIImage(systemName: "xmark")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: barImage , style: .plain, target: self, action: #selector(backButton))
        frameImage.frame = CGRect(x: UIScreen.main.bounds.width / 4, y: UIScreen.main.bounds.height / 2.5, width: 200, height: 150)
        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera ,for: .video, position: .back) else {
            return }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(input)
        }
        catch {
            print("error")
        }
       
    
        
        let output = AVCaptureMetadataOutput()
    
        captureSession.addOutput(output)
        output.setMetadataObjectsDelegate(self, queue:  DispatchQueue.main)
        output.metadataObjectTypes = [.ean8, .ean13, .pdf417]
        let videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer)
        frameImage.image = UIImage(named: "BarcodeAim")
        view.addSubview(frameImage)
        
        captureSession.startRunning()
      
    }

    
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject {
                if object.type == .ean8 || object.type == .ean13 || object.type == .pdf417 {
                    barcodeText = object.stringValue ?? ""
                    captureSession.stopRunning()
                    let vc = ViewController()
                    if self.barcodeText.contains("460") {
                        vc.resultText.text = "🇷🇺 RUSSIA"
                        vc.resultText.textColor = .red
                    } else if self.barcodeText.contains("486") {
                        vc.result = "🇬🇪 GEORGIA"
                    } else if self.barcodeText.contains("482") {
                        vc.result = "🇺🇦 UKRAINE"
                    } else if (100...139).map({String($0)}).contains(where: {barcodeText.contains($0)}) {
                        print("Im here")
                        vc.result = "🇺🇸 USA"
                    } else if (300...379).map({String($0)}).contains(where: {barcodeText.contains($0)}) {
                        print("Im here")
                        vc.result = "🇫🇷 FRANCE"
                    } else if self.barcodeText.contains("380") {
                        vc.result = "🇧🇬 BULGARIA"
                    } else if self.barcodeText.contains("485") {
                        vc.result = "🇦🇲 ARMENIA"
                    } else if self.barcodeText.contains("481") {
                        vc.result = "🇧🇾 BELARUS"
                    } else if self.barcodeText.contains("590") {
                        vc.result = "🇵🇱 POLAND"
                    }  else if self.barcodeText.contains("629") {
                        vc.result = "🇦🇪 UAE"
                    } else if (690...699).map({String($0)}).contains(where: {barcodeText.contains($0)}) {
                        vc.result = ""
                    }  else if self.barcodeText.contains("868") || self.barcodeText.contains("869") {
                        vc.result = "🇹🇷 TURKEY"
                    }
                    vc.modalPresentationStyle = .fullScreen
                    present(vc, animated: false)
                }
            }
        
    }
    @objc func backButton() {
        self.dismiss(animated: false)
    }


}
