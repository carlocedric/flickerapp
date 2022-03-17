//
//  PhotoModel.swift
//  FlickrSearch
//
//  Created by Carlo Cedric Lijauco on 17/03/2022.
//

struct FlickerMainResponse: Codable {
    let photos: FlickerResponse?
    let stat: String?
}

struct FlickerResponse: Codable {
    let page: Int?
    let pages: Int?
    let perpage: Int?
    let total: Int?
    let photo: [PhotoModel]?
}

struct PhotoModel: Codable {
    let id: String?
    let owner: String?
    let secret: String?
    let server: String?
    let farm: Int?
    let title: String?
    let ispublic: Int?
    let isfriend: Int?
    let isfamily: Int?
}
