//
//  SwiftUIView.swift
//  StoreHelper
//
//  Created by Russell Archer on 16/11/2022.
//

import SwiftUI

/// Displays links for terms of service and privacy policy
@available(iOS 15.0, macOS 12.0, *)
public struct TermsOfServiceAndPrivacyPolicyView: View {
    @EnvironmentObject var storeHelper: StoreHelper
    @State private var termsOfServiceUrl: URL?
    @State private var privacyPolicyUrl: URL?
    
    public init() {}
    
    public var body: some View {
        VStack(spacing:10){
            HStack {
                let termsOfServiceText = Configuration.termsOfServiceButtonText.stringValue(storeHelper: storeHelper) ?? "Terms of Service"
                let privacyPolicyText = Configuration.privacyPolicyButtonText.stringValue(storeHelper: storeHelper) ?? "Privacy Policy"
                
                if let termsOfServiceUrl { Link(termsOfServiceText, destination: termsOfServiceUrl) }
                if termsOfServiceUrl != nil, privacyPolicyUrl != nil { Text("and") }
                if let privacyPolicyUrl { Link(privacyPolicyText, destination: privacyPolicyUrl) }
            }
            VStack(alignment: .leading){
                Text("自動継続課金")
                    .fontWeight(.semibold)
                Text("サブスクリプションの契約期間は、期限が切れる24時間以内に自動更新の解除をされない場合、自動更新されます。")
                    .fontWeight(.regular)
            }.padding(.top, 8)
        }.padding()
        
        .task {
            if  let termsOfService = Configuration.termsOfServiceUrl.stringValue(storeHelper: storeHelper),
                let tosUrl = URL(string: termsOfService) { termsOfServiceUrl = tosUrl }
            
            if  let privacyPolicy = Configuration.privacyPolicyUrl.stringValue(storeHelper: storeHelper),
                let ppUrl = URL(string: privacyPolicy) { privacyPolicyUrl =  ppUrl }
        }
    }
}
