//
//  UIViewController+Alert.swift
//  English is simple
//
//  Created by Руслан on 28.11.2021.
//

import UIKit

extension UIViewController {

    func showConfirmationAlert(title: String?, description: String?, completion: @escaping (UIAlertAction) -> Void) {
        let alertController = UIAlertController(title: title,
                                                message: description,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel",
                                                style: .cancel,
                                                handler: nil))
        alertController.addAction(UIAlertAction(title: "Confirm",
                                                style: .default,
                                                handler: { alertAction in
            completion(alertAction)
        }))

        present(alertController, animated: true, completion: nil)
    }

}
