//
//  PhoneAuthService.swift
//  Stilyst
//
//  Created on 10/21/2025.
//

import Foundation
import FirebaseAuth
import UIKit

class PhoneAuthService: ObservableObject {
    @Published var verificationID: String?
    @Published var isVerificationSent = false
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var user: User?
    
    private let auth = Auth.auth()
    
    // MARK: - Send Verification Code
    func sendVerificationCode(phoneNumber: String) {
        isLoading = true
        errorMessage = nil
        
        // Format phone number for international use
        let formattedNumber = formatPhoneNumber(phoneNumber)
        
        print("📱 Sending verification code to: \(formattedNumber)")
        
        PhoneAuthProvider.provider().verifyPhoneNumber(formattedNumber, uiDelegate: nil) { [weak self] verificationID, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                if let error = error {
                    print("❌ Phone verification error: \(error.localizedDescription)")
                    self?.errorMessage = error.localizedDescription
                    return
                }
                
                guard let verificationID = verificationID else {
                    self?.errorMessage = "Failed to get verification ID"
                    return
                }
                
                print("✅ Verification code sent successfully")
                self?.verificationID = verificationID
                self?.isVerificationSent = true
            }
        }
    }
    
    // MARK: - Verify Code and Sign In
    func verifyCodeAndSignIn(code: String, completion: @escaping (Bool, String?) -> Void) {
        guard let verificationID = verificationID else {
            completion(false, "No verification ID found")
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: code)
        
        auth.signIn(with: credential) { [weak self] result, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                if let error = error {
                    print("❌ Sign in error: \(error.localizedDescription)")
                    self?.errorMessage = error.localizedDescription
                    completion(false, error.localizedDescription)
                    return
                }
                
                guard let user = result?.user else {
                    completion(false, "Failed to get user")
                    return
                }
                
                print("✅ Phone authentication successful for user: \(user.uid)")
                self?.user = user
                completion(true, nil)
            }
        }
    }
    
    // MARK: - Email/Password Authentication
    func signUpWithEmail(email: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        isLoading = true
        errorMessage = nil
        
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                if let error = error {
                    print("❌ Email sign up error: \(error.localizedDescription)")
                    self?.errorMessage = error.localizedDescription
                    completion(false, error.localizedDescription)
                    return
                }
                
                guard let user = result?.user else {
                    completion(false, "Failed to create user")
                    return
                }
                
                print("✅ Email sign up successful for user: \(user.uid)")
                self?.user = user
                completion(true, nil)
            }
        }
    }
    
    func signInWithEmail(email: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        isLoading = true
        errorMessage = nil
        
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                if let error = error {
                    print("❌ Email sign in error: \(error.localizedDescription)")
                    self?.errorMessage = error.localizedDescription
                    completion(false, error.localizedDescription)
                    return
                }
                
                guard let user = result?.user else {
                    completion(false, "Failed to sign in")
                    return
                }
                
                print("✅ Email sign in successful for user: \(user.uid)")
                self?.user = user
                completion(true, nil)
            }
        }
    }
    
    // MARK: - Sign Out
    func signOut() {
        do {
            try auth.signOut()
            user = nil
            verificationID = nil
            isVerificationSent = false
            print("✅ User signed out successfully")
        } catch {
            print("❌ Sign out error: \(error.localizedDescription)")
            errorMessage = error.localizedDescription
        }
    }
    
    // MARK: - Check Auth State
    func checkAuthState() {
        user = auth.currentUser
        if user != nil {
            print("👤 User is already signed in: \(user?.uid ?? "unknown")")
        }
    }
    
    // MARK: - Helper Methods
    private func formatPhoneNumber(_ phoneNumber: String) -> String {
        // Remove all non-digit characters
        let digits = phoneNumber.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
        // Add country code if not present (assuming US for now)
        if digits.hasPrefix("1") {
            return "+\(digits)"
        } else {
            return "+1\(digits)"
        }
    }
    
    // MARK: - Reset State
    func resetVerificationState() {
        verificationID = nil
        isVerificationSent = false
        errorMessage = nil
    }
}
