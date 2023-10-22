//
//  OrderCell.swift
//  pizzaShop
//
//  Created by Have Dope on 24.03.2023.
//

import SwiftUI

struct OrderCell: View {
    var order: Order
    
    var body: some View {
        HStack{
            Text("\(order.date.formatted(date: .abbreviated, time: .shortened ))")
                .frame(alignment: .leading)
                .fontWeight(.light)
            Spacer()
            Text("\(order.cost)")
                .frame(alignment: .leading)
                .bold()
                
            Spacer()
            
            Text("\(order.status)")
                .foregroundColor(.green)
        }
       
    }
}

//struct OrderCell_Previews: PreviewProvider {
//    static var previews: some View {
//        OrderCell()
//    }
//}
