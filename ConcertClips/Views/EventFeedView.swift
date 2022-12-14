import SwiftUI

struct EventFeedView: View {
    @State var eventName: String
    @ObservedObject var clipsManagerViewModel = ClipsManagerViewModel()
    
    private var concertImageBackground: some View {
        GeometryReader { geometry in
            Image("no_clips_yet_v1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: geometry.size.width)
        }
    }
    
    var body: some View {
        concertImageBackground.overlay(
            VStack {
                HStack(alignment: .lastTextBaseline) {
                    Text("\(eventName)").fontWeight(.bold).foregroundColor(.white).padding(.top)
                    Text("|").foregroundColor(.white).padding(.top)
                    NavigationLink {
                        EventSectionView(eventName: eventName, clips: clipsManagerViewModel.clipViewModels.map({ $0.clip }))
                    } label: {
                        Text("Sections").padding(.top)
                    }
                    Text("|").foregroundColor(.white).padding(.top)
                    NavigationLink {
                        EventDateView(moveToFeedView: false, eventName: eventName)
                    } label: {
                        Label("", systemImage: "calendar")
                    }
                }
                EventFeedViewRepresentable(eventName: eventName).ignoresSafeArea()
            }
        ).background(.black)
    }
}
