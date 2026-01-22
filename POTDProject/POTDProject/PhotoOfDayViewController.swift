//
//  PhotoOfDayViewController.swift
//  POTDProject
//
//  Created by Dev3 on 22/1/2569 BE.
//

import UIKit

final class PhotoOfDayViewController: UIViewController {
    
    var presenter: PhotoOfDayPresenterProtocol!
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let listView = PhotoViewer()

    private lazy var selectDayButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle("เลือกวัน", for: .normal)
        btn.addTarget(self, action: #selector(actionSelect), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .gray
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 10
        return btn
    }()
    
    private lazy var lbWarnig: UILabel = {
        let lb = UILabel()
        lb.text = "กรุณาเลือกวันที่ต้องการ"
        lb.textColor = .red
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        presenter.viewDidLoad()
        listView.delegate = self
    }
    
    @objc func actionSelect(){
        presentMonthYearPicker { [weak self] year, month in
            print("เลือก:", month, year)
            self?.presenter.didSelect(month: month, year: year)
        }
    }
    
    func setupIndicator() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
    }
    
    private func setupUI() {
        setupIndicator()
        view.addSubview(listView)
        view.addSubview(selectDayButton)
        view.addSubview(lbWarnig)
        view.bringSubviewToFront(activityIndicator)
        
        listView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            listView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            listView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            listView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            selectDayButton.topAnchor.constraint(equalTo: listView.bottomAnchor, constant: 20),
            selectDayButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            selectDayButton.widthAnchor.constraint(equalToConstant: 120),
            selectDayButton.heightAnchor.constraint(equalToConstant: 35),
            selectDayButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            lbWarnig.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lbWarnig.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            lbWarnig.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            lbWarnig.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
    
    private func presentMonthYearPicker(
        initialYear: Int? = nil,
        initialMonth: Int? = nil,
        onSelect: @escaping (_ year: Int, _ month: Int) -> Void
    ) {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.locale = Locale(identifier: "th_TH")
        picker.calendar = Calendar(identifier: .gregorian)

        // ตั้งค่าเริ่มต้น
        if let year = initialYear, let month = initialMonth {
            let gregorianYear = year > 2500 ? year - 543 : year
            var components = DateComponents()
            components.year = gregorianYear
            components.month = month
            components.day = 1

            if let date = Calendar.current.date(from: components) {
                picker.date = date
            }
        }

        let alert = UIAlertController(title: "เลือกเดือน / ปี", message: "\n\n\n\n\n\n\n\n\n", preferredStyle: .actionSheet)
        alert.view.addSubview(picker)

        picker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            picker.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor),
            picker.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 20)
        ])

        alert.addAction(UIAlertAction(title: "ยกเลิก", style: .cancel))
        alert.addAction(UIAlertAction(title: "ตกลง", style: .default, handler: { _ in
            let calendar = Calendar(identifier: .gregorian)
            let comps = calendar.dateComponents([.year, .month], from: picker.date)

            guard let year = comps.year, let month = comps.month else { return }

            // แปลงกลับเป็น พ.ศ. เพื่อแสดงผล
            let buddhistYear = year + 543
            onSelect(buddhistYear, month)
        }))

        present(alert, animated: true)
    }
}

extension PhotoOfDayViewController: PhotoOfDayViewProtocol {
    
    func showLoading() {
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        self.activityIndicator.stopAnimating()
    }
    
    func showPhotos(_ items: [APODItem]) {
        listView.update(items: items)
    }
    
    func showError(_ message: String) {
        GlobalAlert.show(message: message)
    }
}

extension PhotoOfDayViewController: PhotoViewerDelegate {
    func isEmpty(empty: Bool) {
        self.lbWarnig.isHidden = !empty
    }
    
    func didSelect(item: APODItem) {
        presenter.didSelectWatchDetail(item: item)
    }
}
