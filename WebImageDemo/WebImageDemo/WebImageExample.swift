//
//  WebImageExample.swift
//  WebImageDemo
//
//  Created by chenzhizs on 2020/10/13.
//  Copyright © 2020 chenzhizs. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct WebImageExample: View {
    let url: URL?
    
    var body: some View {
        WebImage(url: url)
            .placeholder{ Color.gray }
            .resizable()
            .onSuccess(perform: { (_, _, _) in
                print("Success")
                SDWebImageManager.shared.imageCache.clear(with: .all, completion: nil)
                //清理缓存
            })
            .onFailure(perform: { (_) in
                print("failure")
            })
            .scaledToFill()
            .frame(height: 600)
            .clipped()
    }
}
