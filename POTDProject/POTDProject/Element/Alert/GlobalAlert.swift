//
//  GlobalAlert.swift
//  POTDProject
//
//  Created by Dev3 on 22/1/2569 BE.
//

import UIKit

final class GlobalAlert {

    static func show(
        title: String = "แจ้งเตือน",
        message: String,
        buttonTitle: String = "ตกลง",
        handler: (() -> Void)? = nil
    ) {
        DispatchQueue.main.async {
            guard let topVC = UIApplication.topViewController() else { return }

            let alert = UIAlertController(
                title: title,
                message: message,
                preferredStyle: .alert
            )

            alert.addAction(UIAlertAction(title: buttonTitle, style: .default) { _ in
                handler?()
            })

            topVC.present(alert, animated: true)
        }
    }
}
