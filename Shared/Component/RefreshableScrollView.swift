import SwiftUI

struct RefreshableScrollView<Content: View>: View {
    @Binding
    var refreshing: Bool
    
    @State
    var isSearch: Bool = false
    
    @State
    private var frozen: Bool = false
    
    @State
    private var scrollOffset: CGFloat = 0
    
    @State
    private var rotation: Angle = .degrees(0)
    
    @State
    private var previousScrollOffset: CGFloat = 0
    
    let content: Content
    let action: () -> Void
    
    private var threshold: CGFloat = 280
    
    init(
        height: CGFloat = 80,
        refreshing: Binding<Bool>,
        action: @escaping () -> Void,
        @ViewBuilder content: () -> Content
    ) {
        self.threshold = height
        self._refreshing = refreshing
        self.content = content()
        self.action = action
    }

    var body: some View {
        VStack {
            ScrollView {
                ZStack(alignment: .top) {
                    MovingView()

                    VStack {
                        self.content
//                            .animation(
//                                (self.refreshing && self.frozen) ? nil : .easeIn
//                            )
                    }.alignmentGuide(
                        .top,
                        computeValue: { _ in
                            (self.refreshing && self.frozen)
                                ? -self.threshold
                                : 0.0
                            
                        }
                    )

                    SymbolView(
                        height: self.threshold,
                        loading: self.refreshing,
                        frozen: self.frozen,
                        rotation: self.rotation,
                        isSearch: self.isSearch
                    )
                }
            }
            .background(FixedView())
            .onPreferenceChange(RefreshableKeyTypes.PrefKey.self) { values in
                self.refreshLogic(values: values)
            }
        }
    }

    func refreshLogic(values: [RefreshableKeyTypes.PrefData]) {
        DispatchQueue.main.async {
            let movingBounds = values.first {
                $0.vType == .movingView
            }?.bounds ?? .zero
            
            let fixedBounds = values.first {
                $0.vType == .fixedView
            }?.bounds ?? .zero

            self.scrollOffset  = movingBounds.minY - fixedBounds.minY

            if !self.refreshing,
               self.scrollOffset > self.threshold,
               self.previousScrollOffset <= self.threshold {
                self.refreshing = true
            }

            if self.refreshing {
                if self.previousScrollOffset > self.threshold,
                   self.scrollOffset <= self.threshold {
                    self.frozen = true
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.refreshing = false
                    }
                }
            } else {
                self.frozen = false
            }
            
            self.previousScrollOffset = self.scrollOffset
        }
    }
    
    struct SymbolView: View {
        var height: CGFloat
        var loading: Bool
        var frozen: Bool
        var rotation: Angle
        var isSearch: Bool
            
        var body: some View {
            Group {
                VStack {
                    Spacer()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                    Spacer()
                }
                .frame(height: height)
                .fixedSize()
//                .opacity((self.loading && self.frozen) ? 1.0 : 0.0)
                .offset(y: -height + (self.loading && self.frozen ? height : 0))
//                .animation(.easeInOut(duration: 0.2))
            }
        }
    }

    struct MovingView: View {
        var body: some View {
            GeometryReader { proxy in
                Color
                    .clear
                    .preference(
                        key: RefreshableKeyTypes.PrefKey.self,
                        value: [
                            RefreshableKeyTypes.PrefData(
                                vType: .movingView,
                                bounds: proxy.frame(in: .global)
                            )
                        ]
                    )
            }.frame(height: 0)
        }
    }

    struct FixedView: View {
        var body: some View {
            GeometryReader { proxy in
                Color
                    .clear
                    .preference(
                        key: RefreshableKeyTypes.PrefKey.self,
                        value: [
                            RefreshableKeyTypes.PrefData(
                                vType: .fixedView,
                                bounds: proxy.frame(in: .global)
                            )
                        ]
                    )
            }
        }
    }
}


struct RefreshableKeyTypes {
    enum ViewType: Int {
        case movingView
        case fixedView
    }

    struct PrefData: Equatable {
        let vType: ViewType
        let bounds: CGRect
    }

    struct PrefKey: PreferenceKey {
        
        static var defaultValue: [PrefData] = []

        static func reduce(
            value: inout [PrefData],
            nextValue: () -> [PrefData]
        ) {
            value.append(
                contentsOf: nextValue()
            )
        }
    }
}

struct ActivityRep: UIViewRepresentable {
    
    func makeUIView(
        context: UIViewRepresentableContext<ActivityRep>
    ) -> UIActivityIndicatorView {
        return UIActivityIndicatorView()
    }

    func updateUIView(
        _ uiView: UIActivityIndicatorView,
        context: UIViewRepresentableContext<ActivityRep>
    ) {
        uiView.startAnimating()
    }
}

