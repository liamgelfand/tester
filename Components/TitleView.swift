import SwiftUI

struct TitleView: View {
    var title: String = "WATO"

    var body: some View {
        VStack {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)
                .padding(.horizontal, 20)
                .foregroundColor(Color(hex: "#F5F5DC"))
            
            Spacer()

        }
        .padding(.top, 20)
        .edgesIgnoringSafeArea(.top)
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView()
    }
}

