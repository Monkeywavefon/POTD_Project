//
//  PhotoOfDayRouter.swift
//  POTDProject
//
//  Created by Dev3 on 22/1/2569 BE.
//
import UIKit

final class PhotoOfDayRouter: PhotoOfDayRouterProtocol {
    
    static func createModule() -> UIViewController {
        let view = PhotoOfDayViewController()
        let presenter = PhotoOfDayPresenter()
        let interactor = PhotoOfDayInteractor()
        let router = PhotoOfDayRouter()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.output = presenter
        
        return view
    }
    
    func navigateToDetail(from view: PhotoOfDayViewProtocol?, item: APODItem) {
        guard let vc = view as? UIViewController else { return }

        let detailVC = PhotoDetailViewController(item: item)
        vc.navigationController?.pushViewController(detailVC, animated: true)
    }
}
