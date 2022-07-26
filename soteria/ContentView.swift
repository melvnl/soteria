//
//  ContentView.swift
//  soteria
//
//  Created by melvin on 25/07/22.
//

import SwiftUI
import CoreLocation

struct HomeView: View {
    @State private var showingAlert = false
    
    func sendAlert() {
        let phoneNumber = UserDefaults.standard.string(forKey: "phoneNumber") ?? "0"
        
        if(phoneNumber == "0")
        {
            showingAlert = !showingAlert
        }
        else{
            if let url = URL(string: "https://api.whatsapp.com/send/?phone=\( phoneNumber)&text=Help!%20Sender%20Sedang%20Dalam%20Masalah!&type=phone_number&app_absent=0"),
                    
                    UIApplication.shared.canOpenURL(url) {
                       UIApplication.shared.open(url, options: [:])
                    }
        }
    }
    
    var body: some View {
        let heading = "Send Help!"
        let desc = "Tap button to send alert message and your current location to spesific whatsapp number"
        
        NavigationView {
            ZStack {
                VStack {
                    Text(heading)
                        .font(.system(size: 36, weight: .bold, design: .default))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 12)
                    Text(desc)
                        .font(.system(size: 18, weight: .regular, design: .default))
                        .multilineTextAlignment(.center)
                        .padding(.trailing, 20)
                        .padding(.leading, 20)
                        .padding(.bottom, 40)
                    Button(action: {
                        sendAlert()
                    }) {
                                Image("bell")
                            }
                    .alert(isPresented: $showingAlert) {
                                Alert(title: Text("Empty Phone Number"), message: Text("Input your destinated phone number in contact screen"), dismissButton: .default(Text("Close")))
                            }
                }
            }
        }
    }
}

struct ContactView: View {
    
    @State var destinationNumber = UserDefaults.standard.string(forKey: "phoneNumber") ?? ""
    @State private var showingAlert = false
    
    var heading = "Enter Destinated WhatsApp Number"
    var desc = "Tap button to send alert message and your current location to destinated email"
    var placeholder = "ex: 6281908816833"
    var callToActionText = "Save"
    
    func saveData() {
        
        if(destinationNumber == "")
        {
            showingAlert = !showingAlert
        }
        else{
            print("lol")
            UserDefaults.standard.set(destinationNumber, forKey: "phoneNumber")
             }
        }
    
    var body: some View {
        NavigationView {
            ZStack {
                
                VStack {
                    Text(heading)
                        .font(.system(size: 36, weight: .bold, design: .default))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 20)
                    Text(desc)
                        .font(.system(size: 18, weight: .regular, design: .default))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 80)
                    TextField(placeholder, text: $destinationNumber)
                        .background(Color.white)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.system(size: 16, weight: .semibold, design: .default))
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                        
                    
                    Button( action: {
                        saveData()
                    }, label: {
                        Text(callToActionText)
                            .font(.system(size: 16, weight: .semibold, design: .default))
                            .frame(width: 350, height: 48, alignment: .center)
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    )
                    .alert(isPresented: $showingAlert) {
                                Alert(title: Text("Input Phone Number"), message: Text("Input your destinated Phone Number and tap Save button"), dismissButton: .default(Text("Close")))
                            } 
                }
            }
            
        }
    }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "bell")
                    Text("Alert")
                }
            ContactView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Contact")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
