//
//  CodeReader.swift
//  AVFoundationQRcode
//
//  
//
//

import UIKit

protocol CodeReader {
    var videoPreview: CALayer {get}
    func startReading(completion: @escaping (CodeReadResult) -> Void)
    func stopReading()
}

enum CodeReadResult {
    typealias Elemento = String
    case success(Elemento)
    case failure(Error)
    
    enum Error: Swift.Error {
        case noCameraAvailable
    }
}
