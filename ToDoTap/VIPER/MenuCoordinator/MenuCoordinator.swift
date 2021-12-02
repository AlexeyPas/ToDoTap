//
//  MenuCoordinator.swift
//  ToDoTap
//
//  Created by Pasynkov Alexey on 09.06.2021.
//

import FirebaseFirestore
import UIKit

protocol MenuCoordinatorOutput: class{
    func displayLoginModule()
}

class MenuCoordinator {
    private var window: UIWindow
    private lazy var taskTabBarController = UITabBarController()
    private lazy var navigationControllers = MenuCoordinator.makeNavigationControllers()
    private var userContext: UserContext?
    
    private weak var account: AccountModuleInput?
    private weak var today: ListModuleModuleInput?
    private weak var tomorrow: TomorrowModuleInput?
    private weak var week: WeekModuleInput?
    private weak var appCoordinator: MenuCoordinatorOutput?
    
    init(context: UserContext? = nil, window: UIWindow, appParent: MenuCoordinatorOutput?){
        userContext = context
        self.appCoordinator = appParent
        self.window = window
        self.setupAppearance()

    }
    
    func setUserContext(context: UserContext?){
        self.userContext = context
//        account?.setInfo(info: context?.info)
        
    }
    
    func start(){
        self.setupTableTask()
        self.setupTomorrow()
        self.setupWeek()
        self.setupAccount()
        let navigationController = TypeNavigationController.allCases.compactMap {
            self.navigationControllers[$0]
        }
        self.taskTabBarController.setViewControllers(navigationController, animated: true)
        guard let vc = self.window.rootViewController?.children else {return}
        if vc.count > 1 {
            for item in vc {
                item.dismiss(animated: true, completion: nil)
            }
        }
        self.window.rootViewController = self.taskTabBarController
        self.window.makeKeyAndVisible()
    }
    
}

private extension MenuCoordinator {
    
    func setupTableTask() {
        guard let navigationController = self.navigationControllers[.today] else {
            fatalError("can't found navigationController")
        }
        let context = ListModuleContext(moduleOutput:  nil)
        let container = ListModuleContainer.assemble(with: context)
        today = container.input
        navigationController.setViewControllers([container.viewController], animated: false)
        container.viewController.navigationItem.title = TypeNavigationController.today.title
    }
    
    func setupTomorrow() {
        guard let navigationController = self.navigationControllers[.tomorrow] else {
            fatalError("can't found navigationController")
        }
        let context = TomorrowContext(moduleOutput:  nil)
        let container = TomorrowContainer.assemble(with: context)
        tomorrow = container.input
        navigationController.setViewControllers([container.viewController], animated: false)
        container.viewController.navigationItem.title = TypeNavigationController.tomorrow.title
    }
    
    func setupWeek() {
        guard let navigationController = self.navigationControllers[.week] else {
            fatalError("can't found navigationController")
        }
        let context = WeekContext(moduleOutput:  nil)
        let container = WeekContainer.assemble(with: context)
        week = container.input
        navigationController.setViewControllers([container.viewController], animated: false)
        container.viewController.navigationItem.title = TypeNavigationController.week.title
    }
    
    func setupAccount() {
        guard let navigationController = self.navigationControllers[.account] else {
            fatalError("can't finid navController")
        }
        let context = AccountContext(moduleOutput: self)
        let userProfileContainer = AccountContainer.assemble(with: context)
        account = userProfileContainer.input
        navigationController.setViewControllers([userProfileContainer.viewController], animated: false)
        userProfileContainer.viewController.navigationItem.title = TypeNavigationController.account.title
        
    }
    
    func setupAppearance() {
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().tintColor = .black
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().shadowImage = UIImage()
        
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().tintColor = Styles.Color.appGreen
    }
    
    static func makeNavigationControllers() -> [TypeNavigationController: UINavigationController] {
        var result: [TypeNavigationController: UINavigationController] = [:]
        TypeNavigationController.allCases.forEach{ keyNavigationController in
            let navigationController = UINavigationController()
            let tabBarItem = UITabBarItem(title: keyNavigationController.title,
                                          image: keyNavigationController.image,
                                          tag: keyNavigationController.rawValue)
            navigationController.tabBarItem = tabBarItem
            navigationController.navigationBar.prefersLargeTitles = true
            result[keyNavigationController] = navigationController
        }
        return result
    }
}

fileprivate enum TypeNavigationController: Int, CaseIterable {
    case today, tomorrow, week, account
    
    var title: String {
        switch self {
        case .today:
            return Localization.tableToday
        case .week:
            return Localization.tableWeek
        case .tomorrow:
            return Localization.tableTomorrow
        case .account:
            return Localization.account
        }
    }
    
    var image: UIImage? {
        switch self {
        case .today:
            return UIImage(named: "task")
        case .tomorrow:
            return UIImage(named: "task")
        case .week:
            return UIImage(named: "catalog")
        case .account:
            return UIImage(named: "account")
        }
    }
}

extension MenuCoordinator: AccountModuleOutput {
    func signOut() {
        appCoordinator?.displayLoginModule()
    }
}
