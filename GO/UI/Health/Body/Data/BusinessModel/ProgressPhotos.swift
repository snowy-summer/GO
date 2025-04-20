//
//  ProgressPhotos.swift
//  GO
//
//  Created by 최승범 on 4/20/25.
//

import Foundation

struct ProgressPhotos: Codable {
    let frontImageData: ProgressPhotoImage?
    let sideImageData: ProgressPhotoImage?
    let poseImageData: ProgressPhotoImage?
    let date: Date
    
}

struct ProgressPhotoImage: Codable {
    let data: Data
    let type: String
}
