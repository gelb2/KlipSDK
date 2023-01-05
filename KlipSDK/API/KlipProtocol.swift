//
//  KlipProtocol.swift
//  KlipSDK
//
//  Created by conan on 2020/10/07.
//  Copyright © 2020 Ground1 Corp. All rights reserved.
//

import Foundation
import UIKit

struct KlipDomain {
    private static let scheme = "https://"
    private static let paramA2ARequestKey = "/?target=/a2a?request_key="
    private static let environment = KlipSDK.shared.getEnvironment()
    
    static func create(authority: Authority, version: KlipVersion) -> String {
        let authority = environment.apiAuthority
        return scheme + authority + version.string
    }
    
    static func create(authority: Authority) -> String {
        var appLink = ""
        switch authority {
        case .linkKakao: appLink = environment.kakaoLink
        case .linkKlip: appLink = environment.klipLink
        default: break
        }
        let authority = environment.linkAuthority
        return appLink + scheme + authority + paramA2ARequestKey
    }
}

public enum KlipEnvironment {
    case prod
    
    var apiAuthority: String {
        switch self {
        case .prod:
            return "a2a-api.klipwallet.com"
        }
    }
    
    var linkAuthority: String {
        switch self {
        case .prod:
            return "klipwallet.com"
        }
    }
    
    var kakaoLink: String {
        switch self {
        case .prod:
            return "kakaotalk://klipwallet/open?url="
        }
    }
    
    var klipLink: String {
        return "klip://klipwallet/open?url="
    }
}

enum KlipVersion {
    case v1
    case v2
    
    var string: String {
        switch self {
        case .v1:
            return "/v1"
        case .v2:
            return "/v2"
        }
    }
}

enum Authority {
    case api
    case linkKakao
    case linkKlip
}
