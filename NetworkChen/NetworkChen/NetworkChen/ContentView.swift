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
        NetworkManager.shared.requestGet(path: "PostListData_recommend_1.json",parameters: nil){ result in
            switch result{
            case let .success(data):
                guard let list = try? JSONDecoder().decode(PostList.self, from: data)  else {
                    self.updateText("Can not parse data")
                    return
                }
                
                self.updateText("Post count \(list.list.count)")
                
            case let .failure(error):
                self.updateText(error.localizedDescription)
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
