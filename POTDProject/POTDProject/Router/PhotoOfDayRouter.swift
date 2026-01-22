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
}
