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
    
    
    var body: some View {
        VStack(alignment:  .leading, spacing: 10)
        {
            
            
            HStack(spacing: 5){
                //Image(uiImage: UIImage(named: post.avatar)!)
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
                        .foregroundColor(Color(red: 254/255, green: 2/255, blue: 3/255))
                        .lineLimit(1)
                    Text(post.date)
                        .font(.system(size: 11))
                        .foregroundColor(.gray)
                }
                .padding(.leading, 10)
                
                if !post.isFollowed{
                    
                    Spacer()//占位置空间
                    
                    Button(action: {
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
                //Image(uiImage: UIImage(named: post.images[0])!)
                
//                loadImage(name: post.images[0])
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: UIScreen.main.bounds.width-30, height: (UIScreen.main.bounds.width-30) * 0.75)
//                    .clipped()
                
                PostImageCell(images: post.images, width: UIScreen.main.bounds.width - 30)
                
            }
            
            Divider()
            
            HStack(spacing: 0)
            {
                Spacer()
                HStack(spacing: 0) {
                    PostCellToolbarButton(
                        image: "message",
                        text: post.commentCountText,
                        color: .black)
                    {
                        print("print commend button")
                    }
                }
                Spacer()
                
                HStack(spacing: 0) {
                    PostCellToolbarButton(
                        image: "message",
                        text: post.likeCountText,
                        color: .black)
                    {
                        print("print commend button")
                    }
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
        
        //        PostCell(post: Post(
        //            avatar: "d0c21786ly1gavj2c0kcej20c8096dh7.jpg",
        //            vip: true,
        //            name: /*@START_MENU_TOKEN@*/"用户名称"/*@END_MENU_TOKEN@*/,
        //            date: "2020-6-1",
        //            isFollowed: false))
        
        PostCell(post: postList.list[1])
    }
}
