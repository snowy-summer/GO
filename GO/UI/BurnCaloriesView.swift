//
// BurnCaloriesView.swift
//  GO
//
//  Created by 최승범 on 4/14/25.
//

import SwiftUI

struct BurnCaloriesView: View {
    var body: some View {
        HStack {
            Image(systemName: "flame.fill")
                .resizable()
                .foregroundStyle(.red)
                .frame(width: 17, height: 23)
            Text("Burn Calories")
                .appFont(.listTitleBold20)
            
            Text("13 - 19 April 2025 ")
                .appFont(.tagSemiBold12)
                .foregroundStyle(.sub)
        }
            
    }
}

#Preview {
    BurnCaloriesView()
}
