//
//  ContentView.swift
//  PullDownTORefreshDemo
//
//  Created by chenzhizs on 2020/10/14.
//  Copyright © 2020 chenzhizs. All rights reserved.
//

import SwiftUI
import BBSwiftUIKit

struct ContentView: View {
    @State var list: [Int] = (0..<50).map{ $0 }
    @State var isRefreshing: Bool = false
    @State var isLoadingMore: Bool = false
    
    var body: some View {
        BBTableView(list) { i in
        Text("Hello, World! \(i)")
            .padding()
            .background(Color.blue)
        }
        .bb_pullDownToRefresh(isRefreshing: $isRefreshing)
        {
            print("refresh")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1)
            {
                self.list = (0..<50).map{ $0 }
                self.isRefreshing = false
            }
        }
        .bb_pullUpToLoadMore(bottomSpace: 30)
        {
            if self.isLoadingMore || self.list.count >= 100 {return}
            self.isLoadingMore = true
            print("Load more")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1)
            {
                let more = self.list.count..<self.list.count + 10
                self.list.append(contentsOf: more)
                self.isLoadingMore = false
            }
        }
        .bb_setupRefreshControl{ control in
            control.tintColor = .blue
            control.attributedTitle = NSAttributedString(string: "加载中...", attributes: [.foregroundColor:UIColor.blue])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
