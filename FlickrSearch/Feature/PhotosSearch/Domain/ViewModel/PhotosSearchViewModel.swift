//
//  PhotosSearchViewModel.swift
//  FlickrSearch
//
//  Created by Carlo Cedric Lijauco on 17/03/2022.
//

class PhotosSearchViewModel: PhotosSearchViewModelContract {
    
    private let photosSearchInteractor: PhotosSearchInteractorContract
    
    init(photosSearchInteractor: PhotosSearchInteractorContract){
        self.photosSearchInteractor = photosSearchInteractor
    }
    
    func getPhotosFromFlicker(searchString: String, onCompletion: @escaping([PhotoModel])->()) {
        photosSearchInteractor.getPhotosFromFlicker(searchString: searchString) { photos in
            onCompletion(photos?.photos?.photo ?? [])
        }
    }
}
