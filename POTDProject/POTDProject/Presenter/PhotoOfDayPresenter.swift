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
        self.router = PhotoOfDayRouter.init()
    }
    
    func didSelect(month: Int, year: Int) {
        view?.showLoading()
        interactor?.fetchPhotos(month: month, year: year)
    }
    
    func didSelectWatchDetail(item: APODItem) {
        router?.navigateToDetail(from: view, item: item)
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
