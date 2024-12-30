//
//  SocialLoginDelegate.swift
//  Zziik
//
//  Created by 구태호 on 12/26/24.
//

protocol SocialLoginable {
    var loginHandler: ((Result<SocialLoginResponse, CommonError>) -> ()) { get set }
}
