import Foundation

struct Book: Codable {
    let id: String
    let volumeInfo: VolumeInfo
    
    struct VolumeInfo: Codable {
        let title: String
        let authors: [String]?
        let description: String?
        let imageLinks: ImageLinks?
        let previewLink: String?
        
        struct ImageLinks: Codable {
            let thumbnail: String?
        }
    }
}

enum BooksError: Error {
    case invalidResponse
    case requestFailed
    case invalidData
}

class BooksAPI {
    
    static let shared = BooksAPI()
    
    private let baseURL = "https://www.googleapis.com/books/v1/volumes"
    private let apiKey = "AIzaSyBtMNbQeN4QYNDfdbc6ezEC_fxQnkabJSU"
    
    func searchBooks(for query: String, completion: @escaping (Result<[Book], Error>) -> Void) {
        let queryString = query.replacingOccurrences(of: " ", with: "+")
        let url = URL(string: "\(baseURL)?q=\(queryString)&key=\(apiKey)")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(BooksError.requestFailed))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(BooksError.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(BooksError.invalidData))
                return
            }
            
            do {
                let books = try JSONDecoder().decode([Book].self, from: data)
                completion(.success(books))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
}
