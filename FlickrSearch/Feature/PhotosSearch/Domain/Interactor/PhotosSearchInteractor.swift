//
//  PhotosSearchInteractor.swift
//  FlickrSearch
//
//  Created by Carlo Cedric Lijauco on 17/03/2022.
//
import Foundation

class PhotosSearchInteractor: PhotosSearchInteractorContract {
    
    func getPhotosFromFlicker(searchString: String, onCompletion: @escaping(FlickerMainResponse?)->()){
        guard let urlString = URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=96358825614a5d3b1a1c3fd87fca2b47&text=\(searchString)&format=json&nojsoncallback=1") else { return }
        URLSession.shared.dataTask(with: urlString) { data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let flickrResponse = try decoder.decode(FlickerMainResponse.self, from: data)
                debugPrint(flickrResponse)
                onCompletion(flickrResponse)
            } catch let err {
                print("Error", err)
            }
        }.resume()
    }
}
