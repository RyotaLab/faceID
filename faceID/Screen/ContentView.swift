//
//  ContentView.swift
//  faceID
//
//  Created by 渡邊涼太 on 2024/05/31.
//

import SwiftUI

enum LockPath {
    case pathSub1
    case pathSub2
}

struct ContentView: View {
    @State private var navigatePath: [LockPath] = []
    //何もない時はfalse
    @State var toggle = UserDefaults.standard.bool(forKey: "SetPass")
    
    var body: some View {
        NavigationStack(path: $navigatePath) {
            List{
                //一般
                NavigationLink(destination: Text("機能なし")) {
                    Text("サンプル")
                }
                //passセット off -> onの時のみ画面遷移
                Toggle("パスコード設定",isOn: $toggle)
                    .onAppear{
                        toggle = UserDefaults.standard.bool(forKey: "SetPass")
                    }
                    .onChange(of: toggle) {
                        if toggle {
                            //パスワード設定画面へ
                            navigatePath.append(.pathSub1)
                        }else{
                            //pass解除
                            UserDefaults.standard.set(false, forKey: "SetPass")
                            UserDefaults.standard.set(false, forKey: "UseFaceID")
                        }
                    }
            }
            .navigationDestination(for: LockPath.self){ value in
                switch value {
                    
                case .pathSub1:
                    SetLockView1(path: $navigatePath)
                case .pathSub2:
                    SetLockView2(path: $navigatePath)
                }
            }
        }//navigationStack
        
    }
}
