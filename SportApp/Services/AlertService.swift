//
//  AlertService.swift
//  SportApp
//
//  Created by Кирилл Бахаровский on 11/10/24.
//

import UIKit

class AlertService {
    
    static let shared = AlertService()
    private init() {}
    
    // MARK: - Алерт с тайтлом и текстом
    func showAlert(title: String, message: String, on viewController: UIViewController, completion: (() -> Void)? = nil) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                completion?()
            }
            alertController.addAction(okAction)
            viewController.present(alertController, animated: true)
        }
}
