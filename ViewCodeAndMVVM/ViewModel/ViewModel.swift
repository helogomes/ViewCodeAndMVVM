//
//  ViewModel.swift
//  ViewCodeAndMVVM
//
//  Created by user218997 on 11/07/22.
//

import UIKit

protocol ViewModelDelegate: AnyObject {
    func sucessRequest()
    func errorRequest()
}

class ViewModel {

    private let service: Service = Service()
    private var listUser:[User] = []
    
    private weak var delegate: ViewModelDelegate?
    
    public func delegate(delegate: ViewModelDelegate?) {
        self.delegate = delegate
    }
    
    public func fetchAllRequestMock() {
        service.getUserFromJson(fromFiledNamed: "user") { success, error in
            if let _success = success {
                self.listUser = _success.group
                self.delegate?.sucessRequest()
            } else {
                self.delegate?.errorRequest()
            }
        }
    }
    
    public func fetchAllRequest() {
        service.getUser() { success, error in
            if let _success = success {
                self.listUser = _success.group
                self.delegate?.sucessRequest()
            } else {
                self.delegate?.errorRequest()
            }
        }
    }

    
    
    public var numberOfRows: Int {
        return self.listUser.count
    }
    
    public func loadCurrentUser(indexPath: IndexPath) -> User {
        return self.listUser[indexPath.row]
    }
    
    public func getName(indexPath: IndexPath) -> String {
        return self.listUser[indexPath.row].name
    }
    
    public func exchangeHeartState(_ user: User) {
        
        if let row = self.listUser.firstIndex(where: {user.identifier == $0.identifier}) {
            self.listUser[row] = user
        }
            
    }
    
    
    
}
