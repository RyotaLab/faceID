//
//  passCheck.swift
//  faceID
//
//  Created by 渡邊涼太 on 2024/05/31.
//

import Foundation

class passCheck: ObservableObject {
    @Published var firstCheck:[String?] = [nil, nil, nil, nil]
    @Published var secondCheck:[String?] = [nil, nil, nil, nil]
    
    @Published var passText:String = "パスワードを忘れると復元できません\n忘れないようご注意ください"
}
