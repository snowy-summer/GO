//
//  VitalDetailViewModel.swift
//  GO
//
//  Created by 최승범 on 4/28/25.
//

import Foundation

protocol VitalDetailViewModelProtocol: ViewModelAble {
    var selectedType: VitalInformationType { get }
}

final class VitalDetailViewModel: VitalDetailViewModelProtocol {
    
    @Published var selectedType: VitalInformationType = .steps
    
    @Published var duration: String = ""
    
    @Published var isAnimating: Bool = false
    
    private let stepsChartUseCase: StepsChartUseCaseProtocol
    
    enum Intent {
        case fetchAllData
        case select(VitalInformationType)
    }
    
    init(stepsChartUseCase: StepsChartUseCaseProtocol = StepsChartUseCase()) {
        self.stepsChartUseCase = stepsChartUseCase
    }
    
    func action(_ intent: Intent) {
        switch intent {
        case .fetchAllData:
            return
            
        case .select(let type):
            selectedType = type
        }
    }
    
}

extension VitalDetailViewModel {
    
    /// 오늘 데이터의  rawValue만 추출하는 공통 함수
    private func extractTodayValue<T>(from list: [T]) -> T.RawValue where T: HasTodayValue {
        return list.first(where: { $0.isToday })?.rawValue ?? T.zeroValue
    }

    private func getDateRange() {
        duration = stepsChartUseCase.getDateRange()
    }
    
}
