//
//  PhotosSearchViewController.swift
//  FlickrSearch
//
//  Created by Carlo Cedric Lijauco on 17/03/2022.
//

import RxSwift
import RxCocoa
import UIKit

class PhotosSearchViewController: UIViewController {
    @IBOutlet var searchField: UITextField!
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    private let disposeBag = DisposeBag()
    private var viewModel: PhotosSearchViewModelContract?
    private var responsePhotos: [PhotoModel]?
    
    private let inset: CGFloat = 0
    private let minimumLineSpacing: CGFloat = 0
    private let minimumInteritemSpacing: CGFloat = 0
    private let cellsPerRow = 3
    
    init(viewModel: PhotosSearchViewModelContract) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel;
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        photosCollectionView.register(UINib(nibName: PhotoCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        photosCollectionView.dataSource = self
        photosCollectionView.delegate = self
        photosCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        photosCollectionView?.contentInsetAdjustmentBehavior = .always
        setupTextFieldObserver()
    }
    
    private func setupTextFieldObserver(){
        searchField.rx.text.orEmpty
            .distinctUntilChanged()
            .throttle(.milliseconds(1000), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] changedText in
                self?.viewModel?.getPhotosFromFlicker(searchString: changedText,
                                                onCompletion: { [weak self] photos in
                    self?.responsePhotos = photos
                    DispatchQueue.main.async {
                        self?.photosCollectionView.reloadData()
                    }
                })
            })
            .disposed(by: disposeBag)
    }
}

extension PhotosSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return responsePhotos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        if let photo = responsePhotos?[indexPath.row] {
            cell.setup(with: photo)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
       }

       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return minimumLineSpacing
       }

       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
           return minimumInteritemSpacing
       }

       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let marginsAndInsets = inset * 2 + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
           let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
           return CGSize(width: itemWidth, height: itemWidth)
       }
}
