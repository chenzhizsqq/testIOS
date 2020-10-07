//
//  CommentInputView.swift
//  testIOS
//
//  Created by chenzhizs on 2020/10/07.
//  Copyright © 2020 chenzhizs. All rights reserved.
//

import SwiftUI

struct CommentInputView: View {
    let post: Post
    
    @State private var text: String = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        VStack(spacing: 0){
            CommentTextView(text: $text, beginEditingOnAppear: true)
            
            HStack(spacing: 0){
                Button(action: {
                    print("Cancel")
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    Text("取消").padding()
                }
                
                Spacer();
                
                Button(action: {
                    print("Send")
                    print(self.text)
                    var post = self.post
                    post.commentCount += 1
                    self.userData.update(post)
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    Text("发送").padding()
                }
            }
            .font(.system(size:18))
            .foregroundColor(.black)
        }
        
    }
}

struct CommentInputView_Previews: PreviewProvider {
    static var previews: some View {
        CommentInputView(post: UserData().recommedPostList.list[0])
    }
}
