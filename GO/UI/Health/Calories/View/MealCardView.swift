//
//  MealCardView.swift
//  GO
//
//  Created by 최승범 on 4/22/25.
//

import SwiftUI

struct MealCardView: View {
    let height: CGFloat
    @ObservedObject var viewModel: MealCardViewModel
    
    var body: some View {
        DisclosureGroup(
            isExpanded: $viewModel.isExpanded,
            content: {
                foodCardView(size: height, mealType: viewModel.type)
                    .padding()
            },
            label: {
                VStack {
                    
                    HStack {
                        Text(viewModel.type.label)
                            .appFont(.sectionTitleBold28)
                        
                        Spacer()
                        
                        Text("\(viewModel.data.calories)")
                            .appFont(.cardTitleSemibold22)
                        Text("kcal")
                            .appFont(.bodyRegular16)
                    }
                    
                    HStack {
                        Circle()
                            .fill(.carbs)
                            .frame(width: 20, height: 20)
                        Text("\(viewModel.data.carbs) g")
                        
                        Circle()
                            .fill(.protein)
                            .frame(width: 20, height: 20)
                        Text("\(viewModel.data.protein) g")
                        
                        Circle()
                            .fill(.fat)
                            .frame(width: 20, height: 20)
                        Text("\(viewModel.data.fat) g")
                        Spacer()
                        
                    }
                }
                .padding(.horizontal)
            }
        )
        .padding()
        .tint(.black)
    }
    
    private func foodCardView(size: CGFloat,
                              mealType: MealType) -> some View {
        VStack {
            HStack(alignment: .top, spacing: 16) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: size * 0.25, height: size * 0.25)
                    .overlay(Text("Meal Photo"))
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(viewModel.data.name)
                        .appFont(.cardTitleSemibold22)
                    
                    VStack(alignment: .leading, spacing: 20) {
                        nutrientBar(nutrientType: .carbs,
                                    goalValue: viewModel.data.goalIntake.carbs,
                                    value: viewModel.data.carbs,
                                    percent: viewModel.carbsPercent)
                        nutrientBar(nutrientType: .protein,
                                    goalValue: viewModel.data.goalIntake.protein,
                                    value: viewModel.data.protein,
                                    percent: viewModel.proteinPercent)
                        nutrientBar(nutrientType: .fat,
                                    goalValue: viewModel.data.goalIntake.fat,
                                    value: viewModel.data.fat,
                                    percent: viewModel.fatPercent)
                    }
                }
                
                Spacer()
            }
        }
    }
    
    private func nutrientBar(nutrientType: NutrientType,
                             goalValue: Int,
                             value: Int,
                             percent: Double) -> some View {
        
        
        return GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            HStack {
                VStack(alignment: .leading) {
                    Text(nutrientType.label)
                        .appFont(.tagSemiBold12)
                    Text("\(value) / \(goalValue) g")
                        .appFont(.emphasisSemiBold16)
                    
                }
                .frame(width: width * 0.15,  alignment: .leading)
                
                ZStack(alignment: .leading) {
                    HStack {
                        RoundedRectangle(cornerRadius: 100)
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: height * 0.6)
                            .frame(width: width * 0.55)
                        
                        switch nutrientType {
                        case .calories:
                            HStack {
                                Text(viewModel.remainCalories)
                                    .appFont(.emphasisSemiBold16)
                                stateLabel(viewModel.isCaloriesState)
                                    
                            }.frame(width: width * 0.25)
                            
                            
                        case .carbs:
                            HStack {
                                Text(viewModel.remainCarbs)
                                    .appFont(.emphasisSemiBold16)
                                stateLabel(viewModel.isCarbsState)
                                    
                            }.frame(width: width * 0.25)
                            
                            
                        case .protein:
                            HStack {
                                Text(viewModel.remainProtein)
                                    .appFont(.emphasisSemiBold16)
                                stateLabel(viewModel.isProteinState)
                                    
                            }.frame(width: width * 0.25)
                            
                            
                        case .fat:
                            HStack {
                                Text(viewModel.remainfat)
                                    .appFont(.emphasisSemiBold16)
                                stateLabel(viewModel.isFatState)
                                    
                            }
                            .frame(width: width * 0.25)
                            
                        }
                    }
                    
                    RoundedRectangle(cornerRadius: 100)
                        .fill(value > goalValue ? Color.red : nutrientType.color)
                        .frame(height: height * 0.6)
                        .frame(width: min(width * 0.55 * percent, width * 0.55))
                    
                    
                }
            }
        }
    }
    
    private func stateLabel(_ state: ValueState) -> some View {
        
        Text(state.title)
            .appFont(.emphasisSemiBold16)
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
            .background(state.color)
            .clipShape(RoundedRectangle(cornerRadius: 40))
        
        
    }
}

#Preview {
    HealthView()
}
