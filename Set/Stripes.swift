//
//  Stripes.swift
//  Set
//
//  Created by sun on 2021/10/08.
//

import SwiftUI

struct StripeView<SymbolShape>: View where SymbolShape: Shape {
    let numberOfStripes: Int = 8
    let lineWidth: CGFloat = 1
    let borderLineWidth: CGFloat = 1.3
    
    let shape: SymbolShape
    let color: Color
    
    var body: some View {
        
        VStack(spacing: 0) {
            ForEach(0..<numberOfStripes) { number in
                Color.white
                Color.white
                color
                if number == numberOfStripes - 1 {
                    Color.white
                    Color.white
                }
            }
            
        }.mask(shape)
        .overlay(shape.stroke(color, lineWidth: borderLineWidth))
//        .frame(width: 100, height: 50)
        
    }
}
