import SwiftUI

struct SearchView: View {
    @State
    var isRefreshing: Bool = false
    
    @ObservedObject
    private var model: SearchView.ViewModel = .init()
    
    var body: some View {
        VStack {
            SearchViewControllerRepresentable(
                isRefreshing: self.$isRefreshing,
                search: self.$model.search
            ).ignoresSafeArea()
        }
    }
}

struct SearchViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = UINavigationController
    
    @Binding
    var isRefreshing: Bool
    
    @Binding
    var search: String
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UINavigationController {
        let controller: UIViewController = context.coordinator.controller
//        let scroll: UIScrollView = context.coordinator.scroll
        let content: UIView = context.coordinator.content
        let refresh: UIRefreshControl = context.coordinator.refresh
        let search: UISearchController = context.coordinator.search
        let navigation: UINavigationController = .init(rootViewController: controller)
        
        // setup navigation
        navigation.navigationBar.prefersLargeTitles = true
        
        // setup search
        controller.navigationItem.searchController = UISearchController()
        search.searchResultsUpdater = context.coordinator
        
        // setup UIScrollView
        controller.view.addSubview(content)
//        scroll.translatesAutoresizingMaskIntoConstraints = false
        
        // setup UIView
//        scroll.addSubview(content)
        content.translatesAutoresizingMaskIntoConstraints = false
        controller.title = "Search"
        
        // setup constraints
        NSLayoutConstraint.activate([
//            scroll.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor),
//            scroll.topAnchor.constraint(equalTo: controller.view.topAnchor),
//            scroll.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor),
//            scroll.bottomAnchor.constraint(equalTo: controller.view.bottomAnchor),
            
            content.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor),
            content.topAnchor.constraint(equalTo: controller.view.topAnchor),
            content.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor),
            content.bottomAnchor.constraint(equalTo: controller.view.bottomAnchor),
            content.widthAnchor.constraint(equalTo: controller.view.widthAnchor),
        ])
        
        // setup refresh
//        scroll.refreshControl = refresh
        
        NotificationCenter.default.addObserver(
            context.coordinator,
            selector: #selector(context.coordinator.viewWillAppear),
            name: NSNotification.Name.ViewWillAppear,
            object: controller
        )
        

        
        refresh.addTarget(
            context.coordinator,
            action: #selector(context.coordinator.handleRefresh),
            for: .valueChanged
        )
        
        return navigation
    }
    
    func updateUIViewController(
        _ uiViewController: UINavigationController,
        context: Context
    ) {
        let refresh = context.coordinator.refresh
        
        if self.isRefreshing, !refresh.isRefreshing {
            refresh.beginRefreshing()
        } else if !self.isRefreshing, refresh.isRefreshing {
            refresh.endRefreshing()
        }
    }
    
    class Coordinator: NSObject, UISearchResultsUpdating {
        private let presentable: SearchViewControllerRepresentable
        
        let controller: NotificationViewController = .init()
//        let scroll: UIScrollView = .init()
        let refresh: UIRefreshControl = .init()
        let search: UISearchController = .init(searchResultsController: nil)
        let content: UIView = UIHostingController(
            rootView: SearchContentView()
        ).view
        
        init(_ presentable: SearchViewControllerRepresentable) {
            self.presentable = presentable
        }
        
        @objc
        func handleRefresh() {
            self.presentable.isRefreshing = true
        }
        @objc
        func updateSearchResults(for searchController: UISearchController) {
            self.presentable.search = searchController.searchBar.text ?? ""
        }
        
        @objc
        func viewWillAppear() {
            if self.refresh.isRefreshing {
                self.presentable.isRefreshing = false
            }
        }
    }
}

class NotificationViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.post(
            name: NSNotification.Name.ViewWillAppear,
            object: self
        )
    }
}

extension NSNotification.Name {
    static let ViewWillAppear = Notification.Name("viewWillAppear")
}

struct PlainGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            configuration.label
            configuration.content
        }
        .padding()
        
        .background(Color(.systemGray6))
        .cornerRadius(8)
//        .padding()
        
    }
}

struct SearchContentView: View {
    @ObservedObject
    private var model: SearchView.ViewModel = .init()
    
    @State
    var friends: [Int] = .init(0...100)
    
    var body: some View {
        ScrollView {
            if case APIResult.empty = self.model.teachers {
                Text("Hello")
            } else if case let APIResult.success(content) = self.model.teachers {
                if content.items.isEmpty {
                    Text("EMPTY ASF")
                } else {
                    Text("Data: \(content.items[0].firstName)")
                }
            } else if case APIResult.error = self.model.teachers {
                Text("Error")
            }
            
            ListView(self.model.teach, title: "Teachers") { item in
                GroupBox(
                    label: Label("Heart Rate", systemImage: "heart.fill")
                        .foregroundColor(.red)
                ) {
                    Text("Your hear rate is 90 BPM.")
                }.groupBoxStyle(PlainGroupBoxStyle())
                .cornerRadius(8)
                    .eraseToAnyView()
            } navigation: { item in
                SearchViewNavigationItem(account: item)
                    .eraseToAnyView()
        
            }
            ListView(self.friends, title: "Groups") { item in
                RoundedRectangle(cornerRadius: 12)
                    .overlay(
                        Text("item: \(item)")
                            .foregroundColor(.black)
                            .padding()
                    )
                    .eraseToAnyView()
            } navigation: { item in
                Text("navigation: \(item)")
                    .eraseToAnyView()
            }
        }
    }
}
