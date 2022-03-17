//
//  PhotosSearchInteractorContract.swift
//  FlickrSearch
//
//  Created by Carlo Cedric Lijauco on 17/03/2022.
//

protocol PhotosSearchInteractorContract {
    func getPhotosFromFlicker(searchString: String, onCompletion: @escaping(FlickerMainResponse?)->())
}

