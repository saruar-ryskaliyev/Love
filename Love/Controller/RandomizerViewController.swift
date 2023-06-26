import SwiftUI

struct ContentView: View {
    @State private var isBroken = false
    let dateIdea = DateIdeas()
    let heartSymbol = "❤️"
    @State private var text = ""
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                if isBroken {
                    HStack {
                        Spacer()
                        Text(text).font(.title).fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 30)
                        Spacer()
                    }
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut(duration: 1))
                }
                else {
                    Text(heartSymbol).font(.system(size: 200))
                        .onTapGesture {
                            withAnimation {
                                self.isBroken = true
                                self.text = dateIdea.ideas.randomElement() ?? ""
                                dateIdeaCalendar = self.text
                            }
                        }
                }
                
                Spacer()
                
                if isBroken {
                    Button("Restart Animation") {
                        withAnimation {
                            self.isBroken = false
                        }
                    }
                    .padding(.bottom, 20)
                }
            }
        }
    }
}
