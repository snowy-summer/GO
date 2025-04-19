//
//  ProgressPhotosViewModel.swift
//  GO
//
//  Created by 최승범 on 4/20/25.
//

import SwiftUI

protocol ProgressPhotosViewModelProtocol: ViewModelAble {
    var photos: [ProgressPhotosUIData] { get }
    var selectedIndex: Int { get }
    var firstPhoto: Image? { get }
    var day: String { get }
}

final class ProgressPhotosViewModel: ProgressPhotosViewModelProtocol {
    
    @Published var photos: [ProgressPhotosUIData] = []
    @Published var selectedIndex: Int = 0
    var firstPhoto: Image? {
        photos.first?.frontProgressPhoto
    }
    
    var day: String {
        photos.indices.contains(selectedIndex) ? photos[selectedIndex].date : ""
    }
    
    private let progressPhotosUseCase: ProgressPhotosUseCaseProtocol
    
    enum Intent {
        case fetchPhotos
        case changeIndex(Int)
        case nextPage
        case previousPage
    }
    
    init(progressPhotosUseCase: ProgressPhotosUseCaseProtocol = ProgressPhotosUseCase()) {
        self.progressPhotosUseCase = progressPhotosUseCase
    }
    
    func action(_ intent: Intent) {
        switch intent {
        case .fetchPhotos:
            photos = progressPhotosUseCase.fetchProgressPhotos()
            selectedIndex = max(photos.count - 1, 0)
            
        case .changeIndex(let index):
            selectedIndex = index
            
        case .nextPage:
            selectedIndex = min(selectedIndex + 1, photos.count - 1)
            
        case .previousPage:
            selectedIndex = max(selectedIndex - 1, 0)
        }
    }
}
