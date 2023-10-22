//
//  OrderView.swift
//  pizzaShop
//
//  Created by Have Dope on 25.03.2023.
//

import SwiftUI

struct OrderView: View {
    
    @StateObject var viewmodel:OrderViewModel
    
    var statuses: [String]{
        var sts = [String]()
        
        for status in OrderStatus.allCases {
            sts.append(status.rawValue)
        }
        return sts
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8){
            Text("\(viewmodel.user.name)")
                .font(.title3.bold())
            Text("\(viewmodel.user.phone)")
                .bold()
            Text("\(viewmodel.user.adress )")
                .fontWeight(.light)
            
            HStack{
                Text("Cтатус заказа")
                    .bold()
                Spacer()
                Picker(selection: $viewmodel.order.status) {
                    ForEach(statuses, id: \.self) { status in
                        Text(status)
                    }
                } label: {
                    Text("Статус заказов")
                }.background(Color(.gray.withAlphaComponent(0.1)))
                    .cornerRadius(25)
                    .shadow(radius: 10)
                    .onChange(of: viewmodel.order.status) { newStatus in
                        DataBaseService.shared.setOrder(order: viewmodel.order) { result in
                            switch result {
                            case .success(let order):
                               print( order.status)
                            case .failure(let error):
                                print(error.localizedDescription)
                            }
                        }
                    }
                
                
            }.padding(5)
                .cornerRadius(15)
                .border(.mint,width: 1)
                
            
            List {
                ForEach(viewmodel.order.positions, id: \.id) { position in
                    PositionCell(position: position)
                }
                HStack{
                    Spacer()
                    
                    Text("Итого: \(viewmodel.order.cost) ₽")
                    
                        .fontWeight(.light)
                        .bold()
                        .padding(10)
                        .overlay(  Capsule(style: .continuous)
                            .stroke(Color.mint, style: StrokeStyle(lineWidth: 1)))
                    
                }
            }
        }.padding()
            .onAppear{
                viewmodel.getUserDate()
            }
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView(viewmodel: OrderViewModel(order: Order(userID: "", date: Date(), status: "Новый")))
    }
}
