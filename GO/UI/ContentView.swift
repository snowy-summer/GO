//
//  ContentView.swift
//  GO
//
//  Created by 최승범 on 4/14/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            VStack(spacing: 20) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.purple)
                    .frame(width: 48, height: 48)
                
                RoundedRectangle(cornerRadius: 12)
                    .fill(.purple)
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
                    Spacer()
                    HStack(spacing: 16) {
                        Circle()
                            .frame(width: 40)
                        Circle()
                            .frame(width: 40)
                    }
                    .padding(.horizontal)
                }
                HStack {
                    List {
                        Text("Dashboard")
                        Text("Information")
                        Text("Calories")
                        Text("Work Out")
                    }
                    .listStyle(.plain)
                    .frame(width: 200)
                    
                    GeometryReader { geometry in
                    
                        HStack {
                            BurnCaloriesView()
                                .padding()
                                .background(.gray.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .frame(width: geometry.size.width * 0.6,
                                       height: geometry.size.height * 0.35)
                        }
                        .padding(.horizontal)
                    }
                }
            }
            
            
            
        }
        
    }
}

#Preview {
    ContentView()
}
