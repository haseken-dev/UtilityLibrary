//
//  LocalAuthenticationUtility.swift
//  SuicaReaderFramework
//
//  Created by haseken-dev on 2020/01/22.
//  Copyright © 2020 haseken-dev. All rights reserved.
//

import Foundation
import LocalAuthentication

public struct LocalAuthenticationUtility {
    public enum AuthenticateError: Error {
        case cannotEvaluatePolicy(NSError?)
        case failAuthenticate(Error?)
    }
    
    private static let context = LAContext()
    
    public static func canEvaluatePolicy() -> NSError? {
        var error: NSError?
        guard context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) else {
            return error
        }
        return nil
    }
    
    /// Face ID/Touch IDの認証開始します。利用できるかどうかの確認も行います。
    /// - Parameters:
    ///   - description: 認証画面で表示される文言です。
    ///   - complication: 認証完了・失敗時に実行します。
    public static func authenticate(localizedReason description: String = "認証",
                                    complication: @escaping ((Result<Bool, AuthenticateError>) -> Void)) {
        if let evaluateError = LocalAuthenticationUtility.canEvaluatePolicy() {
            complication(.failure(.cannotEvaluatePolicy(evaluateError)))
            return
        }
        
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: description) { (success, error) in
            guard error == nil else {
                complication(.failure(.failAuthenticate(error)))
                return
            }
            
            complication(.success(success))
        }
    }
}
