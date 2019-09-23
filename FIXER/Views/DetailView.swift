////
////  DetailView.swift
////  FIXER
////
////  Created by Per Pert on 16.09.2019.
////  Copyright © 2019 Petro. All rights reserved.
////
//
//import SwiftUI
//import Foundation
//import UIKit
//struct DetailView: View {
//    
//    var item: ProductViewModel
//    @available(iOS 13.0.0, *)
//    var body: some View {
//        ScrollView {
//            
//            VStack (spacing: 8){
//                Image(uiImage: item.image ?? UIImage(imageLiteralResourceName: "noPhoto"))
//                    .resizable()
//                    .frame(width: 300, height: 300)
//                
//                
//                Divider()
//                
//                Text(item.product.title.ua)
//                    .lineLimit(nil)
//                    .fixedSize(horizontal: false, vertical: true)
//                
//                Divider()
//                
//                
//                HStack {
//                    
//                    Text("Ціна")
//                    Text(String(Int(item.product.price * 25)))
//                        .font(.title)
//                    
//                    
//                    Spacer()
//                    
//                    Button(action: {
//                        print("Hello")
//                    }) {
//                        Text("Купити")
//                    }
//                    .frame(width: 85, height:30)
//                    .foregroundColor(Color.white)
//                    .background(Color.orange)
//                    .cornerRadius(10)
//                }
//                
//                Text(item.product.description.ua)
//                    .fontWeight(.ultraLight)
//                    .lineLimit(nil)
//                    .fixedSize(horizontal: false, vertical: true)
//            }
//            .padding()
//        }
//    }
//}
//
//
//
//
//
//
//
