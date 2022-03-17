//
//  PhotosSearchViewModelContract.swift
//  FlickrSearch
//
//  Created by Carlo Cedric Lijauco on 17/03/2022.
//

protocol PhotosSearchViewModelContract {
    func getPhotosFromFlicker(searchString: String, onCompletion: @escaping([PhotoModel])->())
}
