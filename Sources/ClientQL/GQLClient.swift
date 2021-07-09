//
//  File.swift
//  
//
//  Created by BJ Beecher on 5/18/21.
//

import Foundation
import Combine
import RequestSocket

public final class GQLClient {
    let transport : TransportInterface
    let timeout : DispatchQueue.SchedulerTimeType.Stride
    
    init(transport: TransportInterface, timeout: DispatchQueue.SchedulerTimeType.Stride){
        self.transport = transport
        self.timeout = timeout
    }
    
    public convenience init(encoder: JSONEncoder = .init(), decoder: JSONDecoder = .init(), timeout: DispatchQueue.SchedulerTimeType.Stride = 8) {
        let socket = Websocket(encoder: encoder, decoder: decoder)
        self.init(transport: socket, timeout: timeout)
    }
}

// public API

public extension GQLClient {
    func connect(withRequest request: URLRequest) -> AnyPublisher<Bool, Never> {
        transport.connect(withRequest: request)
    }
    
    func send<Output : GQLType>(_ request: GQLRequest<Output>) -> AnyPublisher<Output, Error> {
        let payload = buildPayload(with: request)
        
        return transport.send(payload: payload, withTimeout: request.rootType != .subscription ? timeout : nil)
            .tryMap { (response: GQLResponse<Output>) in
                if let data = response.data?.success {
                    return data
                } else if let errors = response.errors {
                    throw Failure.queryFailures(errors)
                } else {
                    throw Failure.missingResponseData
                }
            }.eraseToAnyPublisher()
    }
}

// internal API

extension GQLClient {
    func buildPayload<Output: GQLType>(with request: GQLRequest<Output>) -> Payload {
        let query = request.query
        let variables = request.variables
        let payload = Payload(query: query, variables: variables)
        
        return payload
    }
}
