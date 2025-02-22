//
//  SetLockView2.swift
//  faceID
//
//  Created by 渡邊涼太 on 2024/05/31.
//

import SwiftUI

struct SetLockView2: View{
    @Binding var path: [LockPath]
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var passcheck: passCheck
    
    @State var isShowAlert = false
    @State var passCode = ""
    
    var body: some View{
        VStack{
            Spacer()
            Text("パスコードの再入力")
                .font(.title3)
                .fontWeight(.bold)
            
            //黒丸or白丸
            HStack{
                ForEach(0..<4) { index in
                    if passcheck.secondCheck[index] == nil {
                        Image(systemName: "circle")
                            .padding()
                    }else {
                        Image(systemName: "circle.fill")
                            .padding()
                    }
                }
            }
            
            //注意事項
            Text("\(passcheck.passText)")
                .font(.footnote)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.clear)
            Spacer()
            //入力ボタン
            HStack{
                ForEach(1..<4){ i in
                    Button{
                        inputText(number: String(i))
                    }label:{
                        Text("\(i)")
                            .font(.title)
                            .frame(width: 90, height: 45)
                            .foregroundColor(Color(.orange))
                            .cornerRadius(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color(.orange), lineWidth: 1.0)
                            )
                    }
                }
            }
            HStack{
                ForEach(4..<7){ i in
                    Button{
                        inputText(number: String(i))
                    }label:{
                        Text("\(i)")
                            .font(.title)
                            .frame(width: 90, height: 45)
                            .foregroundColor(Color(.orange))
                            .cornerRadius(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color(.orange), lineWidth: 1.0)
                            )
                    }
                }
            }
            HStack{
                ForEach(7..<10){ i in
                    Button{
                        inputText(number: String(i))
                    }label:{
                        Text("\(i)")
                            .font(.title)
                            .frame(width: 90, height: 45)
                            .foregroundColor(Color(.orange))
                            .cornerRadius(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color(.orange), lineWidth: 1.0)
                            )
                    }
                }
            }
            Button{
                inputText(number: "0")
            }label:{
                Text("0")
                    .font(.title)
                    .frame(width: 90, height: 45)
                    .foregroundColor(Color(.orange))
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color(.orange), lineWidth: 1.0)
                    )
            }
            //入力ボタン終
            Spacer()
        }//VStack
        .navigationTitle("確認入力")
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading){
                Button{
                    //リストに戻り、初期化
                    passcheck.firstCheck = [nil, nil, nil, nil]
                    path.removeLast()
                }label:{
                    Image(systemName: "arrowshape.turn.up.backward.fill")
                }
            }
        }
        //パスコードが一致した時のアラート
        .alert(Text("FaceIdを使いますか？"), isPresented: $isShowAlert){
            //ルートへ
            Button("はい"){
                UserDefaults.standard.set(true, forKey: "UseFaceID")
                path.removeLast(path.count)
                passcheck.firstCheck = [nil, nil, nil, nil]
                passcheck.secondCheck = [nil, nil, nil, nil]
            }
            Button("いいえ"){
                UserDefaults.standard.set(false, forKey: "UseFaceID")
                path.removeLast(path.count)
                passcheck.firstCheck = [nil, nil, nil, nil]
                passcheck.secondCheck = [nil, nil, nil, nil]
            }
        }
        
    }//body
    private func inputText(number : String) {
        for (index, getText) in passcheck.secondCheck.enumerated() {
            //nilかチェック　→ 入力済みならスキップ
            //入力したらfor文を抜け出す
            if getText == nil {
                
                passcheck.secondCheck[index] = number
                //全入力された時
                if index == 3 {
                    if passcheck.firstCheck == passcheck.secondCheck {
                        //同じなら保存, alert（faceID)、
                        for i in 0...3 {
                            passCode = passCode + (passcheck.firstCheck[i] ?? "")

                        }
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                            UserDefaults.standard.set(true, forKey: "SetPass")
                            UserDefaults.standard.set(passCode, forKey: "password")
                            print(passCode)
                            isShowAlert = true
                        }
                        
                    }else{
                        //違うなら初期化して１つ前へ
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                            passcheck.passText = "パスワードが1回目と異なります\nもう一度行ってください"
                            passcheck.firstCheck = [nil, nil, nil, nil]
                            passcheck.secondCheck = [nil, nil, nil, nil]
                            path.removeLast()
                        }
                    }
                }
                break
            }
        }
    }
}
