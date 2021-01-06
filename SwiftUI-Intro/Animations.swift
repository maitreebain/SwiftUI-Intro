//
//  Animations.swift
//  SwiftUI-Intro
//
//  Created by Maitree Bain on 1/6/21.
//  Copyright © 2021 Maitree Bain. All rights reserved.
//

import SwiftUI

class AnimationViewModel: ObservableObject {
    @Published var sendNotifs = false
    @Published var sendMobile = false
    @Published var sendEmail = false
}

struct Animations: View {
    @ObservedObject var viewModel: AnimationViewModel
    var body: some View {
        
        Form {
            Section(header: Text("Communication")) {
                Toggle(isOn: self.$viewModel.sendNotifs.animation()) { Text("Send notifications") }
                Group {
                    if self.viewModel.sendNotifs == true {
                        Toggle(isOn: self.$viewModel.sendMobile) {
                            Text("Mobile")
                        }
                        Toggle(isOn: self.$viewModel.sendEmail) {
                            Text("Email")
                        }
                    }
                }
                .padding(.leading)
            }
        }
    }
}

struct Animations_Previews: PreviewProvider {
    static var previews: some View {
        Animations(viewModel: AnimationViewModel())
    }
}
