//
//  ContactUsView.swift
//  StoreHelper
//
//  Created by Russell Archer on 02/12/2022.
//

import SwiftUI
import StoreKit

/// Allows the user to open the `Configuration.contactUsUrl` (if any) for support.
@available(iOS 15.0, macOS 12.0, *)
public struct ContactUsView: View {
    @EnvironmentObject var storeHelper: StoreHelper
    @Environment(\.openURL) var openURL
    
    public init() {}
    
    public var body: some View {
        if let sContactUrl = Configuration.contactUsUrl.stringValue(storeHelper: storeHelper), let contactUrl = URL(string: sContactUrl) {
            Button(action: { openURL(contactUrl)}) {
                Label(title: { BodyFont(scaleFactor: storeHelper.fontScaleFactor) {
                    let contactUsButtonText = Configuration.contactUsButtonText.stringValue(storeHelper: storeHelper) ?? "Contact Us"
                    Text(contactUsButtonText)
                }.padding([.top, .bottom, .trailing])},
                      icon:  { Image(systemName: "bubble.right").bodyImageNotRounded().frame(height: 24).padding(.leading)})
            }
            #if os(iOS)
            .xPlatformButtonStyleBorderless()
            #else
            .xPlatformButtonStyleBorderedProminent()
            #endif
            .padding([.top, .leading, .trailing])
            
//            CaptionFont(scaleFactor: storeHelper.fontScaleFactor) { Text("Want to talk to us? \(Utils.confirmGestureText()) \"Contact Us\" to open a web page with support and contact information.")}
//                .multilineTextAlignment(.center)
//                .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
//                .foregroundColor(.secondary)
        }
    }
}

