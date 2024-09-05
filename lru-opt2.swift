import Foundation

// Define la clase para el LRUCache
class LRUCache {

    // Diccionario para almacenar los nodos de la caché con acceso rápido por clave
    private var cache: [Int: Node] = [:]
    // Capacidad máxima de la caché
    private var capacity: Int
    // Tamaño actual de la caché
    private var size: Int = 0
    // Nodos ficticios para representar los extremos de la lista doblemente enlazada
    private let head: Node
    private let tail: Node
    
    // Clase para representar un nodo en la lista doblemente enlazada
    class Node {
        var key: Int
        var value: Int
        var prev: Node?
        var next: Node?
        
        init(key: Int, value: Int) {
            self.key = key
            self.value = value
        }
    }
    
    // Inicializa el LRUCache con una capacidad dada
    init(_ capacity: Int) {
        self.capacity = capacity
        // Crea los nodos ficticios que actúan como límites de la lista
        self.head = Node(key: 0, value: 0)
        self.tail = Node(key: 0, value: 0)
        // Conecta los nodos ficticios
        self.head.next = self.tail
        self.tail.prev = self.head
    }
    
    // Obtiene el valor asociado con la clave dada
    func get(_ key: Int) -> Int {
        if let node = cache[key] {
            // Mueve el nodo accedido a la cabeza de la lista (más recientemente usado)
            moveToHead(node)
            return node.value
        }
        return -1
    }
    
    // Inserta un par clave-valor en la caché
    func put(_ key: Int, _ value: Int) {
        if let node = cache[key] {
            // Si el nodo ya existe, actualiza el valor y mueve el nodo a la cabeza
            node.value = value
            moveToHead(node)
        } else {
            // Si el nodo no existe, crea un nuevo nodo
            let newNode = Node(key: key, value: value)
            cache[key] = newNode
            // Añade el nuevo nodo a la cabeza de la lista
            addToHead(newNode)
            size += 1
            
            // Si el tamaño supera la capacidad, elimina el nodo menos recientemente usado
            if size > capacity {
                if let tailNode = removeTail() {
                    cache.removeValue(forKey: tailNode.key)
                    size -= 1
                }
            }
        }
    }
    
    // Añade un nodo a la cabeza de la lista
    private func addToHead(_ node: Node) {
        let next = head.next
        head.next = node
        node.prev = head
        node.next = next
        next?.prev = node
    }
    
    // Elimina el nodo al final de la lista y lo devuelve
    private func removeTail() -> Node? {
        let node = tail.prev
        node?.prev?.next = tail
        tail.prev = node?.prev
        node?.prev = nil
        node?.next = nil
        return node
    }
    
    // Mueve un nodo a la cabeza de la lista
    private func moveToHead(_ node: Node) {
        // Elimina el nodo de su posición actual
        node.prev?.next = node.next
        node.next?.prev = node.prev
        
        // Mueve el nodo a la cabeza de la lista
        addToHead(node)
    }
}
