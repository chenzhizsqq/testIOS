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
    
    @EnvironmentObject var userData: UserData
    
    

    var body: some View {
        List {
            ForEach(userData.postList(for: category).list) { post in
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
        }.environmentObject(UserData())
    }
}
