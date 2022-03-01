//
//  ContentView.swift
//  Example
//
//  Created by Alisa Mylnikova on 23/04/2020.
//  Copyright © 2020 Exyte. All rights reserved.
//

import SwiftUI
import ExytePopupView

struct ExampleButton : View {

    @Binding var showing: Bool
    var title: String
    var hideAll: ()->()

    var body: some View {
        Button {
            hideAll()
            showing.toggle()
        } label: {
            Text(title)
                .foregroundColor(.black)
        }
    }
}

struct TestView : View {

    let bgColor = Color(hex: 0xe0fbfc)
    let popupColor = Color(hex: 0x3d5a80)
    let topToastColor = Color(hex: 0x293241)
    let bottomToastColor = Color(hex: 0x98c1d9)
    let topFloatColor = Color(hex: 0x293241)
    let bottomFloatColor = Color(hex: 0xee6c4d)
    let cardColor = Color(hex: 0x3d5a80)

    @State var showingDraggableCard = false

    var body: some View {

        let hideAll = {
            self.showingDraggableCard = false
        }

        ZStack {
            bgColor
            VStack(spacing: 15) {
                Text("testing")

                ExampleButton(showing: $showingDraggableCard, title: "Draggable card", hideAll: hideAll)
            }
        }
        .edgesIgnoringSafeArea(.all)

        .popup(isPresented: $showingDraggableCard, type: .toast, position: .bottom) {
            createDraggableCard()
        }

    }

    func createDraggableCard() -> some View {
        DraggableCardView(bgColor: cardColor) {
            VStack(spacing: 10) {
                Text("Weasels")
                    .foregroundColor(.white)
                    .fontWeight(.bold)

                Text(Constants.shortText)
                    .font(.system(size: 14))
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 20)
        }
    }

}

struct DraggableCardView<Content: View>: View {

    let content: Content
    let topPadding: CGFloat
    let fixedHeight: Bool
    let bgColor: Color

    init(topPadding: CGFloat = 100, fixedHeight: Bool = false, bgColor: Color = .white, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.topPadding = topPadding
        self.fixedHeight = fixedHeight
        self.bgColor = bgColor
    }

    var body: some View {
        ZStack {
            bgColor.cornerRadius(40, corners: [.topLeft, .topRight])
            VStack {
                Color.white
                    .frame(width: 72, height: 6)
                    .clipShape(Capsule())
                    .padding(.top, 15)
                    .padding(.bottom, 10)

                content
                    .padding(.bottom, 30)
                    .applyIf(fixedHeight) {
                        $0.frame(height: UIScreen.main.bounds.height - topPadding)
                    }
                    .applyIf(!fixedHeight) {
                        $0.frame(maxHeight: UIScreen.main.bounds.height - topPadding)
                    }
            }
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}


class Constants {

    static let shortText = """
                     Weasels /ˈwiːzəl/ are mammals of the genus Mustela of the family Mustelidae. The genus Mustela includes the least weasels, polecats, stoats, ferrets and mink. Members of this genus are small, active predators, with long and slender bodies and short legs. The family Mustelidae, or mustelids, (which also includes badgers, otters, and wolverines) is often referred to as the "weasel family". In the UK, the term "weasel" usually refers to the smallest species, the least weasel (M. nivalis),[1] the smallest carnivoran species.[2]
                     Weasels vary in length from 173 to 217 mm (6+3⁄4 to 8+1⁄2 in),[3] females being smaller than the males, and usually have red or brown upper coats and white bellies; some populations of some species moult to a wholly white coat in winter. They have long, slender bodies, which enable them to follow their prey into burrows. Their tails may be from 34 to 52 mm (1+1⁄4 to 2 in) long.[3]
                     """

    static let longText = """
                     A mongoose is a small terrestrial carnivorous mammal belonging to the family Herpestidae. This family is currently split into two subfamilies, the Herpestinae and the Mungotinae. The Herpestinae comprises 23 living species that are native to southern Europe, Africa and Asia, whereas the Mungotinae comprises 11 species native to Africa.[2] The Herpestidae originated about 21.8 ± 3.6 million years ago in the Early Miocene and genetically diverged into two main genetic lineages between 19.1 and 18.5 ± 3.5 million years ago.[3]
                     The English word \"mongoose\" used to be spelled \"mungoose\" in the 18th and 19th centuries. The name is derived from names used in India for Herpestes species:[4][5][6][7] muṅgūs or maṅgūs in classical Hindi;[8] muṅgūsa in Marathi;[9] mungisa in Telugu;[10] mungi, mungisi and munguli in Kannada.[11]
                     The form of the English name (since 1698) was altered to its "-goose" ending by folk etymology.[12] The plural form is "mongooses".[13]
                     Mongooses have long faces and bodies, small, rounded ears, short legs, and long, tapering tails. Most are brindled or grizzly; a few have strongly marked coats which bear a striking resemblance to mustelids. Their nonretractile claws are used primarily for digging. Mongooses, much like goats, have narrow, ovular pupils. Most species have a large anal scent gland, used for territorial marking and signaling reproductive status. They range from 24 to 58 cm (9.4 to 22.8 in) in head-to-body length, excluding the tail. In weight, they range from 320 g (11 oz) to 5 kg (11 lb).[14]
                     Mongooses are one of at least four known mammalian taxa with mutations in the nicotinic acetylcholine receptor that protect against snake venom.[15] Their modified receptors prevent the snake venom α-neurotoxin from binding. These represent four separate, independent mutations. In the mongoose, this change is effected, uniquely, by glycosylation.[16]
                     Herpestina was a scientific name proposed by Charles Lucien Bonaparte in 1845 who considered the mongooses a subfamily of the Viverridae.[17] In 1864, John Edward Gray classified the mongooses into three subfamilies: Galidiinae, Herpestinae and Mungotinae.[18] This grouping was supported by Reginald Innes Pocock in 1919, who referred to the family as "Mungotidae".[19]
                     Genetic research based on nuclear and mitochondrial DNA analyses revealed that the Galidiinae are more closely related to Madagascar carnivores, including the fossa and Malagasy civet.[20][21] Galidiinae is presently considered a subfamily of Eupleridae.[22]
                     """
}
