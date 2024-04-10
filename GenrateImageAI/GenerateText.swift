//
//  GenerateText.swift
//  GenrateImageAI
//
//  Created by pnkbksh on 10/04/24.
//

import SwiftUI
import OpenAIKit

struct GenerateText: View {
    
    @State private var generatedText: String = ""
    @State private var searchText: String = "hannah montana"
    @State var viewmodel:ViewModel = ViewModel()
    
    
    var body: some View {
        VStack {
            Text("Generated Text:")
            
            TextField("Search here", text: $searchText)
                .padding()
            
            Text(generatedText)
                .padding()
            
            Button("Generate Text") {
                generateText()
            }
            .padding()
        }
        
        .onAppear(){
            viewmodel.setup()
        }
    }
    
    
    func generateText(){
        if !searchText.trimmingCharacters(in: .whitespaces).isEmpty{
            Task{
                let result = await viewmodel.generateTextWith(message: searchText)
                
                if result == nil{
                    
                    print("fail to get result")
                }
                self.generatedText = result ?? "no data"
            }
        }
    }
    
}

#Preview {
    GenerateText()
}
