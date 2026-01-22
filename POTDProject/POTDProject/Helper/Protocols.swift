//
//  Protocols.swift
//  POTDProject
//
//  Created by Dev3 on 22/1/2569 BE.
//

import UIKit

// MARK: - View
protocol PhotoOfDayViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func showPhotos(_ items: [APODItem])
    func showError(_ message: String)
}

// MARK: - Presenter
protocol PhotoOfDayPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didSelect(month: Int, year: Int)
}

// MARK: - Interactor
protocol PhotoOfDayInteractorProtocol: AnyObject {
    func fetchPhotos(month: Int, year: Int)
}

// MARK: - Interactor Output
protocol PhotoOfDayInteractorOutputProtocol: AnyObject {
    func fetchSuccess(items: [APODItem])
    func fetchFailure(error: Error)
}

// MARK: - Router
protocol PhotoOfDayRouterProtocol {
    static func createModule() -> UIViewController
}

protocol NASAAPIServiceProtocol {
    func fetchAPOD(
        startDate: Date,
        endDate: Date,
        completion: @escaping (Result<[APODItem], Error>) -> Void
    )
}
