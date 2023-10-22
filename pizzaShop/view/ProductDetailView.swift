//
//  ProductDetailView.swift
//  pizzaShop
//
//  Created by Have Dope on 13.03.2023.
//

import SwiftUI

struct ProductDetailView: View {
    
    
    
    
    @State var viewModel: ProductDetailViewModel 
    @State var size = "Маленькая"
    @State var count = 1
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
       
       
        
        VStack {
            VStack(alignment: .leading){
                Image(uiImage: self.viewModel.image)
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: screen.height/2.2)
                    .padding(0)
                    .shadow(radius: 12, y: 10)
                
                HStack{
                    
                    Text("\(viewModel.product.title)")
                        .font(.title.bold())
                        .padding(.vertical, 22)
                    Spacer()
                    Text("\(viewModel.getPrice(size: self.size)) ₽")
                        .font(.title2)
                    
                    
                }.padding(.horizontal)
                Text("\(viewModel.product.descript)")
                    .font(.title3)
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                    .padding(.vertical, 4)
                    .background(Color(uiColor: .white))
                
                Spacer()
                HStack {
                    Stepper("Количество", value: $count , in: 1...10).font(.title3.bold())
                    Text("\(self.count)")
                        .padding(4)
                        .padding(.horizontal,8)
                        .background(.white)
                        .font(.title2.bold())
                        .cornerRadius(90)
                        .shadow(color: .gray, radius: 4, y: 3)
                        .padding(.leading, 28)
                }.padding(.horizontal)
                
                Picker("Размер пиццы", selection: $size) {
                    
                    ForEach(viewModel.sizes, id: \.self){ item in
                        Text(item)
                    }
                }.pickerStyle(.segmented)
                    .padding()
                
                
            }.ignoresSafeArea()
            Button {
                
                var position = Position(id: UUID().uuidString, product: viewModel.product, count: self.count)
                
                position.product.price = viewModel.getPrice(size: size)
                
                CartViewModel.shared.addPosition(position)
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("В корзину")
            }.padding()
                .frame(maxWidth: .infinity)
                .background(LinearGradient(colors: [Color("yello"),Color("orange")], startPoint: .leading, endPoint: .trailing))
                .cornerRadius(44)
            //.padding(8)
                .padding(.horizontal, 102)
                .font(.title3.bold())
                .foregroundColor(.black)
                .shadow(radius: 7,y: 10)
            
        
            
            Spacer()
        } .onAppear{
            self.viewModel.getImage()
        }
       
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(viewModel: ProductDetailViewModel(product: Product(id: "1", title: "Маргарита Гурмэ", imageUrl: "not found", price: 450, descript: "Самая бомжатская пицца")))
    }
}
