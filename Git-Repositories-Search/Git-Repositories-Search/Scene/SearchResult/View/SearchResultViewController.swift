//
//  SearchResultViewController.swift
//  Git-Repositories-Search
//
//  Created by AbdulrhmanNoon on 5/9/21.
//

import UIKit


class SearchResultViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var resultTableView: UITableView!
    
    // MARK: - Properties
    private let viewModel: SearchResultViewModel = SearchResultViewModel()
    private var searchText: String = ""
    
    // MARK: - TableView Delegate & DataSource
    private var tableViewDataSource: SearchResultTableViewDataSource<SearchResultTableViewCell, SearchResultModel>?
    private var tableViewDelegate: SearchResultTableViewDelgate<SearchResultTableViewCell, SearchResultModel>?
        
    // MARK: - inits and lifeCycle
    init(searchText: String) {
        self.searchText = searchText
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setupViews()
    }
    
    private func bind() {
        self.viewModel.bindItemsViewModelToController = { [weak self] in
        guard let self = self else { return }
            self.updateDataSource()
        }
        
        self.viewModel.showLoader = { [weak self] in
            guard let self = self else { return }
            Loader.show(onView: self.view)
        }
        
        self.viewModel.hideLoader = {
            Loader.hide()
        }
        
        self.viewModel.getRepositoriesListFor(text: searchText)
    }
    
    private func setupViews() {
        registerTableViewCell()
    }
    
    private func registerTableViewCell() {
        resultTableView.register(
            UINib(nibName: "SearchResultTableViewCell", bundle: nil),
            forCellReuseIdentifier: "resultCell")
    }
    
   private func updateDataSource() {
        self.tableViewDataSource = SearchResultTableViewDataSource(cellIdentifier: "resultCell",
                                                                   results: self.viewModel.repositories,
                                                                   configureCell: { (cell, repository) in
                                                                   cell.configure(with: repository)
        })
        
        self.tableViewDelegate = SearchResultTableViewDelgate(repositories: self.viewModel.repositories,
                                                              repositoriesViewModel: self.viewModel,
                                                              searchText: self.searchText)
        
        DispatchQueue.main.async {
            self.resultTableView.dataSource = self.tableViewDataSource
            self.resultTableView.delegate = self.tableViewDelegate
            self.reloadData()
        }
    }
    
    private func reloadData() {
        self.resultTableView.reloadData()
    }
}
