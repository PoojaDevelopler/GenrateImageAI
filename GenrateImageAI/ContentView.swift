//
//  ContentView.swift
//  GenrateImageAI
//
//  Created by pnkbksh on 10/04/24.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewmodel:ViewModel = ViewModel()
    @State var text = ""
    @State var image:UIImage?
    
    
    var body: some View {
        NavigationView{
            
            VStack {
               
                if let image = image{
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                }
                else{
                    Text("Type to generate image")
                }
                
                Spacer()
                TextField("text promt here", text: $text)
                    .padding()
                Button("Generate"){
                    
                    if !text.trimmingCharacters(in: .whitespaces).isEmpty{
                        Task{
                            let result = await viewmodel.generateImageWith(prompt: text)
                            if result == nil{
                                
                                print("fail to get result")
                            }
                            self.image = result
                        }
                    }
                }
                
            }
            .navigationTitle("Image Generator")
            .onAppear(){
                viewmodel.setup()
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
