//
//  SetLockView1.swift
//  faceID
//
//  Created by 渡邊涼太 on 2024/05/31.
//

import SwiftUI

struct SetLockView1: View {
    @Binding var path: [LockPath]
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var passcheck: passCheck
    @State var count = 0
    
    var body: some View {
        VStack{
            Spacer()
            Text("パスコードの入力")
                .font(.title3)
                .fontWeight(.bold)

            HStack{
                //黒丸
                ForEach(0..<4) { index in
                    if passcheck.firstCheck[index] == nil {
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
                .foregroundColor(Color.pink)
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
        }
        .navigationTitle("入力")
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading){
                Button{
                    //リストに戻り、初期化
                    passcheck.firstCheck = [nil, nil, nil, nil]
                    passcheck.passText = "パスワードを忘れると復元できません\n忘れないようご注意ください"
                    path.removeLast()
                }label:{
                    Image(systemName: "arrowshape.turn.up.backward.fill")
                }
            }
        }
    }
    
    private func inputText(number : String) {
        for (index, getText) in passcheck.firstCheck.enumerated() {
            //nilかチェック　→ 入力済みならスキップ
            //入力したらfor文を抜け出す
            if getText == nil {
                
                passcheck.firstCheck[index] = number
                //もしi.index = 3なら　画面遷移+0.1
                
                if index == 3 {
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                        path.append(.pathSub2)
                    }
                }
                
                break
            }
        }
    }
}
