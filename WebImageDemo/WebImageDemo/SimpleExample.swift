//
//  SimpleExample.swift
//  WebImageDemo
//
//  Created by chenzhizs on 2020/10/13.
//  Copyright © 2020 chenzhizs. All rights reserved.
//

import SwiftUI

struct SimpleExample: View {
    let url: URL?
    
    @State private var data: Data?
    
    private var image: UIImage?
    {
        if let data = self.data {
            return UIImage(data: data)
        }
        return nil
    }
    
    var body: some View {
        let image = self.image
        return Group {
            if image != nil {
                Image(uiImage: image!)
                .resizable()
                .scaledToFit()
            }else{
                Text("no images")
                    .padding()
                Color.gray
            }
        }
        .frame(height: 600)
        .clipped()
        .onAppear {
            if let url = self.url, self.data == nil {
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url)
                    DispatchQueue.main.async {
                        self.data = data
                    }
                }
            }
        }
    }
}


struct SimpleExample_Previews: PreviewProvider {
    static var previews: some View {
        SimpleExample(url:URL(string: "https://raw.githubusercontent.com/chenzhizsqq/testIOS/master/testIOS/Resources/006PdkDogy1gap6ngj12ej30u011itf7.jpg"))
    }
}
