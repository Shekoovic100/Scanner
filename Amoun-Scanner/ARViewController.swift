//
//  ARViewController.swift
//  Amoun-Scanner
//
//  Created by Sherif Samy on 06/06/2023.
//

import UIKit
import RealityKit
import ARKit

class ARViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var arView: ARView!
  
    
    //MARK: - variables
    
    var url = "https://drive.google.com/file/d/1uvP983sqBko0DT8AbIAmSLFYZckdeYvL/view?usp=sharing"
    var redirectionOccurred = false
    //MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arView.session.delegate = self
        startImageTracking()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startImageTracking()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }


    //MARK: - Helper Functions
    
    func startImageTracking()  {

        guard let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "AR_Resources", bundle: Bundle.main) else {
            print("Image not available, Import One!")
            return
        }
        guard let arview =  arView else {return}
        let configration = ARImageTrackingConfiguration()
        configration.trackingImages = imageToTrack
        configration.maximumNumberOfTrackedImages = 1
        arview.session.run(configration)
    }
    

}

//MARK: - Extension for AR SessionDelegate

extension ARViewController: ARSessionDelegate{
    
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        
        if anchors.count > 0{
            for anchor in anchors {
                if let imageAnchor = anchor as? ARImageAnchor, let name = imageAnchor.referenceImage.name {
                    if name == "Concor5Plus 1" || name == "IMG_0193"{
                        
                        guard !redirectionOccurred else {
                            return
                        }
                        redirectionOccurred = true
                        guard let url = URL(string: url) else {return}
                        UIApplication.shared.open(url)
                        DispatchQueue.main.async {
                        guard let tabbarVC = self.storyboard?.instantiateViewController(withIdentifier: "TabbarVc") as? UITabBarController else {return}
                            UIApplication.shared.windows.first?.rootViewController =  tabbarVC
                        }
                        break
                    }else{
                        for arViewAnchor in arView.scene.anchors {
                            arView.scene.removeAnchor(arViewAnchor)
                        }
                    }
                }
            }
        }
    }
    
}
