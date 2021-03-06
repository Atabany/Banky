//
//  AccountSummaryVC.swift
//  Banky
//
//  Created by Mohamed Elatabany on 15/03/2022.
//

import Foundation

import UIKit

class AccountSummaryViewController: UIViewController {
    
    
    // Request Models
    var profile: Profile?
    var accounts: [Account] = []
    
    // View Models
    var profileViewModel: AccountSummaryHeaderView.ViewModel = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Good Morning", name: "", date: Date())
    var accountCellViewModels = [AccountSummaryCell.ViewModel]()
    
    
    
    
    // UI Components
    var headerView = AccountSummaryHeaderView(frame: .zero)
    var tableView = UITableView()
    let refreshControl = UIRefreshControl()
    lazy var logoutBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
        barButtonItem.tintColor = .label
        return barButtonItem
    }()
    
    // Networking
    var profileManger: ProfileManageable = ProfileManager()
    var isLoaded = false
    
    // Error Alert
    lazy var errorAlert: UIAlertController = {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        return alert
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

}


extension AccountSummaryViewController {
    private func setup() {
        setupTableView()
        setupTableHeaderView()
        setupRefreshControl()
        setupSkeletons()
        fetchData()
        setupNavigationBar()
        if let navigationController = self.navigationController {
            hideNavigationBarLine(navigationController.navigationBar, color: K.colors.appColor)
        }
        
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = K.colors.appColor
        
        
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseID)
        tableView.register(SkeletonCell.self, forCellReuseIdentifier: SkeletonCell.reuseID)
        tableView.rowHeight = AccountSummaryCell.rowHeight
        tableView.tableFooterView = UIView()
        
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    private func setupTableHeaderView() {
        var size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        headerView.frame.size = size
        tableView.tableHeaderView = headerView
    }
    
    func setupNavigationBar() {
        navigationItem.rightBarButtonItem = logoutBarButtonItem
    }
    
    
    func setupRefreshControl() {
        refreshControl.tintColor = .secondaryLabel
        refreshControl.addTarget(self, action: #selector(refreshContent), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    func setupSkeletons() {
        let row = Account.makeSkeleton()
        accounts = Array(repeating: row, count: 10)
        configureTableCells(with: accounts)
    }
    
}




//MARK: - UITableView DataSource & Delegate
extension AccountSummaryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !accountCellViewModels.isEmpty else {return UITableViewCell()}
        if isLoaded {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseID, for: indexPath) as? AccountSummaryCell else {return  UITableViewCell()}
            cell.configure(with: accountCellViewModels[indexPath.row])
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SkeletonCell.reuseID, for: indexPath) as? SkeletonCell else {return UITableViewCell()}
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountCellViewModels.count
    }
}

extension AccountSummaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}



//MARK: - Networking
extension AccountSummaryViewController {
    private func fetchData() {
        let group = DispatchGroup()
        // Testing - random number selection
        let userId = String(Int.random(in: 1...3))
        
        fetchProfile(group: group, userId: userId)
        fetchAccounts(group: group, userId: userId)
        
        group.notify(queue: .main) { [weak self] in
            guard let self = self else {return}
            self.reloadData()
        }
    }
    
    
    private func reloadData() {
        self.tableView.refreshControl?.endRefreshing()
        self.isLoaded = true
        if let profile = self.profile {
            self.configureTableViewHeader(with: profile)
        }
        self.configureTableCells(with: self.accounts)
        self.tableView.reloadData()
    }
}

//MARK: - fetch accounts
extension AccountSummaryViewController {
    
    private func fetchAccounts(group: DispatchGroup, userId: String) {
        group.enter()
        fetchAccounts(forUserId: userId) {[weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let accounts):
                self.accounts = accounts
            case .failure(let error):
                self.displayError(error)
            }
            group.leave()
        }
    }
    
    
    private func configureTableCells(with accounts: [Account]) {
        accountCellViewModels = accounts.map {
            AccountSummaryCell.ViewModel(accountType: $0.type, accountName: $0.name, balance: $0.amount)
        }
    }
    
    
}

//MARK: - fetch profile
extension AccountSummaryViewController {
    private func fetchProfile(group: DispatchGroup, userId: String) {
        group.enter()
        let userId = String(Int.random(in: 1...3))
        profileManger.fetchProfile(forUserId: userId) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let profile):
                self.profile = profile
            case .failure(let error):
                self.displayError(error)
            }
            group.leave()
        }
    }
    
    private func configureTableViewHeader(with profile: Profile) {
        profileViewModel = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Good Morning", name: profile.firstName, date: Date())
        headerView.configure(viewModel: profileViewModel)
    }
}


// MARK: Actions
extension AccountSummaryViewController {
    @objc func logoutTapped(sender: UIButton) {
        NotificationCenter.default.post(name: .logout, object: nil)
    }
    
    @objc func refreshContent() {
        reset()
        setupSkeletons()
        tableView.reloadData()
        fetchData()
    }
    
    private func reset() {
        isLoaded = false
        accounts = []
        profile = nil
    }
}




//MARK: - Utils =>  Error Handling
extension AccountSummaryViewController {
    
    private func displayError(_ error: NetworkError) {
        let titleAndMessage = titleAndMessage(for: error)
        self.showErrorAlert(title: titleAndMessage.title, message: titleAndMessage.message)
    }
    
    
    
    private func titleAndMessage(for error: NetworkError) -> (title: String, message: String) {
        let title: String
        let message: String
        switch error {
        case .serverError:
            title = "Server Error"
            message = "We could not process your request. Please try again."
        case .decodingError:
            title = "Network Error"
            message = "Ensure you are connected to the internet. Please try again."
        }
        return (title, message)
    }
    
    
    private func showErrorAlert(title: String, message: String) {
        errorAlert.title = title
        errorAlert.message = message
        present(errorAlert, animated: true, completion: nil)
    }
        
}



//MARK: - Unit testing

extension AccountSummaryViewController {
    
    func titleAndMessageTesting(for error: NetworkError) -> (title: String, message: String) {
        return titleAndMessage(for: error)
    }
    

    func forceFetchProfile() {
        fetchProfile(group: DispatchGroup(), userId: "1")
    }
}

