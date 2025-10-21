//
//  ProviderOnboardingView.swift
//  Stilyst
//
//  Created on 10/21/2025.
//

import SwiftUI
import FirebaseAuth

struct ProviderOnboardingView: View {
    @StateObject private var viewModel = ProviderOnboardingViewModel()
    @State private var showingAuth = false
    @State private var showingCompletion = false
    @Environment(\.presentationMode) var presentationMode
    
    let totalSteps = 5
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Progress indicator
                ProgressView(value: Double(viewModel.currentStep + 1), total: Double(totalSteps))
                    .progressViewStyle(LinearProgressViewStyle(tint: .stilystPrimary))
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                
                // Step indicator
                HStack {
                    Text("Step \(viewModel.currentStep + 1) of \(totalSteps)")
                        .font(.stilystCaption)
                        .foregroundColor(.stilystSecondaryText)
                    Spacer()
                    Text(viewModel.stepTitle)
                        .font(.stilystCallout)
                        .fontWeight(.medium)
                        .foregroundColor(.stilystPrimary)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                
                // Content
                TabView(selection: $viewModel.currentStep) {
                    // Step 1: Service Category
                    ServiceCategoryStep(viewModel: viewModel)
                        .tag(0)
                    
                    // Step 2: Basic Info
                    BasicInfoStep(viewModel: viewModel)
                        .tag(1)
                    
                    // Step 3: Business Details
                    BusinessDetailsStep(viewModel: viewModel)
                        .tag(2)
                    
                    // Step 4: Specialties & Services
                    SpecialtiesStep(viewModel: viewModel)
                        .tag(3)
                    
                    // Step 5: Portfolio & Location
                    PortfolioLocationStep(viewModel: viewModel)
                        .tag(4)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                // Navigation buttons
                HStack(spacing: 16) {
                    if viewModel.currentStep > 0 {
                        Button("Back") {
                            withAnimation {
                                viewModel.currentStep -= 1
                            }
                        }
                        .foregroundColor(.stilystSecondaryText)
                    }
                    
                    Spacer()
                    
                    Button(viewModel.currentStep == totalSteps - 1 ? "Complete Setup" : "Next") {
                        if viewModel.currentStep == totalSteps - 1 {
                            viewModel.completeOnboarding()
                            showingCompletion = true
                        } else {
                            withAnimation {
                                viewModel.currentStep += 1
                            }
                        }
                    }
                    .disabled(!viewModel.canProceed)
                    .foregroundColor(.white)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(viewModel.canProceed ? Color.stilystPrimary : Color.stilystBorder)
                    .cornerRadius(25)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
            .navigationTitle("Join as a Provider")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.stilystBackground)
        }
        .sheet(isPresented: $showingAuth) {
            ProviderAuthView()
        }
        .alert("Setup Complete!", isPresented: $showingCompletion) {
            Button("Go to Dashboard") {
                presentationMode.wrappedValue.dismiss()
            }
        } message: {
            Text("Welcome to Stilyst! Your provider profile has been created successfully.")
        }
        .onAppear {
            if Auth.auth().currentUser == nil {
                showingAuth = true
            }
        }
    }
}

// MARK: - Step Views

struct ServiceCategoryStep: View {
    @ObservedObject var viewModel: ProviderOnboardingViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header
                VStack(spacing: 12) {
                    Text("What services do you offer?")
                        .font(.stilystTitle2)
                        .fontWeight(.bold)
                        .foregroundColor(.stilystText)
                        .multilineTextAlignment(.center)
                    
                    Text("Select the main category of beauty services you provide. You can add more specific services later.")
                        .font(.stilystBody)
                        .foregroundColor(.stilystSecondaryText)
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal, 20)
                
