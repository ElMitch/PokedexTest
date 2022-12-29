//
//  ProportionalAnchors.swift
//  PokedexMitch
//
//  Created by Mitchell Samaniego on 29/12/22.
//

import Foundation
import UIKit

extension CGFloat {
    func estimatedWidthForImages() -> CGFloat {
        let estimatedWidth = (self - 48) / 2
        return estimatedWidth
    }
}
