//
//  HealthViewModel.swift
//  GO
//
//  Created by 최승범 on 4/20/25.
//

import Foundation

protocol HealthViewModelProtocol: ViewModelAble {
    var showedViewType: HealthViewCategoryListType { get }
}


final class HealthViewModel: HealthViewModelProtocol {
    
    @Published var showedViewType: HealthViewCategoryListType = .dashboard
    
    enum Intent {
        case changeView(HealthViewCategoryListType)
    }
    
    func action(_ intent: Intent) {
        switch intent {
        case .changeView(let viewType):
            showedViewType = viewType
        }
    }
    
    
}
