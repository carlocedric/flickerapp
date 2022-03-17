//
//  PhotosSearchRouter.swift
//  FlickrSearch
//
//  Created by Carlo Cedric Lijauco on 17/03/2022.
//

import Swinject

class PhotosSearchRouter: BaseRouter {
    
    private let photosSearchAssembler = Assembler([PhotosSearchAssembly()]);
    
    override func start() {
        if let photosSearchViewModel = photosSearchAssembler.resolver.resolve(PhotosSearchViewModelContract.self) {
            let photosSearchViewController = PhotosSearchViewController(viewModel: photosSearchViewModel)
            show(photosSearchViewController)
        }
    }
}
