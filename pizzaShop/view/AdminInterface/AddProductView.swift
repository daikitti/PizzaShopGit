//
//  AddProductView.swift
//  pizzaShop
//
//  Created by Have Dope on 27.03.2023.
//

import SwiftUI

struct AddProductView: View {
    
    
    @State private var showImagePicker = false
    @State private var image = UIImage(named: "PizzaPH")!
    @State private var title: String = ""
    @State private var descript: String = ""
    @State private var price: Int? = nil
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            Text("Добавить товар")
                .font(.title3.bold())
            Image(uiImage: image)
                .resizable()
                .frame(maxWidth: screen.width, maxHeight: screen.height/2.2)
                .aspectRatio(contentMode: .fit  )
                .onTapGesture {
                    showImagePicker.toggle()
                }
                .cornerRadius(27)
                .shadow(radius: 10,y: 7)
                .padding(6)
                .padding(.top, -10)
            VStack(alignment: .leading){
                Text("Название ")
                TextField("Название продукта", text: $title)
                    .bold()
                    .padding(4)
                    .textFieldStyle(.roundedBorder)
                Text("Цена ")
                TextField("Цена продукта", value: $price, format: .number)          .padding(4)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                Text("Описание ")
                TextField("Описание продукта", text: $descript ,axis: .vertical)
                    .padding(4)
                    .textFieldStyle(.roundedBorder)
                
            }
            Spacer()
            Button {
                print("Сохранить")
                guard let price = price else {
                    print("Не возможно извлечь из TextField")
                    return
                }
                let product = Product(id: UUID().uuidString, title: title, price: price, descript: descript)
                guard let imageData = image.jpegData(compressionQuality: 0.3) else {return}
                DataBaseService.shared.setProduct(product: product, image: imageData) { result in
                    switch result{
                    
                    case .success(let product):
                        print(product.title)
                        dismiss()    
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                
            } label: {
                Text("Сохранить")
            } .fontWeight(.bold)
                .padding()
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .background(Color.mint)
                .cornerRadius(24)
                .frame(maxWidth: .infinity)
                .shadow(color: .gray, radius: 7, y: 4)

            
        }
        .padding()
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $image)
        }
    }
}

struct AddProductView_Previews: PreviewProvider {
    static var previews: some View {
        AddProductView()
    }
}
