//
//  PinterestAuthView.swift
//  Stilyst
//
//  Created on 10/21/2025.
//

import SwiftUI
import SafariServices

struct PinterestAuthView: View {
    @ObservedObject var socialContentManager: SocialContentManager
    @Environment(\.presentationMode) var presentationMode
    @State private var showingSafari = false
    @State private var authURL: URL?
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                // Header
                VStack(spacing: 16) {
                    Image(systemName: "p.circle.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.stilystPrimary)
                    
                    Text("Connect Pinterest")
                        .font(.stilystTitle2)
                        .fontWeight(.bold)
                        .foregroundColor(.stilystText)
                    
                    Text("Connect your Pinterest account to access trending beauty content")
                        .font(.stilystBody)
                        .foregroundColor(.stilystSecondaryText)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                }
                
                // Status Card
                VStack(spacing: 16) {
                    HStack {
                        Image(systemName: "info.circle.fill")
                            .foregroundColor(.stilystPrimary)
                        Text("Pinterest Status")
                            .font(.stilystHeadline)
                            .foregroundColor(.stilystText)
                        Spacer()
                    }
                    
                    HStack {
                        Text(socialContentManager.pinterestStatus)
                            .font(.stilystBody)
                            .foregroundColor(.stilystSecondaryText)
                        Spacer()
                    }
                    
                    if !APIConfiguration.isPinterestConfigured {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("App ID: \(APIConfiguration.pinterestAppId)")
                                .font(.stilystCaption)
                                .foregroundColor(.stilystSecondaryText)
                            
                            Text("Status: Pending Pinterest approval")
                                .font(.stilystCaption)
                                .foregroundColor(.stilystSecondaryText)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color.stilystBorder.opacity(0.1))
                        .cornerRadius(8)
                    }
                }
                .padding()
                .background(Color.stilystSurface)
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.stilystBorder, lineWidth: 0.5)
                )
                .padding(.horizontal, 20)
                
                // Benefits
                VStack(alignment: .leading, spacing: 12) {
                    Text("What you'll get:")
                        .font(.stilystHeadline)
                        .foregroundColor(.stilystText)
                    
                    BenefitRow(icon: "flame.fill", text: "Real trending beauty styles")
                    BenefitRow(icon: "heart.fill", text: "Social engagement metrics")
                    BenefitRow(icon: "arrow.clockwise", text: "Fresh content updates")
                    BenefitRow(icon: "person.circle.fill", text: "Creator attribution")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color.stilystSurface)
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.stilystBorder, lineWidth: 0.5)
                )
                .padding(.horizontal, 20)
                
                Spacer()
                
                // Connect Button
                if APIConfiguration.isPinterestConfigured && !socialContentManager.isPinterestAuthenticated {
                    Button(action: {
                        if let url = socialContentManager.getPinterestAuthURL() {
                            authURL = url
                            showingSafari = true
                        }
                    }) {
                        HStack {
                            Image(systemName: "p.circle.fill")
                                .font(.title3)
                            Text("Connect Pinterest")
                                .font(.stilystButton)
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.stilystPrimary)
                        .cornerRadius(12)
                    }
                    .padding(.horizontal, 20)
                } else if socialContentManager.isPinterestAuthenticated {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Continue")
                            .font(.stilystButton)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.stilystPrimary)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal, 20)
                }
            }
            .padding(.vertical, 20)
            .navigationTitle("Pinterest Setup")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
        .sheet(isPresented: $showingSafari) {
            if let url = authURL {
                SafariView(url: url)
            }
        }
        .alert("Authentication", isPresented: $showingAlert) {
            Button("OK") { }
        } message: {
            Text(alertMessage)
        }
    }
}

struct BenefitRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.stilystPrimary)
                .frame(width: 24)
            
            Text(text)
                .font(.stilystBody)
                .foregroundColor(.stilystText)
            
            Spacer()
        }
    }
}

struct SafariView: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        // No updates needed
    }
}
