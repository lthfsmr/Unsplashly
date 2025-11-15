//
//  Connectivity.swift
//  Common
//
//  Created by Luthfi Asmara on 15/11/25.
//


import Combine
import Network

public protocol ConnectivityChecking {
  var isConnected: Bool { get }
}

public final class ConnectivityManager: ConnectivityChecking {
  private let monitor = NWPathMonitor()
  private let queue = DispatchQueue(label: "ConnectivityMonitor")
  private(set) var currentStatus: NWPath.Status = .satisfied
  
  public static let shared = ConnectivityManager()
  
  public let status = PassthroughSubject<NWPath.Status, Never>()
  
  private init() {
    monitor.pathUpdateHandler = { [weak self] path in
      self?.currentStatus = path.status
    }
    monitor.start(queue: queue)
  }
  
  public var isConnected: Bool {
    currentStatus == .satisfied
  }
  
  public func updateStatus() {
    status.send(currentStatus)
  }
}
