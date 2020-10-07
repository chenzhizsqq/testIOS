//
//  PostCell.swift
//  test0612
//
//  Created by chenzhizs on 2020/06/12.
//  Copyright © 2020 chenzhizs. All rights reserved.
//

import SwiftUI

struct PostCell: View {
    let post: Post
    
    
    var bingdingPost: Post {
        userData.post(forId: post.id)!
    }
    
    @State var presentComment: Bool = false
    
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        var post = bingdingPost
        return  VStack(alignment:  .leading, spacing: 10){
            
            HStack(spacing: 5){
                post.avatarImage
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50,height: 50)
                    .clipShape(Circle())
                    .overlay(
                        PostVIPBadge(vip: post.vip)
                            .offset(x: 16,y: 16)
                )
                
                VStack(alignment: .leading, spacing: 5.0){
                    Text(post.name)
                        .font(Font.system(size: 16))
                        .foregroundColor(Color(red: 254/255, green: 2/255, blue: 4/255))
                        .lineLimit(1)
                    Text(post.date)
                        .font(.system(size: 11))
                        .foregroundColor(.gray)
                }
                .padding(.leading, 10)
                
                if !post.isFollowed{
                    
                    Spacer()//占位置空间
                    
                    Button(action: {
                        post.isFollowed = true
                        self.userData.update(post)
                        print("Click follow button")//在debug输出中有显示
                    }) {
                        Text("关注")
                            .font(.system(size: 14))
                            .foregroundColor(.orange)
                            .frame(width:50,height: 26)
                            .overlay(
                                RoundedRectangle(cornerRadius: 13)
                                    .stroke(Color.orange, lineWidth: 1)
                        )
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
                
            }
            
            Text(post.text)
                .font(.system(size: 17))
            
            if !post.images.isEmpty {
                
                PostImageCell(images: post.images, width: UIScreen.main.bounds.width - 30)
                
            }
            
            Divider()
            
            HStack(spacing: 0){
                Spacer()
                
                PostCellToolbarButton(
                    image: "message",
                    text: post.commentCountText,
                    color: .red)
                {
                    self.presentComment = true
                    print("print commend button")
                }.sheet(isPresented: $presentComment) {
                    CommentInputView(post: post).environmentObject(self.userData)
                }
                
                Spacer()
                
                PostCellToolbarButton(
                    image: post.isLiked ? "heart.fill" : "heart",
                    text: post.likeCountText,
                    color: post.isLiked ? .red : .black)
                {
                    print("PostCellToolbarButton")
                    if post.isLiked{
                        post.isLiked = false
                        post.likeCount -= 1
                        print("likeCount -1")
                    } else {
                        post.isLiked = true
                        post.likeCount += 1
                        print("likeCount +1")
                    }
                    self.userData.update(post)
                }
                Spacer()
            }
            
            Rectangle()
                .padding(.horizontal, -15)
                .frame(height: 10)
                .foregroundColor(Color(red: 238/255, green: 238/255, blue: 238/255))
            
        }
        .padding(.horizontal,15)
        .padding(.top,15)
    }
}

struct PostCell_Previews: PreviewProvider {
    static var previews: some View {
        
        let userData = UserData()
        return PostDetailView(post: userData.recommedPostList.list[0]).environmentObject(userData)
        //PostCell(post: postList.list[1])
    }
}
