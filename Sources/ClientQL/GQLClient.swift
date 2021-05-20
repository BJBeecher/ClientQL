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
    typealias DataTask = (Data) -> AnyPublisher<Data, Error>
    
    let send : DataTask
    
    let encoder : JSONEncoder
    let decoder : JSONDecoder
    
    init(_ dataTask: @escaping DataTask, encoder: JSONEncoder, decoder: JSONDecoder){
        self.send = dataTask
        self.encoder = encoder
        self.decoder = decoder
    }
    
    public convenience init(url: URL, config: URLSessionConfiguration = .default, encoder: JSONEncoder = .init(), decoder: JSONDecoder = .init()) {
        let socket = Websocket(url: url, config: config, encoder: encoder, decoder: decoder)
        self.init(socket.send, encoder: encoder, decoder: decoder)
    }
}

// public API

public extension GQLClient {
    func send<Output : GQLType>(_ request: GQLRequest<Output>) -> AnyPublisher<Output, Error> {
        let payload = request.payload
        
        guard let data = try? encoder.encode(payload) else {
            return Fail(error: Failure.encodingError).eraseToAnyPublisher()
        }
        
        return send(data)
            .decode(type: GQLResponse<Output>.self, decoder: decoder)
            .flatMap({ response -> AnyPublisher<Output, Error> in
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
