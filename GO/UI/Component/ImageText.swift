//
//  ImageText.swift
//  GO
//
//  Created by 최승범 on 4/15/25.
//

import SwiftUI

struct ImageTextData {
    let text: String
    let imageName: String
}

struct ImageText: View {
    
    let imageTextData: ImageTextData
    
    var body: some View {
        HStack {
            Image(systemName: imageTextData.imageName)
            Text(imageTextData.text)
        }
    }
}


#Preview {
    ImageText(imageTextData: ImageTextData(text: "Dashboard", imageName: "house"))
}

