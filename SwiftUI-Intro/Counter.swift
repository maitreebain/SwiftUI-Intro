//
//  Counter.swift
//  SwiftUI-Intro
//
//  Created by Maitree Bain on 12/8/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import SwiftUI
import Combine

class CounterViewModel: ObservableObject {
    @Published private(set) var count = 0
    @Published var isModalPresented = false
    @Published var fact: String?
    var cancellable: Cancellable?
    
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
    
    func showFact() {
        withAnimation { fact = nil }
        cancellable?.cancel()
        //http://numbersapi.com/100/trivia
        let url = URL(string: "http://numbersapi.com/\(count)/trivia")
        
//        URLSession.shared.dataTask(with: url!) { (data, response, error) in
//            guard let data = data else { return }
//            let string = String.init(decoding: data, as: UTF8.self)
//
//            DispatchQueue.main.async {
//                withAnimation { self.fact = string }
//            }
//        }.resume()
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url!)
            .map { data, _ in String(decoding: data, as: UTF8.self) }
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { string in
                    withAnimation { self.fact = string }
            })
    }
}

struct CounterView: View {
    //    @State var count = 0
    @State var isModalPresented = false
    @ObservedObject var viewModel: CounterViewModel
    var body: some View {
        VStack{
            //Label(fontSize: CGFloat(self.viewModel.count))
            HStack {
                Button(action: { self.viewModel.decrement() }) {
                    Text("-")
                }
                Text("\(viewModel.count)")
                Button(action: { self.viewModel.increment() }) {
                    Text("+")
                }
            }.padding()
            
            Button(action: { self.viewModel.reset() }) {
                Text("Reset")
            }
            
            Button(action: { self.isModalPresented = true }) {Text("Show")}.padding()
            
            Button(action: { self.viewModel.showFact() }) {
                Text("Show Fact")
            }.padding()
            
//            if let fact = self.viewModel.fact {
//            Text("\(fact)")
//            }
            self.viewModel.fact.map {
                Text($0).transition(AnyTransition.opacity.combined(with: .slide))
            }
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

struct Label: UIViewRepresentable {
    
    var fontSize: CGFloat
    let label = UILabel()
    
    func makeUIView(context: Context) -> UILabel {
//        let label = UILabel()
        label.text = "Hi"
        return label
    }
    
    func updateUIView(_ uiView: UILabel, context: Context) {
        label.font = UIFont.systemFont(ofSize: fontSize)
    }
    
    typealias UIViewType = UILabel
    
    
}

struct Counter_Previews: PreviewProvider {
    static var previews: some View {
        CounterView(viewModel: CounterViewModel())
    }
}
