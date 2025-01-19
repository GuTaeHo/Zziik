//
//  AddressSearchWebView.swift
//  Zziik
//
//  Created by 구태호 on 1/17/25.
//

import SwiftUI
import WebKit
import Combine
import Then


struct AddressSearchWebView: View, AddressSearchWebUIKitView.WebViewMessageDelegate {
    
    @Binding var path: [AppCoordinator.Destination]
    @Binding var url: String
    @State var errorReason: String = ""
    
    var body: some View {
        VStack {
            CommonHeaderView(leftButtonImage: .constant(.icHeaderBack24),
                             title: .constant("주소찾기"),
                             leftButtonAction: {
                path.removeLast()
            })
            .frame(height: 50)
            if let url = URL(string: url) {
                AddressSearchWebUIKitView(url: .constant(url), messageHandler: self)
            } else {
                Text(errorReason)
            }
        }
    }
    
    func didReceive(address: AddressSearchWebUIKitView.Address) {
        // TODO: 주소 이전화면으로 전달
        
    }
    
    func failure(error: Error) {
        errorReason = error.localizedDescription
    }
}

struct AddressSearchWebUIKitView: UIViewRepresentable {
    protocol WebViewMessageDelegate {
        func didReceive(address: Address)
        func failure(error: Error)
    }
    
    class Coordinator: NSObject, WKScriptMessageHandler {
        var parent: AddressSearchWebUIKitView
        
        init(parent: AddressSearchWebUIKitView) {
            self.parent = parent
        }
        
        func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            guard let body = message.body as? [String : Any] else { return }
            do {
                let address = try body.toObject(with: Address.self)
                parent.messageHandler.didReceive(address: address)
            } catch(let error) {
                parent.messageHandler.failure(error: error)
            }
        }
    }
    
    struct Address: Codable, Equatable {
        var jibunAddress: String?
        var roadAddress: String?
        var zonecode: String?
    }
    
    @Binding var url: URL
    let messageHandler: WebViewMessageDelegate
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        let userContentController = WKUserContentController()
        
        userContentController.add(context.coordinator, name: "callBackHandler")
        configuration.userContentController = userContentController
        
        return WKWebView(frame: .zero, configuration: configuration)
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}



#Preview {
    AddressSearchWebView(path: .constant([.regist]), url: .constant("https://gimgui.com/"))
}
