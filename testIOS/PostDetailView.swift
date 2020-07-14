//
//  PostDetailView.swift
//  testIOS
//
//  Created by chenzhizs on 2020/06/18.
//  Copyright © 2020 chenzhizs. All rights reserved.
//

//import SwiftUI
//
//struct PostDetailView: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//struct PostDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostDetailView()
//    }
//}

import SwiftUI

struct PostDetailView: View {
    let post: Post

    var body: some View {
        List {
            PostCell(post: post)
                .listRowInsets(EdgeInsets())

            ForEach(1...10, id: \.self) { i in
                Text("评论\(i)")
            }
        }
        .navigationBarTitle("详情", displayMode: .inline)
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let userData = UserData()
        return PostDetailView(post: userData.recommedPostList.list[0]).environmentObject(userData)
    }
}
