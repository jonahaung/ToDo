//
//  Extensions.swift
//  ToDo
//
//  Created by Aung Ko Min on 16/4/20.
//  Copyright © 2020 Aung Ko Min. All rights reserved.
//

import UIKit

extension UIViewController {
    
    
    func showError(title: String, message: String) {
        // same thing, we create an alert controller to display error
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // OK action (or) Done action
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
        // This function can be called from anywhere within any viewController
    }
}
