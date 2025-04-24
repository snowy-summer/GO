//
//  VitalDetailView.swift
//  GO
//
//  Created by 최승범 on 4/22/25.
//

import SwiftUI

struct VitalDetailView: View {
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            
            VStack {
                StepsDetailCardView()
                    .background(.back)
                
            }
        }
        
        
    }
}

#Preview {
    HealthView()
}
