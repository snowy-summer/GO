//
//  Data+Extension.swift
//  GO
//
//  Created by 최승범 on 4/20/25.
//

import SwiftUI

extension Data {
    func toImage() -> Image? {
        guard let uiImage = UIImage(data: self) else { return nil }
        return Image(uiImage: uiImage)
    }
}
