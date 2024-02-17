//
//  ViewController.swift
//  Amoun-Scanner
//
//  Created by Sherif Samy on 06/06/2023.
//

import AVFoundation
import UIKit
import SwiftQRScanner
import WebKit

class CameraScannerViewController: UIViewController {
    
     //MARK: - Outlets

    
    @IBOutlet weak var resultQrCode: UILabel!
    
        //MARK: - variables
    
    // configueration is to make changes in QR Scanner
    
    var configuration = QRScannerConfiguration()
    var url = "https://drive.google.com/file/d/1uvP983sqBko0DT8AbIAmSLFYZckdeYvL/view?usp=sharing"
    
    //MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        resultQrCode.text = ""
    }
    
    //MARK: - IBActions

        
   
    @IBAction func qrScannerStartButon(_ sender: UIButton) {
        
        configuration.hint = "Align QR code within frame to scan"
        configuration.readQRFromPhotos =  false
        let scanner = QRCodeScannerController(qrScannerConfiguration: configuration)
        self.present(scanner, animated: true, completion: nil)
        scanner.delegate = self
        
        
    }
    
}

    //MARK: - Extension for Camera QR Scanner Code Delegate

extension CameraScannerViewController: QRScannerCodeDelegate {
    func qrScannerDidFail(_ controller: UIViewController, error: QRCodeError) {
        print("error:\(error.localizedDescription)")
    }
    
    func qrScanner(_ controller: UIViewController, scanDidComplete result: String) {
        print("result:\(result)")
        
        DispatchQueue.main.async {
            self.resultQrCode.text =  result
        }
       
    }
    
    func qrScannerDidCancel(_ controller: UIViewController) {
        print("SwiftQRScanner did cancel")
    }
}



