//
//  SocialLoginDelegate.swift
//  Zziik
//
//  Created by 구태호 on 12/26/24.
//

protocol SocialLoginDelegate {
    func loginSucceeded(_ response: SocialLoginResponse)
    func lodinFailed(_ reason: String)
}