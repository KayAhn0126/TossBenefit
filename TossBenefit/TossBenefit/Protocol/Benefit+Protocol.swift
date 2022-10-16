//
//  Benefit.swift
//  TossBenefit
//
//  Created by Kay on 2022/10/15.
//

import Foundation

protocol Benefit: Hashable {
    var id: UUID { get set }
    var imageName: String { get set }
    var title: String { get set }
    var description: String { get set }
    var ctaTitle: String { get set }
    var type: String { get set }
}
