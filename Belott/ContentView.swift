//
//  ContentView.swift
//  Belott
//
//  Created by Nicolas Richard on 13/01/2022.
//

import SwiftUI
import CoreData

struct ModifierNewGameButton: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(lineWidth: 2)
                .background(Colors.background_namesview.cornerRadius(10))
                .frame(width: UIScreen.main.bounds.width / 2, height: 50)
            
            content
                .font(.title)
        }
    }
}

struct ContentView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>
    


    @EnvironmentObject var viewRouter: ViewRouter
//    @EnvironmentObject var game: Game
    
//    @State var currentPage: ViewType = .main
    
//    @StateObject var viewRouter: ViewRouter
//    @State var showPopUp = false
//
//    @State var showSettings = false
//    @State var showStats = false
//
//    @State var showFirstScreen = true
    @State var blurAmount: CGFloat = 0
    
    @ObservedObject var settings = UserSettings()
    
    @AppStorage("sonActiver", store: .standard) var sonActiver: Bool = true
    @AppStorage("autolockDisabled", store: .standard) var autolockDisabled: Bool = false
    
    let width = UIScreen.main.bounds.width / 4
    let height = UIScreen.main.bounds.height / 35
    let sizeMain: CGSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.4)
    
    private var transitionMenus: AnyTransition {
        AnyTransition
            .asymmetric(insertion: .scale.combined(with: .opacity),
                       removal: .scale.combined(with: .opacity))
    }
    
    @State var showMenu: Bool = false
   
    var topbar: some View {
        HStack {
            switch viewRouter.currentView {
            case .main:
                Text("BELOTT")
                    .font(Font.custom("AutumnSeason", size: 35))
                    .offset(x: 17)
            case .game:
                Spacer().frame(height: 2)
            case .settings:
                Text("Réglages")
                    .font(Font.custom("AutumnSeason", size: 35))
                    .offset(x: 17)
            case .stats:
                Text("Stats")
                    .font(Font.custom("AutumnSeason", size: 35))
                    .offset(x: 17)
                
            }
        }
        //        HStack {
        //            Image(systemName: sonActiver ? "speaker" : "speaker.slash")
        //            Image(systemName: autolockDisabled ? "lock.open.iphone" : "lock.iphone")
        //            Spacer()
        //
        //            Spacer()
        //
        //            Text("Menu")
        //                .padding(3)
        //                .onTapGesture {
        //                    viewRouter.currentView = .main
        //                }
        //        }
        //        .padding(5)
    }
    
    
    var welcome_screen: some View {
        VStack(alignment: .center, spacing: 50) {
            Group {
                Image("playing-cards")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width / 3.5, height: UIScreen.main.bounds.height / 7)
            }
            
            Text("Bienvenue dans Belott !").font(.title2).bold()

            Text("L'application parfaite pour compter les points d'une partie de Belote.").font(.headline)
            Spacer().frame(height: 40)

            Text("Bonne partie à tous et que les meilleurs gagnent!").font(.subheadline)
            
        }
        .opacity(viewRouter.currentView == .game ? 0 : 1)
        .frame(width: sizeMain.width, height: sizeMain.height)
        .lineLimit(3)
        .multilineTextAlignment(.center)
        .blur(radius: viewRouter.currentView == .main ?  0 : 7)
        .transition(.opacity)
        .font(.footnote)
    }

    var tabbar: some View {

        ZStack {
            WaveShape()
                .fill(Colors.background_4)
                .frame(width: UIScreen.main.bounds.width + 5, height: UIScreen.main.bounds.height / 11)
                .offset(x: -5)
            
            
            HStack(alignment: .center, spacing: -15) {
                TabBarIcon(width: width, height: height, systemIconName: "gear", tabName: "Réglages")
                    .rotationEffect(Angle(degrees: viewRouter.currentView == .settings ? 40 : 0))
                    .foregroundColor(viewRouter.currentView == .settings ? .gray : .black)
                    .onTapGesture {
                        withAnimation(.easeIn(duration: 0.35)) {
                            if viewRouter.currentView == .stats  {
                                viewRouter.currentView = .main
                            } else if viewRouter.currentView == .main {
                                viewRouter.currentView = .settings
                            } else if viewRouter.currentView == .settings {
                                viewRouter.currentView = .main
                            }
                        }
                    }
//                ZStack {
//                    Circle()
//                        .foregroundColor(.white)
//                        .frame(width: width + 20, height: height + 20)
//                        .shadow(radius: 4)
//                    Image(systemName: "plus.circle.fill")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: width + 20, height: height + 20)
//                        .foregroundColor(Colors.button_plus)
//                    //                                    .rotationEffect(Angle(degrees: showPopUp ? 90 : 0))
//                }
//                .blur(radius: viewRouter.currentView == .main ? 0  : 2)
//                .offset(x: -12, y: -50)
                Text("Nouvelle Partie")
                    .modifier(ModifierNewGameButton())
                    .disabled(viewRouter.currentView == .main ? false : true)
                    .blur(radius: viewRouter.currentView == .main ? 0 : 2)
                    .offset(y: viewRouter.currentView == .main ? -120 : 30)
                    .onTapGesture {
                        withAnimation(.easeIn(duration: 0.35)){
                            if viewRouter.currentView == .main {
                                viewRouter.currentView = .game
                            }
                        }
                    }

                TabBarIcon(width: width, height: height, systemIconName: "list.triangle", tabName: "Stats")
                    .rotationEffect(Angle(degrees: viewRouter.currentView == .stats ? -50 : 0))
                    .foregroundColor(viewRouter.currentView == .stats ? .gray : .black)
                    .onTapGesture {
                        withAnimation(.easeIn(duration: 0.35)) {
                            if viewRouter.currentView == .settings  {
                                viewRouter.currentView = .main
                            } else if viewRouter.currentView == .main {
                                viewRouter.currentView = .stats
                            } else if viewRouter.currentView == .stats {
                                viewRouter.currentView = .main
                            }
                        }
                    }
            }
        
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 8)

        }
    }
    
    var body: some View {
        
        ZStack {
            switch settings.colors_theme {
            case "theme_ocean":
                AnimatedBackground(colors_theme: Colors.theme_ocean).edgesIgnoringSafeArea(.all).blur(radius: 50).ignoresSafeArea()
            case "theme_nature":
                AnimatedBackground(colors_theme: Colors.theme_nature).edgesIgnoringSafeArea(.all).blur(radius: 50).ignoresSafeArea()
            default:
                AnimatedBackground(colors_theme: Colors.theme_default).edgesIgnoringSafeArea(.all).blur(radius: 50).ignoresSafeArea()
                
            }
            // bug sur lenvironemnt object, dois fairep areil que  viewRouer
//            AnimatedBackground(colors_theme: Colors.theme_ocean).edgesIgnoringSafeArea(.all).blur(radius: 50).ignoresSafeArea()
            
            welcome_screen
                .offset(y: -70)
            ZStack {
                switch viewRouter.currentView {
                case .main: Color.clear
                case .settings: Colors.background_settings.ignoresSafeArea()
                case .stats: Colors.background_stats.ignoresSafeArea()
                case .game: Color.clear
                }
                
                VStack {
                    
                    topbar
                       
                    Spacer()
                    
                    switch viewRouter.currentView {
                    case .main:
                        Spacer()
                        
                    case .settings:
                        SettingsMainView()
                            .offset(x: viewRouter.currentView == .settings ? -2 : -UIScreen.main.bounds.width)
                            .transition(transitionMenus)
                            .opacity(viewRouter.currentView == .settings ? 0.75  : 0)
                        
                    case .stats:
                        StatsMainView()
                            .offset(x: viewRouter.currentView == .stats ? 1 : UIScreen.main.bounds.width * 2 )
                            .transition(transitionMenus)
                            .opacity(viewRouter.currentView == .stats ? 0.75  : 0)
                            .transition(.opacity)
                        
                    case .game:
                        GameView(selectionPlayer: .Default)
                            .transition(.opacity)
                    }
                    
                    if viewRouter.currentView != .game {
                        tabbar
                            .ignoresSafeArea(.all)
                            .offset(x: 2, y: 50 )
                    }
                }
//                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.1)
            }

        }
        .modifier(DismissingKeyboard())
        .onAppear {
            UIApplication.shared.isIdleTimerDisabled = autolockDisabled
        }
    }
}
            // DEBUGGING FONTS
//            for family in UIFont.familyNames.sorted() {
//                let names = UIFont.fontNames(forFamilyName: family)
//                print("Family: \(family) Font names: \(names)")
//            }
//
//    private func addItem() {
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//
//
//private let itemFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    return formatter
//}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(ViewRouter())
    }
}

struct WaveShape : Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        //        let center = CGPoint(x: rect.maxX / 2, y: rect.maxY / 2)
        
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addCurve(to: .zero,
                      control1: CGPoint(x: rect.maxX * 0.75, y: rect.maxY * 3),
                      control2: CGPoint(x: rect.maxX * 0.3, y: rect.maxY * -2))
        //        path.move(to: .zero)
        //        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        //        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        //        path.addCurve(to: CGPoint(x: rect.minX, y: rect.maxY),
        //                      control1: CGPoint(x: rect.maxX * 0.75, y: rect.maxY * 0.5),
        //                      control2: CGPoint(x: rect.maxX * 0.35, y: rect.maxY * 2))
        return path
    }
}


//        NavigationView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//                    } label: {
//                        Text(item.timestamp!, formatter: itemFormatter)
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//            Text("Select an item")
//        }
