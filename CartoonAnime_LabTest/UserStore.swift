//``
//  UserStore.swift
//  CartoonAnime_LabTest
//
//  Created by Mach Suwanpatikorn on 23/11/2569 BE.
//

import Foundation

struct UserAccount {
    let userID: String
    let username: String
    let password: String
}

enum UserStore {

    private static let userIDKey   = "loggedInUserID"
    private static let usernameKey = "loggedInUsername"

    static func loadAccounts() -> [UserAccount] {
        guard let url = Bundle.main.url(forResource: "Users", withExtension: "plist"),
              let data = try? Data(contentsOf: url),
              let list = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [[String: String]]
        else {
            print("อ่าน Users.plist ไม่ได้")
            return []
        }
        return list.compactMap { dict in
            guard let id = dict["userID"], let name = dict["username"], let pass = dict["password"] else { return nil }
            return UserAccount(userID: id, username: name, password: pass)
        }
    }

    static func authenticate(username: String, password: String) -> UserAccount? {
        loadAccounts().first { $0.username == username && $0.password == password }
    }

    static func saveLogin(_ account: UserAccount) {
        let defaults = UserDefaults.standard
        defaults.set(account.userID, forKey: userIDKey)
        defaults.set(account.username, forKey: usernameKey)
    }

    static var currentUserID: String? {
        UserDefaults.standard.string(forKey: userIDKey)
    }

    static var currentUsername: String? {
        UserDefaults.standard.string(forKey: usernameKey)
    }
}
