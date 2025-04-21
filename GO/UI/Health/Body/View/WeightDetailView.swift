//
//  WeightDetailView.swift
//  GO
//
//  Created by 최승범 on 4/17/25.
//

import SwiftUI

struct WeightDetailView: View {
    
    @StateObject private var viewModel: WeightDetailViewModel = WeightDetailViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            ScrollView {
                VStack(spacing: 20) {
                    BodyStateView(width: width,
                                  height: height,
                                  viewModel: viewModel)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    BodyCompositionView(height: height,
                                        isExpanded: $viewModel.isExpanded)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    ProgressPhotosView(width: width)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                }
            }
            .padding(.horizontal, 20)
        }
    }
    
    private struct BodyStateView: View {
        let width: CGFloat
        let height: CGFloat
        @ObservedObject var viewModel: WeightDetailViewModel
        
        var body: some View {
            VStack {
                HStack(spacing: width * 0.02) {
                    Image(.test)
                        .resizable()
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .frame(maxWidth: width * 0.2)
                        .frame(height: width * 0.24)
                    
                    VStack {
                        HStack {
                            Text("몸 상태 요약")
                                .appFont(.sectionTitleBold28)
                            Spacer()
                            
                            Text(viewModel.day)
                                .appFont(.emphasisSemiBold16)
                                .foregroundStyle(.gray)
                        }
                        Spacer()
                        
                        HStack(spacing: width * 0.02) {
                            BodyComponentCardView(
                                width: width,
                                title: "Weight (kg)",
                                value: viewModel.recentWeight,
                                bodyState: viewModel.recentWeightState
                            )
                            
                            BodyComponentCardView(
                                width: width,
                                title: "Muscle (kg)",
                                value: viewModel.recentMuscleMass,
                                bodyState: viewModel.recentMuscleMassState
                            )
                            
                            BodyComponentCardView(
                                width: width,
                                title: "Fat (%)",
                                value: viewModel.recentBodyFatPercent,
                                bodyState: viewModel.recentBodyFatState
                            )
                            
                            VStack {
                                Text("Add Record")
                                    .appFont(.primaryButtonSemiBold16)
                                    .frame(maxWidth: .infinity)
                                    .frame(maxHeight: .infinity)
                                    .padding()
                                    .padding(.horizontal)
                                    .background(.gray.opacity(0.4))
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                
                                Text("Edit Record")
                                    .appFont(.primaryButtonSemiBold16)
                                    .frame(maxWidth: .infinity)
                                    .frame(maxHeight: .infinity)
                                    .padding()
                                    .padding(.horizontal)
                                    .background(.gray.opacity(0.4))
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                            }
                            .frame(height: width * 0.15)
                            
                        }
                    }
                    
                }
                .padding()
                
                WeightChartCardView()
                    .frame(maxWidth: .infinity)
                    .frame(height: height * 0.5)
            }
            .padding()
            .onAppear {
                viewModel.action(.fetchData)
            }
        }
    }
    
    private struct BodyComponentCardView: View {
        let width: CGFloat
        let title: String          // 예: "Muscle (kg)"
        let value: Double          // 예: "34.0"
        let bodyState: ValueState  //예: .normal

        var body: some View {
            VStack(spacing: 8) {
                Text(title)
                    .appFont(.emphasisSemiBold16)
                    .foregroundStyle(.gray)

                Text("\(value, specifier: "%.1f")")
                    .appFont(.sectionTitleBold28)

                Text(bodyState.title)
                    .appFont(.emphasisSemiBold16)
                    .padding(.horizontal)
                    .background(bodyState.color)
                    .clipShape(RoundedRectangle(cornerRadius: 40))
            }
            .padding()
            .frame(width: width * 0.15, height: width * 0.15)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 4)
            )
        }
    }
    
    private struct BodyCompositionView: View {
        
        let height: CGFloat
        
        @Binding var isExpanded: Bool
        
        var body: some View {
            DisclosureGroup(
                isExpanded: $isExpanded,
                content: {
                    VStack(alignment: .leading, spacing: 8) {
                        MuscleMassChartView()
                            .frame(maxWidth: .infinity)
                            .frame(height: height * 0.3)
                        
                        BodyFatMassChartView()
                            .frame(maxWidth: .infinity)
                            .frame(height: height * 0.3)
                    }
                    .padding(.leading)
                },
                label: {
                    HStack {
                        Text("Body Composition")
                            .appFont(.sectionTitleBold28)
                        
                        Spacer()
                    }
                }
            )
            .padding()
            .padding()
            .tint(.black)
        }
    }
    
}
//
//#Preview {
//    WeightDetailView()
//}
struct WeightDetailView_previews: PreviewProvider {
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
