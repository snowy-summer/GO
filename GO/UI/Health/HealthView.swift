//
//  HealthView.swift
//  GO
//
//  Created by 최승범 on 4/14/25.
//

import SwiftUI

struct HealthView: View {
    
    @StateObject var viewModel: HealthViewModel = HealthViewModel()
    
    var body: some View {
        HStack {
            VStack(spacing: 20) {
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: 48, height: 48)
                
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: 48, height: 48)
                Spacer()
            }
            .padding(.horizontal)
            
            Rectangle()
                .fill(.black)
                .frame(width: 2)
                .ignoresSafeArea()
            Spacer()
            
            VStack {
                HStack {
                    Circle()
                        .frame(width: 60, height: 60)
                        .padding(.leading, 16)
                    Text("Mela")
                        .appFont(.titleBold24)
                    Spacer()
                    HStack(spacing: 16) {
                        Circle()
                            .fill(.white)
                            .overlay {
                                Image(systemName: "bell")
                            }
                            .frame(width: 40)
                        Circle()
                            .fill(.white)
                            .overlay {
                                Image(systemName: "gearshape")
                            }
                            .frame(width: 40)
                    }
                    .padding(.horizontal)
                }
                HStack {
                    List(HealthViewCategoryListType.allCases, id: \.self) { type in
                        ImageText(imageTextData: type.data)
                            .appFont(.bodyRegular16)
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            .onTapGesture {
                                viewModel.action(.changeView(type))
                            }
                            
                    }
                    .listStyle(.plain)
                    .frame(width: 200)
                    .frame(maxHeight: .infinity)
                    NavigationStack {
                        switch viewModel.showedViewType {
                        case .dashboard:
                            HealthDashboardView()
                                .background(.back)
                        case .bodyInformation:
                            WeightDetailView()
                                .background(.back)
                        case .calories:
                            FoodCaloriesDetailView()
                                .background(.back)
                        case .workouts:
                            WeightDetailView()
                                .background(.back)
                        case .vitalInformation:
                            VitalDetailView()
                                .background(.back)
                        }
                    }
                    
                }
            }
        }
        .background(.back)
        
    }
}

struct PreviewWrapper_previews: PreviewProvider {
    static let devices = ["iPad Pro 13-inch (M4)",
                          "iPad Pro 11-inch (M4)",
                          "iPad mini (A17 Pro)"]

    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            HealthView()
                .previewDevice(PreviewDevice(rawValue: device)) // 프리뷰 디바이스 설정
                .previewDisplayName(device) // 프리뷰 이름 설정
        }
    }
}
