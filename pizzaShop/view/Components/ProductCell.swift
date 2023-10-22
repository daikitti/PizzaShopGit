//
//  ProductCell.swift
//  pizzaShop
//
//  Created by Have Dope on 11.03.2023.
//

import SwiftUI
import UIKit

struct ProductCell: View {
    var product: Product
  @State  var uiImage = UIImage(named: "PizzaPH" )
    var body: some View {
        VStack(spacing: 2){
            
            Image(uiImage: uiImage!)
                .resizable()
                .aspectRatio( contentMode: .fill)
                .frame(maxWidth: screen.width * 0.45,maxHeight: screen.width * 0.50)
                .clipped()
                .cornerRadius(16)
                
            HStack{
                Text(product.title)
                    .font(.custom("AvenirNext-regular", size: 16))
                Spacer()
                Text("\(product.price) ₽")
                    .font(.custom("AvenirNext-bold", size: 12))
            }
            .padding(.horizontal, 5)
            .padding(.bottom, 4)
        }.frame(width: screen.width * 0.45, height: screen.width * 0.50)
            .background(.white)
            .cornerRadius(16)
            .shadow(radius: 4)
            .onAppear{
                
                StorageService.shared.downloadProductImage(id: self.product.id) { result in
                    switch result{
                    case .success(let data ):
                        if let img = UIImage(data: data){
                            self.uiImage = img
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        
    }
}

struct ProductCell_Previews: PreviewProvider {
    static var previews: some View {
        ProductCell(product: Product(id: "1", title: "Маргарита Гурмэ", imageUrl: "not found", price: 450, descript: "Самая бомжатская пицца"))
    }
}
