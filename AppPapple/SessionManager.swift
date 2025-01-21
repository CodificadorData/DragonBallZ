//
//  SessionManager.swift
//  AppPapple
//
//  Created by Christian Morante on 14/01/25.
//
import UIKit

class SessionManager {
    static let shared = SessionManager() // Singleton
    private let userKey = "currentUser"

    private init() {}

    // Iniciar sesión guardando datos del usuario
    func loginUser(userID: String) {
        UserDefaults.standard.set(userID, forKey: userKey)
        UserDefaults.standard.synchronize()
    }

    // Verificar si hay una sesión activa
    func isUserLoggedIn() -> Bool {
        return UserDefaults.standard.string(forKey: userKey) != nil
    }

    // Obtener el ID del usuario
    func getCurrentUserID() -> String? {
        return UserDefaults.standard.string(forKey: userKey)
    }

    // Cerrar sesión eliminando los datos
    func logoutUser() {
        UserDefaults.standard.removeObject(forKey: userKey)
        UserDefaults.standard.synchronize()
    }
}

// Ejemplo de uso:
//let sessionManager = SessionManager.shared
//sessionManager.loginUser(userID: "12345") // Iniciar sesión
//if sessionManager.isUserLoggedIn() {
//    print("El usuario está logueado. ID: \(sessionManager.getCurrentUserID()!)")
//} else {
//    print("No hay sesión activa.")
//}
//sessionManager.logoutUser() // Cerrar sesión

