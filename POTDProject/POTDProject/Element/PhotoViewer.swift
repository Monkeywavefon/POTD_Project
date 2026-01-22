//
//  PhotoViewer.swift
//  POTDProject
//
//  Created by Dev3 on 22/1/2569 BE.
//

import UIKit
protocol PhotoViewerDelegate: AnyObject {
    func didSelect(item: APODItem)
    func isEmpty(empty: Bool)
}
final class PhotoViewer: UIView {
    weak var delegate: PhotoViewerDelegate?

    private var items: [APODItem] = []

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.dataSource = self
        cv.delegate = self
        cv.register(APODCell.self, forCellWithReuseIdentifier: APODCell.identifier)
        return cv
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        backgroundColor = .lightGray
        clipsToBounds = true
        layer.cornerRadius = 20
        
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    // MARK: - Public API

    func update(items: [APODItem]) {
        self.items = items.sorted { $0.date > $1.date }
        delegate?.isEmpty(empty: self.items.isEmpty)
        collectionView.reloadData()
    }
}

extension PhotoViewer: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: APODCell.identifier,
            for: indexPath
        ) as! APODCell

        cell.configure(with: items[indexPath.item])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelect(item: items[indexPath.item])
    }
}

extension PhotoViewer: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {

        let width = collectionView.bounds.width - 24
        return CGSize(width: width, height: 240)
    }
}
