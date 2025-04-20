//
//  ProgressPhotosUseCase.swift
//  GO
//
//  Created by 최승범 on 4/20/25.
//

import Foundation
import SwiftUI

protocol ProgressPhotosUseCaseProtocol {
    func fetchProgressPhotos() -> [ProgressPhotosUIData]
}

final class ProgressPhotosUseCase: ProgressPhotosUseCaseProtocol {
    private let progressPhotosRepository: ProgressPhotosRepositoryProtocol = MockProgressPhotosRepository()
    private let dateManager: DateManager = DateManager.shared
    private let userData: UserDefaultsManager = UserDefaultsManager.shared
    
    ///  눈바디 사진 받아오기
    func fetchProgressPhotos() -> [ProgressPhotosUIData] {
        let photos = progressPhotosRepository.fetchAllProgressPhotos()
        return convertToUIData(for: photos)
    }
    
    //TODO: - 변환 때문에 속도가 느려질듯?
    /// UI 데이터 변환
    private func convertToUIData(for photos: [ProgressPhotos]) -> [ProgressPhotosUIData] {
        
        var UIPhotos: [ProgressPhotosUIData] = []
        
        for data in photos {
            let frontImage = data.frontImageData?.data.toImage()
            let sideImage = data.sideImageData?.data.toImage()
            let poseImage = data.poseImageData?.data.toImage()
            
            let photo = ProgressPhotosUIData(frontProgressPhoto: frontImage,
                                             sideProgressPhoto: sideImage,
                                             poseProgressPhoto: poseImage,
                                            date: dateManager.getDateString(date: data.date, format: "yy.MM.dd"))
            UIPhotos.append(photo)
        }
        return UIPhotos
    }
    
}
