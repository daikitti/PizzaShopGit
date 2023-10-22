//
//  PositionCell.swift
//  pizzaShop
//
//  Created by Have Dope on 13.03.2023.
//

import SwiftUI

struct PositionCell: View {
    
    let position: Position
    
    
     
    var body: some View {
        HStack {
            Text(position.product.title)
                .fontWeight(.bold)
            Spacer()
            Text("\(position.count) шт.")
            Text("\(position.coast)")
                .frame(width: 85, alignment: .trailing)
        }.padding(.horizontal)
    }
}

struct PositionCell_Previews: PreviewProvider {
    static var previews: some View {
        PositionCell(
            position: Position(id: UUID().uuidString, product: Product(id: UUID().uuidString, title: "Маргартиа Гурмe", imageUrl: "PizzaPH", price: 350, descript: "tratatatat"), count: 3  )
        )
    }
}
