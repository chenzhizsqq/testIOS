//
//  ContentView.swift
//  NetworkChen
//
//  Created by chenzhizs on 2020/10/10.
//  Copyright © 2020 chenzhizs. All rights reserved.
//

import SwiftUI

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
        let url = URL(string: "https://raw.githubusercontent.com/chenzhizsqq/testIOS/master/testIOS/Resources/PostListData_recommend_1.json")!
        let task = URLSession.shared.dataTask(with: url) {data,response,error in
            if let error = error {
                self.updateText(error.localizedDescription)
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200 else {
                    self.updateText("Invalid response")
                    return
            }
            
            guard let data = data else {
                    self.updateText("No data")
                    return
            }
            
            guard let list = try? JSONDecoder().decode(PostList.self, from: data) else {
                self.updateText("Can not parse data")
                return
            }
            
            self.updateText("Post count \(list.list.count)")
        }
        task.resume()
        
    }
    
    func updateText(_ text: String){
        DispatchQueue.main.async {
            self.text = text
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
