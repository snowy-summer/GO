//
//  VitalDetailView.swift
//  GO
//
//  Created by 최승범 on 4/22/25.
//

import SwiftUI

struct VitalDetailView: View {
    
    @StateObject var viewModel: VitalDetailViewModel = VitalDetailViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            ScrollView {
                VStack(spacing: 20) {
                    
                    HStack {
                        ForEach(VitalInformationType.allCases,
                                id: \.self) { type in
                            heartCard(width: width, type: type)
                        }
                        Spacer()
                    }
                    .frame(height: height * 0.1)
                    .padding(.horizontal)
                    
                    switch viewModel.selectedType {
                    case .heartRate:
                        Text("심박")
                    case .sleepTime:
                        Text("수면")
                    case .steps:
                        StepsDetailView()
                            .background(.back)
                            .frame(height: height * 1.1)
                    case .water:
                        WaterIntakeDetailView()
                            .background(.back)
                            .frame(height: height * 1.1)
                    }
                    
                    
                }
            }
            
        }
        
        
    }
    
    func heartCard(width: CGFloat,
                   type: VitalInformationType) -> some View {
        let cardWidth = width * 0.2

        return ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(viewModel.selectedType == type ? Color.white : Color.gray.opacity(0.2))
                .frame(maxWidth: cardWidth)
            HStack {
                if type == .heartRate {
                    Image(type.image)
                        .resizable()
                        .frame(width: width * 0.03, height: width * 0.03)
                        .padding(.bottom, 8)
                } else {
                    Image(systemName: type.image)
                        .resizable()
                        .frame(width: width * 0.03, height: width * 0.03)
                        .padding(.bottom, 8)
                }
                
                Text(type.title)
                    .appFont(.listTitleBold20)
                    .padding(.horizontal, 4)
            }
            .padding(.leading, 20)
            .frame(maxWidth: cardWidth, alignment: .leading)
            
        }
        .onTapGesture {
            viewModel.action(.select(type))
        }
    }
}

#Preview {
    HealthView()
}

