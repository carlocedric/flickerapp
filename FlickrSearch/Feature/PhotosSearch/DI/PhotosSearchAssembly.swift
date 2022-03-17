//
//  PhotosSearchAssembly.swift
//  FlickrSearch
//
//  Created by Carlo Cedric Lijauco on 17/03/2022.
//

import Swinject
import SwinjectAutoregistration

class PhotosSearchAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(PhotosSearchViewModelContract.self,
                               initializer: PhotosSearchViewModel.init)
        container.autoregister(PhotosSearchInteractorContract.self,
                               initializer: PhotosSearchInteractor.init)
    }
}
