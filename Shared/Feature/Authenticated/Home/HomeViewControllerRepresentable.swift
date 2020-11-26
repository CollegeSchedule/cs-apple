import SwiftUI

struct HomeViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = UINavigationController
    
    @Binding
    var isRefreshing: Bool
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UINavigationController {
        let controller: UIViewController = context.coordinator.controller
        let scroll: UIScrollView = context.coordinator.scroll
        let content: UIHostingController = context.coordinator.content
        let refresh: UIRefreshControl = context.coordinator.refresh
        let navigation: UINavigationController = .init(rootViewController: controller)
        
        // setup UIViewController
        controller.title = "Home"
        
        // setup navigation
        navigation.navigationBar.prefersLargeTitles = true
        navigation.navigationItem.largeTitleDisplayMode = .always
        
        // setup UIScrollView
        controller.view.addSubview(scroll)
        scroll.translatesAutoresizingMaskIntoConstraints = false
//        scroll.contentInsetAdjustmentBehavior = .never
        
        // setup UIStackView
        scroll.addSubview(content.view)
        
        // setup UIView
        content.view.translatesAutoresizingMaskIntoConstraints = false
        controller.extendedLayoutIncludesOpaqueBars = true
        
        // setup constraints
        NSLayoutConstraint.activate([
            scroll.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor),
            scroll.topAnchor.constraint(equalTo: controller.view.topAnchor),
            scroll.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor),
            scroll.bottomAnchor.constraint(equalTo: controller.view.bottomAnchor),
            
            content.view.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            content.view.topAnchor.constraint(equalTo: scroll.topAnchor),
            content.view.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            content.view.bottomAnchor.constraint(equalTo: scroll.bottomAnchor),
            content.view.widthAnchor.constraint(equalTo: controller.view.widthAnchor),
        ])
        
        // setup refresh
        scroll.refreshControl = refresh
        
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
    
    class Coordinator: NSObject {
        private let presentable: HomeViewControllerRepresentable
        
        let controller: NotificationViewController = .init()
        let scroll: UIScrollView = .init()
        let refresh: UIRefreshControl = .init()
        let content: UIHostingController = UIHostingController(
            rootView: HomeContentView()
        )
        
        init(_ presentable: HomeViewControllerRepresentable) {
            self.presentable = presentable
        }
        
        @objc
        func handleRefresh() {
            self.presentable.isRefreshing = true
        }
        
        @objc
        func viewWillAppear() {
            if self.refresh.isRefreshing {
                self.presentable.isRefreshing = false
            }
        }
    }
}
