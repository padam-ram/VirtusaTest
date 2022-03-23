//
//  Extensions.swift
//  VirtusaTest
//
//  Created by Apple on 17/03/22.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

extension UINavigationController {

    func setStatusBar(backgroundColor: UIColor) {
        let statusBarFrame: CGRect
        if #available(iOS 13.0, *) {
            
            statusBarFrame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        } else {
            statusBarFrame = UIApplication.shared.statusBarFrame
        }
        let statusBarView = UIView(frame: statusBarFrame)
        statusBarView.backgroundColor = backgroundColor
        view.addSubview(statusBarView)
    }

}

extension UIViewController {
    
    func lodingindicator(){
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    func hideindicator(){
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.dismiss(animated: false, completion: nil)
        }
    }
}

extension UIImageView {
 
    func downloadImage(urlString: String, success: ((_ image: UIImage?) -> Void)? = nil, failure: ((String) -> Void)? = nil) {
        
        let imageCache = NSCache<NSString, UIImage>()

        DispatchQueue.main.async {[weak self] in
            self?.image = nil
        }
        
        if let image = imageCache.object(forKey: urlString as NSString) {
            DispatchQueue.main.async {[weak self] in
                self?.image = image
            }
            success?(image)
        } else {
            guard let url = URL(string: urlString) else {
                print("failed to create url")
                return
            }
            
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
                
                // response received, now switch back to main queue
                DispatchQueue.main.async {[weak self] in
                    if let error = error {
                        failure?(error.localizedDescription)
                    }
                    else if let data = data, let image = UIImage(data: data) {
                        imageCache.setObject(image, forKey: url.absoluteString as NSString)
                        self?.image = image
                        success?(image)
                    } else {
                        failure?("Image not available")
                    }
                }
            }
            
            task.resume()
        }
    }
}
