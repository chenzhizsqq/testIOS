//
//  ContentView.swift
//  NetworkChen
//
//  Created by chenzhizs on 2020/10/10.
//  Copyright © 2020 chenzhizs. All rights reserved.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    @State private var text = ""
    
    var body: some View {
        VStack {
            Text(text).font(.title)
            
            Button(action: {
                self.startLoad()
            }) {
                Text("start")
                    .font(.largeTitle)
                    .foregroundColor(.red)
            }
            
            Button(action: {
                self.updateText("")
            }) {
                Text("Clear")
                    .font(.largeTitle)
                    .foregroundColor(.green)
            }
        }
    }
    
    func startLoad() {
        NetworkAPI.hotPostList {  result in
            switch result{
            case let .success(list): self.updateText("Post count \(list.list.count)")
                
            case let .failure(error): self.updateText(error.localizedDescription)
            }
        }
        
    }
    
    func updateText(_ text: String){
        self.text = text
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
