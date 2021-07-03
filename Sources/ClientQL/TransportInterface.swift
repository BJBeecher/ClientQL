//
//  File.swift
//  
//
//  Created by BJ Beecher on 6/5/21.
//

import Foundation
import Combine
import RequestSocket

protocol TransportInterface {
    func connect(withConfiguration: URLSessionConfiguration) -> AnyPublisher<Bool, Never>
    func send<Payload: Encodable, Output: Decodable>(payload: Payload) -> AnyPublisher<Output, Error>
}

// conformance

extension Websocket : TransportInterface {}
