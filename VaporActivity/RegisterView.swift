//
//  RegisterView.swift
//  VaporActivity
//
//  Created by 이원형 on 2022/12/05.
//

import SwiftUI

struct RegisterView: View {
    @State var inputId : String = ""
    @State var inputPassword : String = ""
    @State var registerResult : String = ""
    var isInput : Bool {
        return inputId.count > 0 && inputPassword.count > 0
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing : 20) {

            HStack {
                Text("ID : ")
                TextField("아이디를 입력해주세요", text: $inputId).keyboardType(.default).autocapitalization(.none)
            }
        
            HStack {
                Text("Password : ")
                SecureField("비밀번호를 입력해주세요", text: $inputPassword).keyboardType(.default).autocapitalization(.none)
            }
            
            HStack {
                Button {
                    tryRegister(id: inputId, password: inputPassword)
                } label: {
                    Text("가입하기")
                        .padding()

                        .foregroundColor(isInput ? .white : .secondary)
                        .background(isInput ? .black : .secondary)
                        .opacity(isInput ? 1 : 0.2)
                        .cornerRadius(5)
                }
                .disabled(isInput ? false : true)
            }
            
            

            Text(registerResult)
                .font(.title2)
            
        }
        .padding(50)
        .padding(.vertical, 50)
        
        
        
    }
    
    private func tryRegister(id : String, password : String) {
        Task {
            // 한글도 URL에 포함할 수 있도록 전처리
            let urlStr = "http://127.0.0.1:8080/register/\(id)/\(password)"
            let encodedStr = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let url = URL(string: encodedStr)!
            
            let data = try await URLSession.shared.data(from : url).0
            registerResult = String(data: data, encoding: .utf8)!
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
