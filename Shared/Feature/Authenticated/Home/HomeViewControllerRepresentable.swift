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
        let stack: UIStackView = context.coordinator.stack
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
        stack.translatesAutoresizingMaskIntoConstraints = false
        scroll.addSubview(stack)
        
        // setup UIView
        controller.addChild(content)
        stack.addArrangedSubview(content.view)
        content.didMove(toParent: controller)
        
        content.view.translatesAutoresizingMaskIntoConstraints = false
        
        stack.backgroundColor = .blue
        controller.extendedLayoutIncludesOpaqueBars = true
        
        
        // setup constraints
        NSLayoutConstraint.activate([
            scroll.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor),
            scroll.topAnchor.constraint(equalTo: controller.view.topAnchor),
            scroll.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor),
            scroll.bottomAnchor.constraint(equalTo: controller.view.bottomAnchor),
            
            stack.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            stack.topAnchor.constraint(equalTo: scroll.topAnchor),
            stack.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: scroll.bottomAnchor),
            stack.widthAnchor.constraint(equalTo: controller.view.safeAreaLayoutGuide.widthAnchor),
            
            content.view.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            content.view.topAnchor.constraint(equalTo: stack.topAnchor),
            content.view.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
            content.view.bottomAnchor.constraint(equalTo: stack.bottomAnchor),
            content.view.widthAnchor.constraint(equalTo: controller.view.safeAreaLayoutGuide.widthAnchor),
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
        let stack: UIStackView = .init()
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
