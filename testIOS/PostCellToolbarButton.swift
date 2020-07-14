//
//  PostCellToolbarButton.swift
//  testIOS
//
//  Created by chenzhizs on 2020/06/16.
//  Copyright © 2020 chenzhizs. All rights reserved.
//

import SwiftUI

struct PostCellToolbarButton: View {
    let image: String
    let text: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        
        Button(action: {}) {
            HStack(spacing: 5) {
                Image(systemName: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 18, height: 18)
                Text(text)
                    .font(.system(size: 15))
            }
        }
        //.foregroundColor(.black)
        .buttonStyle(BorderlessButtonStyle())
    }
}

struct PostCellToolbarButton_Previews: PreviewProvider {
    static var previews: some View {
        PostCellToolbarButton(
        image: "heart", text: "点赞", color: .red){
            print("点赞")
        }
    }
}
