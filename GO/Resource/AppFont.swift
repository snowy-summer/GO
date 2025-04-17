//
//  AppFont.swift
//  GO
//
//  Created by 최승범 on 4/14/25.
//

import SwiftUI

enum AppFont {
    case largeTitleBold34
    case titleBold24
    case sectionTitleBold28
    case cardTitleSemibold22
    case listTitleBold20
    
    case cpationRegular13
    case cpationLight12
    case tagSemiBold12
    case subHeadLineMedium15
    case emphasisSemiBold16
    case bodyLargeRegular18
    case bodyRegular16
    case bodySmallRegular14
    case buttonMedium14
    case primaryButtonSemiBold16

    var size: CGFloat {
        switch self {
        case .largeTitleBold34: return 34
        case .sectionTitleBold28: return 28
        case .titleBold24: return 24
        case .cardTitleSemibold22: return 22
        case .listTitleBold20: return 20
        case .bodyLargeRegular18: return 18
        case .emphasisSemiBold16, .primaryButtonSemiBold16, .bodyRegular16: return 16
        case .subHeadLineMedium15: return 15
        case .bodySmallRegular14, .buttonMedium14: return 14
        case .cpationRegular13: return 13
        case .tagSemiBold12, .cpationLight12: return 12
        }
    }

    var weight: Font.Weight {
        switch self {
        case .largeTitleBold34, .titleBold24, .sectionTitleBold28, .listTitleBold20: return .bold
        case .cardTitleSemibold22, .emphasisSemiBold16, .primaryButtonSemiBold16, .tagSemiBold12: return .semibold
        case .subHeadLineMedium15, .buttonMedium14: return .medium
        case .bodyLargeRegular18, .bodyRegular16, .bodySmallRegular14, .cpationRegular13: return .regular
        case .cpationLight12: return .light
        }
    }

    var font: Font {
        .system(size: size, weight: weight)
    }
}
