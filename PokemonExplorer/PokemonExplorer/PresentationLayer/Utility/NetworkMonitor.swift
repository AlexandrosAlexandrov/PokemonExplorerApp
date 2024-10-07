//
//  NetworkMonitor.swift
//  PokemonExplorer
//
//  Created by Alexandros Alexandrov on 7/10/24.
//
import Network
import SwiftUI

class NetworkMonitor: ObservableObject {
    private let monitor: NWPathMonitor
    private let monitorQueueLabel = "NetworkMonitor"

    @Published
    var isNetworkAvailable: Bool

    init() {
        monitor = NWPathMonitor()
        monitor.start(
            queue: DispatchQueue(
                label: monitorQueueLabel
            )
        )

        isNetworkAvailable = monitor.currentPath.status == .satisfied

        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isNetworkAvailable = path.status == .satisfied
            }
        }
    }

    deinit {
        monitor.cancel()
    }
}
