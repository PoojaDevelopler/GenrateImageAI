//
//  ViewModel.swift
//  GenrateImageAI
//
//  Created by pnkbksh on 10/04/24.
//

import Foundation
import OpenAIKit
import SwiftUI

let aiKey = "Your_Key_AI"


final class ViewModel:ObservableObject{
    
    private var openAI:OpenAI?
    
    let config = Configuration(
        organizationId: aiKey,
        apiKey: "Personal"
    )
    
    func setup(){
        openAI  = OpenAI(config)
    }
    
    func generateImageWith(prompt:String) async -> UIImage?{
        guard let openAI = openAI else { return nil }
        
        do{
            let params = ImageParameters(prompt: prompt,
                                         resolution: .medium,
                                         responseFormat: .base64Json
                                         
            )
            
            let result = try await  openAI.createImage(parameters: params)
            let data = result.data[0].image
            let image = try openAI.decodeBase64Image(data)
            return image
            
        }
        catch{
            print(String(describing: error))
            return nil
        }
    }
    
   
}

extension ViewModel{
    
    func generateTextWith(message:String) async -> String?{
        guard let openAI = openAI else { return nil }
        let chatMsg = ChatMessage(role: .user, content: message)
        var response = "Error"
        
        do{
            let params = ChatParameters(model: .chatGPTTurbo, messages: [chatMsg])
            
            let aiResult = try await openAI.generateChatCompletion(parameters: params)
            
            if let text = aiResult.choices.first?.message?.content {
                response =  "Response: " + text }
            
        }
        catch{
            print(String(describing: error))
            return response
        }

        return response
    }
}

