//
//  BaseViewModel.swift
//  PazaramaCloneApp
//
//  Created by bora ateş on 26.07.2023.
//

import Foundation

protocol ViewModelOutputProtocol: AnyObject {}

protocol ViewModelProtocol: AnyObject {
    associatedtype T
    var outputDelegate: T? { get set }
    func viewDidAppear()
}

extension ViewModelProtocol {
    func viewDidAppear() {}
}