                // Service Categories Grid
                LazyVGrid(columns: [
                    GridItem(.flexible(), spacing: 16),
                    GridItem(.flexible(), spacing: 16)
                ], spacing: 16) {
                    ForEach(ServiceCategory.allCases) { category in
                        ServiceCategoryCard(
                            category: category,
                            isSelected: viewModel.selectedCategory == category
                        ) {
                            viewModel.selectedCategory = category
                        }
                    }
                }
                .padding(.horizontal, 20)
                
                // Selected Category Info
                if let selectedCategory = viewModel.selectedCategory {
                    VStack(spacing: 12) {
                        Text("Selected: \(selectedCategory.rawValue)")
                            .font(.stilystHeadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.stilystText)
                        
                        Text("Great choice! You'll be able to add specific services within this category in the next steps.")
                            .font(.stilystBody)
                            .foregroundColor(.stilystSecondaryText)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 16)
                    .background(Color.stilystPrimary.opacity(0.1))
                    .cornerRadius(12)
                    .padding(.horizontal, 20)
                }
            }
            .padding(.vertical, 20)
        }
    }
}

struct ServiceCategoryCard: View {
    let category: ServiceCategory
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 16) {
                // Icon
                Image(systemName: category.icon)
                    .font(.system(size: 32))
                    .foregroundColor(isSelected ? .white : Color.stilystPrimary)
                
                // Title
                Text(category.rawValue)
                    .font(.stilystCallout)
                    .fontWeight(.semibold)
                    .foregroundColor(isSelected ? .white : .stilystText)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 140)
            .background(
                LinearGradient(
                    colors: isSelected ? 
                        [Color.stilystPrimary, Color.stilystPrimary.opacity(0.8)] :
                        [Color.stilystSurface, Color.stilystSurface],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(
                        isSelected ? Color.clear : Color.stilystBorder,
                        lineWidth: 2
                    )
            )
            .shadow(
                color: isSelected ? Color.stilystPrimary.opacity(0.3) : Color.stilystShadow,
                radius: isSelected ? 8 : 4,
                x: 0,
                y: isSelected ? 4 : 2
            )
            .scaleEffect(isSelected ? 1.05 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: isSelected)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct BasicInfoStep: View {
    @ObservedObject var viewModel: ProviderOnboardingViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Personal Information")
                        .font(.stilystTitle2)
                        .fontWeight(.bold)
                        .foregroundColor(.stilystText)
                    
                    Text("Tell us about yourself")
                        .font(.stilystBody)
                        .foregroundColor(.stilystSecondaryText)
                }
                
                VStack(spacing: 16) {
                    // Profile Photo
                    VStack(spacing: 12) {
                        Text("Profile Photo")
                            .font(.stilystHeadline)
                            .foregroundColor(.stilystText)
                        
                        Button(action: {
                            viewModel.showImagePicker = true
                        }) {
                            if let profileImage = viewModel.profileImage {
                                Image(uiImage: profileImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 120, height: 120)
                                    .clipShape(Circle())
                                    .clipped()
                            } else {
                                Circle()
                                    .fill(Color.stilystBorder.opacity(0.3))
                                    .frame(width: 120, height: 120)
                                    .overlay(
                                        VStack(spacing: 8) {
                                            Image(systemName: "camera.fill")
                                                .font(.title2)
                                                .foregroundColor(.stilystPrimary)
                                            Text("Add Photo")
                                                .font(.stilystCaption)
                                                .foregroundColor(.stilystPrimary)
                                        }
                                    )
                            }
                        }
                    }
                    
                    // Name
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Full Name")
                            .font(.stilystHeadline)
                            .foregroundColor(.stilystText)
                        
                        TextField("Enter your full name", text: $viewModel.fullName)
                            .textFieldStyle(StilystTextFieldStyle())
                    }
                    
                    // Bio
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Bio")
                            .font(.stilystHeadline)
                            .foregroundColor(.stilystText)
                        
                        TextField("Tell clients about yourself and your experience", text: $viewModel.bio, axis: .vertical)
                            .lineLimit(3...6)
                            .textFieldStyle(StilystTextFieldStyle())
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 24)
        }
        .sheet(isPresented: $viewModel.showImagePicker) {
            ImagePicker(selectedImage: $viewModel.profileImage)
        }
    }
}

