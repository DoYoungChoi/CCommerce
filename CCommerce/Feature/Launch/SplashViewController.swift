//
//  SplashViewController.swift
//  CCommerce
//
//  Created by dodor on 12/22/23.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {
    
    @IBOutlet weak var lottieAnimationView: LottieAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        lottieAnimationView.play { _ in
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            let viewController = storyboard.instantiateInitialViewController()
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first(where: { $0.isKeyWindow }) {
                window.rootViewController = viewController
            }
//            self?.present(HomeViewController(), animated: true)
        }
        
        /*
        appIconCenterXConstraint.constant = -(view.frame.width / 2) - (appIcon.frame.width / 2)
        appIconCenterYConstraint.constant = -(view.frame.height / 2) - (appIcon.frame.height / 2)
        
        UIView.animate(withDuration: 1) { [weak self] in
            self?.view.layoutIfNeeded()
        }
        
        UIView.animate(withDuration: 2) { [weak self] in
            let rotationAngle: CGFloat = CGFloat.pi
            self?.appIcon.transform = CGAffineTransform(rotationAngle: rotationAngle)
        }
         */
    }
}
