//
//  GOApp.swift
//  GO
//
//  Created by 최승범 on 4/14/25.
//

import SwiftUI

@main
struct GOApp: App {
    
    private let healthService = HealthInformationManager()
    
    var body: some Scene {
        WindowGroup {
            HealthView()
        }
    }
    
    init() {
        setup()
    }
    
    // 첫 실행 시 Healthkit 권한 설정이 되도록 호출합니다.
    private func setup() {
        healthService.configure()
    }
}