struct BusinessDetailsStep: View {
    @ObservedObject var viewModel: ProviderOnboardingViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Business Information")
                        .font(.stilystTitle2)
                        .fontWeight(.bold)
                        .foregroundColor(.stilystText)
                    
                    Text("Your business details")
                        .font(.stilystBody)
                        .foregroundColor(.stilystSecondaryText)
                }
                
                VStack(spacing: 16) {
                    // Business Name
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Business Name")
                            .font(.stilystHeadline)
                            .foregroundColor(.stilystText)
                        
                        TextField("Your barbershop or salon name", text: $viewModel.businessName)
                            .textFieldStyle(StilystTextFieldStyle())
                    }
                    
                    // Price Range
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Price Range")
                            .font(.stilystHeadline)
                            .foregroundColor(.stilystText)
                        
                        TextField("e.g., $35-$50", text: $viewModel.priceRange)
                            .textFieldStyle(StilystTextFieldStyle())
                    }
                    
                    // Phone Number
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Phone Number")
                            .font(.stilystHeadline)
                            .foregroundColor(.stilystText)
                        
                        TextField("(555) 123-4567", text: $viewModel.phoneNumber)
                            .textFieldStyle(StilystTextFieldStyle())
                            .keyboardType(.phonePad)
                    }
                    
                    // Email
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Email")
                            .font(.stilystHeadline)
                            .foregroundColor(.stilystText)
                        
                        TextField("your@email.com", text: $viewModel.email)
                            .textFieldStyle(StilystTextFieldStyle())
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 24)
        }
    }
}

struct SpecialtiesStep: View {
    @ObservedObject var viewModel: ProviderOnboardingViewModel
    
    let availableSpecialties = [
        "classic-fade", "textured-crop", "pompadour", "buzz-cut",
        "undercut", "comb-over", "fade", "beard-trimming", "styling"
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Your Specialties")
                        .font(.stilystTitle2)
                        .fontWeight(.bold)
                        .foregroundColor(.stilystText)
                    
                    Text("Select the styles you specialize in")
                        .font(.stilystBody)
                        .foregroundColor(.stilystSecondaryText)
                }
                
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 12) {
                    ForEach(availableSpecialties, id: \.self) { specialty in
                        Button(action: {
                            if viewModel.specialties.contains(specialty) {
                                viewModel.specialties.removeAll { $0 == specialty }
                            } else {
                                viewModel.specialties.append(specialty)
                            }
                        }) {
                            Text(specialty.replacingOccurrences(of: "-", with: " ").capitalized)
                                .font(.stilystCallout)
                                .foregroundColor(viewModel.specialties.contains(specialty) ? .white : .stilystPrimary)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 12)
                                .frame(maxWidth: .infinity)
                                .background(
                                    viewModel.specialties.contains(specialty) ? 
                                    Color.stilystPrimary : Color.stilystPrimary.opacity(0.1)
                                )
                                .cornerRadius(20)
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 24)
        }
    }
}

struct PortfolioLocationStep: View {
    @ObservedObject var viewModel: ProviderOnboardingViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Portfolio & Location")
                        .font(.stilystTitle2)
                        .fontWeight(.bold)
                        .foregroundColor(.stilystText)
                    
