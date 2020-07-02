//
//  PostListView.swift
//  testIOS
//
//  Created by chenzhizs on 2020/06/16.
//  Copyright © 2020 chenzhizs. All rights reserved.
//

import SwiftUI

struct PostListView: View {
    let category: PostListCategory
    
    var postList: PostList {
        switch category {
        case .recommend:
            return loadPostListData("PostListData_recommend_1.json")
        case .hot:
                return loadPostListData("PostListData_hot_1.json")
        }
    }
    
    

    var body: some View {
//        List{
//
//            ForEach(postList.list){
//                post in PostCell(post: post)
//                    .listRowInsets(EdgeInsets())
//            }
//        }
        List {
            ForEach(postList.list) { post in
                ZStack {
                    PostCell(post: post)
                    NavigationLink(destination: PostDetailView(post: post)) {
                        EmptyView()
                    }
                    .hidden()
                }
                .listRowInsets(EdgeInsets())
            }
        }
    }
}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            PostListView(category: .recommend)
            .navigationBarTitle("title")
            .navigationBarHidden(true)
        }
    }
}
