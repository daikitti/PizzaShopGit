//
//  CartView.swift
//  pizzaShop
//
//  Created by Have Dope on 09.03.2023.
//

import SwiftUI

struct CartView: View {
  @StateObject  var viewModel: CartViewModel
    
    var body: some View {
        
        VStack{
            List(viewModel.positions) { position in
                PositionCell(position: position)
                    .swipeActions {
                        Button {
                            viewModel.positions.removeAll { pos in
                                pos.id == position.id
                            }
                        } label: {
                            Text("Жаль, она вкусная :(")
                        }.tint(.red)

                    }
            }
            .listStyle(.plain)
            .navigationTitle("Корзина")
            
            HStack {
                Text("ИТОГО: ")
                    .fontWeight(.bold)
                Spacer()
                Text("\(self.viewModel.cost) ₽")
                    .fontWeight(.bold)
            }
            
            .padding()
            
            HStack () {
                Button {
                    print("Отменить")
                    viewModel.positions.removeAll()
                    
                } label: {
                    Text("Отменить")
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(24)
                    
                }
                
                
                Button {
                    print("Заказать")
                    var order = Order(userID: AuthService.shared.currentUser!.uid, date: Date(), status: OrderStatus.new.rawValue)
                    order.positions =  self.viewModel.positions
                    if order.cost != 0 {
                        DataBaseService.shared.setOrder(order: order) { result in
                            switch result {
                            case .success(let order):
                                print(order.cost)
                                
                                
                                
                            case .failure(let error):
                                print(error.localizedDescription)
                            }
                            
                            
                        }
                        self.viewModel.positions.removeAll()
                    }else {
                        
                        print("Нечего заказывать")
                    }
                } label: {
                    Text("Заказать")
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(24)
                        .frame(maxWidth: .infinity)
                        .shadow(color: .gray, radius: 10, y: 10)
                }
                
            }
            .padding()
        }
        
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(viewModel: CartViewModel.shared)
    }
}
