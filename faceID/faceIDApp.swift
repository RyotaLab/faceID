//
//  faceIDApp.swift
//  faceID
//
//  Created by 渡邊涼太 on 2024/05/31.
//

import SwiftUI

@main
struct faceIDApp: App {
    //設定なしならfalse
    let SetPass = UserDefaults.standard.bool(forKey: "SetPass")
    
    var body: some Scene {
        WindowGroup {
            if SetPass{
                //パスコードあり
                LockView()
            }else{
                //パスコードなし
                ContentView()
                    .environmentObject(passCheck())
            }
        }
    }
}
