//
//  ViewController.swift
//  QR
//
//  Created by Joana on 04/03/2019.
//  Copyright © 2019 Joana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var previewView: UIView!
    
    var sendURL: String!
    var codeReader: CodeReader = AVCodeReader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let previewLayer = codeReader.videoPreview
        previewLayer.frame = previewView.bounds
        previewView.layer.addSublayer(previewLayer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.startReading), name:UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.stopReading), name:UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.startReading()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.stopReading()
    }
    
    @objc func startReading(){
        codeReader.startReading(completion: didOutput)
    }
    @objc func stopReading(){
        codeReader.stopReading()
    }
    
    private func didOutput(result: CodeReadResult) {
        switch result {
        case .success(let elemento):
            print(elemento)
            
            let alert = UIAlertController(title: "QR", message: elemento, preferredStyle: UIAlertController.Style.alert)
            let action = UIAlertAction(title: "Got it", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: false, completion: nil)
            
            sendURL = elemento
        case .failure:
            showNotAvailableCameraError()
        }
    }
    
    private func showNotAvailableCameraError() {
        let alert = UIAlertController(title: "Camera required", message: "This device has no camera. Is this an iOS Simulator?", preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Got it", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: false, completion: nil)
    }


}

