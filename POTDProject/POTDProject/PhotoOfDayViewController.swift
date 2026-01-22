//
//  PhotoOfDayViewController.swift
//  POTDProject
//
//  Created by Dev3 on 22/1/2569 BE.
//

import UIKit

final class PhotoOfDayViewController: UIViewController {
    
    var presenter: PhotoOfDayPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    @objc func monthYearChanged(month: Int, year: Int) {
        presenter.didSelect(month: month, year: year)
    }
}

extension PhotoOfDayViewController: PhotoOfDayViewProtocol {
    
    func showLoading() {
        // show spinner
    }
    
    func hideLoading() {
        // hide spinner
    }
    
    func showPhotos(_ items: [APODItem]) {
        // reload table / collection view
    }
    
    func showError(_ message: String) {
        // alert
    }
}

