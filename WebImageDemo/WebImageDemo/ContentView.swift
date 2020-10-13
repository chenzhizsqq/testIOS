//
//  ContentView.swift
//  WebImageDemo
//
//  Created by chenzhizs on 2020/10/13.
//  Copyright © 2020 chenzhizs. All rights reserved.
//

import SwiftUI

private let url = URL(string: "https://raw.githubusercontent.com/chenzhizsqq/testIOS/master/testIOS/Resources/006PdkDogy1gap6ngj12ej30u011itf7.jpg")!

struct ContentView: View {
    var body: some View {
        NavigationView {
            List{
                NavigationLink(destination: SimpleExample(url: url)) {
                    Text("SimpleExample")
                }
                NavigationLink(destination: WebImageExample(url: url)) {
                    Text("WebImageExample")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
