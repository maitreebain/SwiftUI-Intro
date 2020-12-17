//
//  Counter.swift
//  SwiftUI-Intro
//
//  Created by Maitree Bain on 12/8/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import SwiftUI

class CounterViewModel: ObservableObject {
    @Published private(set) var count = 0
    @Published var isModalPresented = false
    
    func increment() {
        count += 1
    }
    
    func decrement() {
        count -= 1
    }
    
    func reset() {
        count = 0
    }
    
    func showModal() {
        isModalPresented = true
    }
}

struct CounterView: View {
    //    @State var count = 0
    @State var isModalPresented = false
    @ObservedObject var viewModel: CounterViewModel
    var body: some View {
        
        VStack{
            HStack {
                Button(action: {
                    self.viewModel.decrement()
                }) {
                    Text("-")
                    
                }
                
                Text("\(viewModel.count)")
                
                Button(action: {
                    self.viewModel.increment()
                }) {
                    Text("+")
                    
                }
            }.padding()
            
            Button(action: {
                
                self.viewModel.reset()
            }) {
                Text("Reset")
            }
            
            Button(action: {
                
                self.isModalPresented = true
            }) {Text("Show")}.padding()
            
        }
        .sheet(isPresented: self.$isModalPresented) {
            
            NavigationView {
                ShowCountView(viewModel: self.viewModel)
            }
        }
        
    }
}

struct ShowCountView: View {
    
    @ObservedObject var viewModel: CounterViewModel
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        List {
            ForEach(0...viewModel.count, id: \.self) { index in
                Text("\(index)")
            }
        }.navigationBarItems(trailing: HStack {
            Button(action: {
                
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Done")
            }
        })
    }
}

struct Counter_Previews: PreviewProvider {
    static var previews: some View {
        CounterView(viewModel: CounterViewModel())
    }
}