                    Text("Add your work samples and location")
                        .font(.stilystBody)
                        .foregroundColor(.stilystSecondaryText)
                }
                
                VStack(spacing: 24) {
                    // Portfolio Images
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Portfolio Images")
                            .font(.stilystHeadline)
                            .foregroundColor(.stilystText)
                        
                        Text("Add photos of your work (optional)")
                            .font(.stilystCaption)
                            .foregroundColor(.stilystSecondaryText)
                        
                        Button(action: {
                            viewModel.showPortfolioPicker = true
                        }) {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                Text("Add Portfolio Images")
                            }
                            .foregroundColor(.stilystPrimary)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.stilystPrimary.opacity(0.1))
                            .cornerRadius(12)
                        }
                    }
                    
                    // Location
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Business Location")
                            .font(.stilystHeadline)
                            .foregroundColor(.stilystText)
                        
                        VStack(spacing: 12) {
                            TextField("Address", text: $viewModel.address)
                                .textFieldStyle(StilystTextFieldStyle())
                            
                            HStack(spacing: 12) {
                                TextField("City", text: $viewModel.city)
                                    .textFieldStyle(StilystTextFieldStyle())
                                
                                TextField("State", text: $viewModel.state)
                                    .textFieldStyle(StilystTextFieldStyle())
                            }
                            
                            TextField("ZIP Code", text: $viewModel.zipCode)
                                .textFieldStyle(StilystTextFieldStyle())
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 24)
        }
        .sheet(isPresented: $viewModel.showPortfolioPicker) {
            PortfolioImagePicker(selectedImages: $viewModel.portfolioImages)
        }
    }
}

// MARK: - Supporting Views

struct StilystTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.stilystSurface)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.stilystBorder, lineWidth: 1)
            )
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct PortfolioImagePicker: View {
    @Binding var selectedImages: [UIImage]
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Portfolio Image Picker")
                    .font(.title)
                Text("This would integrate with a multi-image picker")
                    .foregroundColor(.secondary)
                Button("Done") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .padding()
        }
    }
}

// MARK: - ViewModel

class ProviderOnboardingViewModel: ObservableObject {
    @Published var selectedCategory: ServiceCategory? = nil
    @Published var fullName = ""
    @Published var bio = ""
    @Published var businessName = ""
    @Published var priceRange = ""
    @Published var phoneNumber = ""
    @Published var email = ""
    @Published var specialties: [String] = []
    @Published var address = ""
    @Published var city = ""
    @Published var state = ""
    @Published var zipCode = ""
    @Published var profileImage: UIImage?
    @Published var portfolioImages: [UIImage] = []
    @Published var showImagePicker = false
    @Published var showPortfolioPicker = false
    
    var stepTitle: String {
        switch currentStep {
        case 0: return "Service Category"
        case 1: return "Basic Info"
        case 2: return "Business Details"
        case 3: return "Specialties"
        case 4: return "Portfolio & Location"
        default: return ""
        }
    }
    
    @Published var currentStep: Int = 0
    
    var canProceed: Bool {
        switch currentStep {
        case 0: return selectedCategory != nil
        case 1: return !fullName.isEmpty && !bio.isEmpty
        case 2: return !businessName.isEmpty && !priceRange.isEmpty
        case 3: return !specialties.isEmpty
        case 4: return !address.isEmpty && !city.isEmpty
        default: return false
        }
    }
    
    func completeOnboarding() {
        print("Completing onboarding...")
        
        // Mark that user has completed provider onboarding
        UserDefaults.standard.set(true, forKey: "hasCompletedProviderOnboarding")
        
        // TODO: Save provider data to Firebase
        // For now, just dismiss the onboarding
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // This would normally save to Firebase and then dismiss
            print("✅ Provider onboarding completed successfully!")
        }
    }
}

struct ProviderAuthView: View {
    @StateObject private var authService = PhoneAuthService()
    @State private var email = ""
    @State private var password = ""
    @State private var phoneNumber = ""
    @State private var verificationCode = ""
    @State private var isSignUp = false
    @State private var authMethod: AuthMethod = .phone
    @Environment(\.presentationMode) var presentationMode
    
    enum AuthMethod {
        case phone, email
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 8) {
                        Text("Join as a Provider")
                            .font(.stilystTitle2)
                            .fontWeight(.bold)
                            .foregroundColor(.stilystText)
                        
                        Text("Choose your preferred sign-in method")
                            .font(.stilystBody)
                            .foregroundColor(.stilystSecondaryText)
                    }
                    
