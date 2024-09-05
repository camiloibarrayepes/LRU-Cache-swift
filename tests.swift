import XCTest
@testable import MyApp // Reemplaza 'MyApp' con el nombre del módulo de tu proyecto

class LRUCacheTests: XCTestCase {

    var lruCache: LRUCache!
    
    override func setUp() {
        super.setUp()
        lruCache = LRUCache(2) // Inicializa con capacidad 2
    }
    
    override func tearDown() {
        lruCache = nil
        super.tearDown()
    }

    func testLRUCache() {
        // Inicializa LRUCache con capacidad 2
        // Output: [null]
        XCTAssertNil(lruCache)
        
        // Ejecuta operaciones en LRUCache y verifica salidas
        lruCache.put(1, 1)   // cache is {1=1}
        // Output: [null]
        XCTAssertEqual(lruCache.get(1), 1)   // Returns 1, cache is {1=1}

        lruCache.put(2, 2)   // cache is {1=1, 2=2}
        // Output: [null]
        XCTAssertEqual(lruCache.get(1), 1)   // Returns 1, cache is {2=2, 1=1}

        lruCache.put(3, 3)   // LRU key was 2, cache is {1=1, 3=3}
        // Output: [null]
        XCTAssertEqual(lruCache.get(2), -1)  // Returns -1 (not found)

        lruCache.put(4, 4)   // LRU key was 1, cache is {3=3, 4=4}
        // Output: [null]
        XCTAssertEqual(lruCache.get(1), -1)  // Returns -1 (not found)
        XCTAssertEqual(lruCache.get(3), 3)   // Returns 3
        XCTAssertEqual(lruCache.get(4), 4)   // Returns 4
    }
}
