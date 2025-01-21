////
////  AppState.swift
////  Zziik
////
////  Created by 구태호 on 1/21/25.
////
//
//import SwiftUI
//
//// MARK: 중첩 ObservableObject 구현이 안되는거 같음, 가능할 경우 구현하기
//class AppState: ObservableObject {
//    let coordinator = Coordinator()
//    let alert = CommonAlert()
//    
//    @Published
//    private var coordinatorWillChange: Void = ()
//    @Published
//    private var alertWillChange: Void = ()
//    
//    init() {
//        coordinator.objectWillChange.assign(to: &$coordinatorWillChange)
//        alert.objectWillChange.assign(to: &$alertWillChange)
//    }
//}
