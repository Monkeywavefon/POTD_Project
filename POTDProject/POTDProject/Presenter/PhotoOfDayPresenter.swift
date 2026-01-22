//
//  PhotoOfDayPresenter.swift
//  POTDProject
//
//  Created by Dev3 on 22/1/2569 BE.
//

import Foundation

final class PhotoOfDayPresenter {
    
    weak var view: PhotoOfDayViewProtocol?
    var interactor: PhotoOfDayInteractorProtocol?
    var router: PhotoOfDayRouterProtocol?
}

extension PhotoOfDayPresenter: PhotoOfDayPresenterProtocol {
    
    func viewDidLoad() {
        let current = Date()
        let month = Calendar.current.component(.month, from: current)
        let year = Calendar.current.component(.year, from: current)
        didSelect(month: month, year: year)
    }
    
    func didSelect(month: Int, year: Int) {
        view?.showLoading()
        interactor?.fetchPhotos(month: month, year: year)
    }
}

extension PhotoOfDayPresenter: PhotoOfDayInteractorOutputProtocol {
    
    func fetchSuccess(items: [APODItem]) {
        view?.hideLoading()
        view?.showPhotos(items)
    }
    
    func fetchFailure(error: Error) {
        view?.hideLoading()
        view?.showError(error.localizedDescription)
    }
}
