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
    
    init(transport: TransportInterface){
        self.transport = transport
    }
    
    public convenience init(url: URL, config: URLSessionConfiguration = .default, encoder: JSONEncoder = .init(), decoder: JSONDecoder = .init()) {
        let socket = Websocket(url: url, encoder: encoder, decoder: decoder)
        self.init(transport: socket)
    }
}

// public API

public extension GQLClient {
    func connect(withConfiguartion config: URLSessionConfiguration) -> AnyPublisher<Bool, Never> {
        transport.connect(withConfiguration: config)
    }
    
    func send<Output : GQLType>(_ request: GQLRequest<Output>) -> AnyPublisher<Output, Error> {
        let payload = buildPayload(with: request)
        
        return transport.send(payload: payload)
            .flatMap({ (response: GQLResponse<Output>) -> AnyPublisher<Output, Error> in
                if let data = response.data?.success {
                    return Just(data)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                } else if let errors = response.errors {
                    return Fail(error: Failure.queryFailures(errors)).eraseToAnyPublisher()
                } else {
                    return Fail(error: Failure.missingResponseData).eraseToAnyPublisher()
                }
            }).eraseToAnyPublisher()
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
