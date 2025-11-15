//
//  GeneralError.swift
//  Common
//
//  Created by Luthfi Asmara on 13/11/25.
//

import Foundation

/// Provides a unified way to handle various types of errors (network, decoding, etc.).
public enum GeneralError: Error {
  case noInternetConnection
  case invalidURL
  case requestFailed(Error)
  case statusCode(Int)
  case decodingError(Error)
  case encodingFailed
  case emptyData
  case invalidResponse
  case unknown
  case rateLimit(timer: Int)
  
  public var errorMessage: String {
    switch self {
      case .noInternetConnection:
        return "No Internet Connection"
      case .invalidURL:
        return "Invalid URL"
      case .requestFailed(let error):
        return "Request Failed: \(error.localizedDescription)"
      case .statusCode(let code):
        return "Server returned an error (Status Code: \(code))"
      case .decodingError:
        return "Failed to decode data from server"
      case .encodingFailed:
        return "Failed to encode request data"
      case .emptyData:
        return "No data received from server"
      case .invalidResponse:
        return "Invalid response from server"
      case .unknown:
        return "An unknown error occurred"
      case .rateLimit(let timeLeft):
        return "Rate limit exceeded. Try again in \(Int(timeLeft)) seconds."
    }
  }
}

extension Error {
  public func mapToGeneralError() -> GeneralError {
    if let generalError = self as? GeneralError {
      return generalError
    } else {
      return .requestFailed(self)
    }
  }
}
