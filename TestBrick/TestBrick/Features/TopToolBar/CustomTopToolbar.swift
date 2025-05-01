//
//  CustomTopToolbar.swift
//  TestBrick
//
//  Created by Habibur Rahman on 1/5/25.
//

import SwiftUI

struct CustomTopToolbar: View {
    @Environment(\.dismiss) private var dismiss

    // Customizable inputs
    var showBackButton: Bool = true
    // var icon: Image? = nil
    var title: String? = nil
    var backAction: (() -> Void)? = nil

    var body: some View {
        HStack(spacing: 12) {
            // Back Button
            if showBackButton {
                Button(action: {
                    if let customAction = backAction {
                        customAction()
                    } else {
                        dismiss()
                    }
                }) {
                    HStack(spacing: 6) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20).bold())
                            .foregroundColor(.white)
                        if let title = title {
                            Text(title)
                                .font(.system(size: 17, weight: .semibold))
                        }
                    }
                    .foregroundColor(.white)
                }
            }
        }
        .background(Color.clear)
    }
}

#Preview {
    VStack(spacing: 0) {
        CustomTopToolbar(
            showBackButton: true,
            title: "Back"
        ) {
            print("Preview back action")
        }
        Spacer()
    }
    .ignoresSafeArea(edges: .top)
}