                    // Auth Method Selector
                    Picker("Authentication Method", selection: $authMethod) {
                        Text("Phone").tag(AuthMethod.phone)
                        Text("Email").tag(AuthMethod.email)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    
                    if authMethod == .phone {
                        PhoneAuthView()
                    } else {
                        EmailAuthView()
                    }
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
        .environmentObject(authService)
    }
    
    @ViewBuilder
    private func PhoneAuthView() -> some View {
        VStack(spacing: 16) {
            if !authService.isVerificationSent {
                // Phone Number Input
                VStack(alignment: .leading, spacing: 8) {
                    Text("Phone Number")
                        .font(.stilystHeadline)
                        .foregroundColor(.stilystText)
                    
                    TextField("(555) 123-4567", text: $phoneNumber)
                        .textFieldStyle(StilystTextFieldStyle())
                        .keyboardType(.phonePad)
                }
                
                Button(action: {
                    authService.sendVerificationCode(phoneNumber: phoneNumber)
                }) {
                    if authService.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    } else {
                        Text("Send Verification Code")
                    }
                }
                .disabled(phoneNumber.isEmpty || authService.isLoading)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(phoneNumber.isEmpty ? Color.stilystBorder : Color.stilystPrimary)
                .cornerRadius(12)
                
            } else {
                // Verification Code Input
                VStack(alignment: .leading, spacing: 8) {
                    Text("Verification Code")
                        .font(.stilystHeadline)
                        .foregroundColor(.stilystText)
                    
                    Text("Enter the 6-digit code sent to \(phoneNumber)")
                        .font(.stilystCaption)
                        .foregroundColor(.stilystSecondaryText)
                    
                    TextField("123456", text: $verificationCode)
                        .textFieldStyle(StilystTextFieldStyle())
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.center)
                        .font(.title2)
                        .fontWeight(.bold)
                }
                
                HStack(spacing: 12) {
                    Button("Resend Code") {
                        authService.resetVerificationState()
                    }
                    .foregroundColor(.stilystPrimary)
                    
                    Button(action: {
                        authService.verifyCodeAndSignIn(code: verificationCode) { success, error in
                            if success {
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                    }) {
                        if authService.isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        } else {
                            Text("Verify & Sign In")
                        }
                    }
                    .disabled(verificationCode.isEmpty || authService.isLoading)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(verificationCode.isEmpty ? Color.stilystBorder : Color.stilystPrimary)
                    .cornerRadius(12)
                }
            }
            
            // Error Message
            if let errorMessage = authService.errorMessage {
                Text(errorMessage)
                    .font(.stilystCaption)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
            }
        }
    }
    
    @ViewBuilder
    private func EmailAuthView() -> some View {
        VStack(spacing: 16) {
            TextField("Email", text: $email)
                .textFieldStyle(StilystTextFieldStyle())
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
            
            SecureField("Password", text: $password)
                .textFieldStyle(StilystTextFieldStyle())
            
            Button(action: {
                if isSignUp {
                    authService.signUpWithEmail(email: email, password: password) { success, error in
                        if success {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                } else {
                    authService.signInWithEmail(email: email, password: password) { success, error in
                        if success {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            }) {
                if authService.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                } else {
                    Text(isSignUp ? "Sign Up" : "Sign In")
                }
            }
            .disabled(email.isEmpty || password.isEmpty || authService.isLoading)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(email.isEmpty || password.isEmpty ? Color.stilystBorder : Color.stilystPrimary)
            .cornerRadius(12)
            
            Button(isSignUp ? "Already have an account? Sign In" : "Need an account? Sign Up") {
                isSignUp.toggle()
            }
            .foregroundColor(.stilystPrimary)
            
            // Error Message
            if let errorMessage = authService.errorMessage {
                Text(errorMessage)
                    .font(.stilystCaption)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
            }
        }
    }
}

#Preview {
    ProviderOnboardingView()
}
