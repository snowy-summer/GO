//
//  ProgressPhotosRepository.swift
//  GO
//
//  Created by 최승범 on 4/20/25.
//

import Foundation
import UIKit

protocol ProgressPhotosRepositoryProtocol {
    func fetchAllProgressPhotos() -> [ProgressPhotos] // 날짜 순으로 내보내야함
    func fetchTodayProgressPhoto() -> ProgressPhotos // 오늘 사진 받아오기
    func updateProgressPhotos(_ photos: ProgressPhotosUIData) // 사진 업데이트 및 추가
}

final class MockProgressPhotosRepository: ProgressPhotosRepositoryProtocol {
    
    func fetchAllProgressPhotos() -> [ProgressPhotos] {
        let dateManager = DateManager.shared
        let mockData = UIImage(named: "test")?.pngData() ?? Data()
        let mockFrontImageData = ProgressPhotoImage(data: mockData, type: "front")
        let mockSideImageData = ProgressPhotoImage(data: mockData, type: "side")
        let mockPoseImageData = ProgressPhotoImage(data: mockData, type: "pose")
        
        return [
            ProgressPhotos(frontImageData: mockFrontImageData, sideImageData: mockSideImageData, poseImageData: mockPoseImageData, date: dateManager.getDate(from: "2025.04.13")),
            ProgressPhotos(frontImageData: nil, sideImageData: mockSideImageData, poseImageData: nil, date: dateManager.getDate(from: "2025.04.14")),
            ProgressPhotos(frontImageData: mockFrontImageData, sideImageData: nil, poseImageData: mockPoseImageData, date: dateManager.getDate(from: "2025.04.15")),
            ProgressPhotos(frontImageData: nil, sideImageData: nil, poseImageData: nil, date: dateManager.getDate(from: "2025.04.16")),
            ProgressPhotos(frontImageData: mockFrontImageData, sideImageData: mockSideImageData, poseImageData: nil, date: dateManager.getDate(from: "2025.04.17")),
            ProgressPhotos(frontImageData: mockFrontImageData, sideImageData: nil, poseImageData: nil, date: dateManager.getDate(from: "2025.04.18")),
            ProgressPhotos(frontImageData: nil, sideImageData: mockSideImageData, poseImageData: nil, date: dateManager.getDate(from: "2025.04.19")),
        ]
        
        
    }
    
    func fetchTodayProgressPhoto() -> ProgressPhotos {
        let dateManager = DateManager.shared
        let mockFrontImageData: ProgressPhotoImage = ProgressPhotoImage(data: Data(), type: "front")
        let mockSideImageData: ProgressPhotoImage = ProgressPhotoImage(data: Data(), type: "side")
        let mockPoseImageData: ProgressPhotoImage = ProgressPhotoImage(data: Data(), type: "pose")
        
        return ProgressPhotos(frontImageData: mockFrontImageData,
                              sideImageData: mockSideImageData,
                              poseImageData: mockPoseImageData,
                              date: dateManager.getDate(from: "2025.04.19"))
        
    }
    
    func updateProgressPhotos(_ photos: ProgressPhotosUIData) {
        
    }
    
}

