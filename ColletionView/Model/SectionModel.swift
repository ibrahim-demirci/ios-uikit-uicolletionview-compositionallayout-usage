//
//  SectionModel.swift
//  ColletionView
//
//  Created by İbrahim on 5.02.2025.
//

import Foundation

struct SectionModel {
    let type: SectionType
    let itemsCount: Int
}

enum SectionType {
    case story
    case paginate
    case paginateGrid
    case grid
    case instagramDiscovery
    case defaultSection
    
    var title: String {
        switch self {
        case .story: return "Horizontal"
        case .paginate: return "Paginate"
        case .paginateGrid: return "Paginate Grid"
        case .grid: return "Grid"
        case .instagramDiscovery: return "Instagram Discovery"
        case .defaultSection: return "Default"
        }
    }
}
