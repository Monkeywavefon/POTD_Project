//
//  PhotoOfDayInteractor.swift
//  POTDProject
//
//  Created by Dev3 on 22/1/2569 BE.
//
import Foundation
final class PhotoOfDayInteractor {
    
    weak var output: PhotoOfDayInteractorOutputProtocol?
    private let apiService: NASAAPIServiceProtocol
    
    init(apiService: NASAAPIServiceProtocol = NASAAPIService()) {
        self.apiService = apiService
    }
    
}

extension PhotoOfDayInteractor: PhotoOfDayInteractorProtocol {
    
    func fetchPhotos(month: Int, year: Int) {

        let start = DateHelper.startOfMonth(month: month, year: year)
        let end   = DateHelper.endOfMonth(month: month, year: year)

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        print(formatter.string(from: start))
        print(formatter.string(from: end))

        apiService.fetchAPOD(startDate: start, endDate: end) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let items):
                    self?.output?.fetchSuccess(items: items)
                case .failure(let error):
                    self?.output?.fetchFailure(error: error)
                }
            }
        }
    }
}
