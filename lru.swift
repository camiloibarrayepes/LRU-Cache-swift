class LRUCache {
    // Nodo para la lista doblemente enlazada
    class DLinkedNode {
        var key: Int
        var value: Int
        var prev: DLinkedNode? // Puntero al nodo anterior
        var next: DLinkedNode? // Puntero al siguiente nodo
        
        // Inicializa el nodo con una clave y un valor
        init(_ key: Int = 0, _ value: Int = 0) {
            self.key = key
            self.value = value
        }
    }
    
    // Diccionario para mapear claves a nodos
    private var cache: [Int: DLinkedNode] = [:]
    
    // Tamaño actual de la caché
    private var size: Int = 0
    
    // Capacidad máxima de la caché
    private let capacity: Int
    
    // Nodos ficticios para el comienzo y el final de la lista doblemente enlazada
    private let head: DLinkedNode = DLinkedNode() // Nodo dummy para el head
    private let tail: DLinkedNode = DLinkedNode() // Nodo dummy para el tail
    
    // Inicializa la caché LRU con una capacidad fija
    init(_ capacity: Int) {
        self.capacity = capacity
        
        // Conectar el nodo `head` con el nodo `tail` al inicio
        head.next = tail
        tail.prev = head
    }
    
    // Función para obtener el valor asociado a una clave
    func get(_ key: Int) -> Int {
        if let node = cache[key] {
            // Si el nodo existe en el cache, lo movemos al frente (más reciente)
            moveToHead(node)
            return node.value // Retornamos el valor
        }
        // Si no existe, retornamos -1
        return -1
    }
    
    // Función para insertar o actualizar un valor en la caché
    func put(_ key: Int, _ value: Int) {
        if let node = cache[key] {
            // Si la clave ya existe en la caché, actualizamos su valor
            node.value = value
            // Lo movemos al frente de la lista (como el más recientemente usado)
            moveToHead(node)
        } else {
            // Si la clave no existe, creamos un nuevo nodo
            let newNode = DLinkedNode(key, value)
            cache[key] = newNode // Lo añadimos al diccionario
            addNode(newNode) // Lo añadimos al frente de la lista
            size += 1 // Incrementamos el tamaño de la caché
            
            // Si el tamaño de la caché excede la capacidad
            if size > capacity {
                // Eliminamos el nodo menos recientemente usado (el que está al final)
                let tail = removeTail()
                cache.removeValue(forKey: tail.key) // Lo removemos del diccionario
                size -= 1 // Reducimos el tamaño de la caché
            }
        }
    }
    
    // Añade un nodo justo después del nodo head (lo más reciente)
    private func addNode(_ node: DLinkedNode) {
        node.prev = head // El nodo anterior será el head
        node.next = head.next // El siguiente nodo será el que estaba después del head
        
        // Ajustamos el nodo que estaba después del head para que apunte al nuevo nodo
        head.next?.prev = node
        // Conectamos el head con el nuevo nodo
        head.next = node
    }
    
    // Remueve un nodo de cualquier posición en la lista
    private func removeNode(_ node: DLinkedNode) {
        let prev = node.prev
        let next = node.next
        
        // Conectamos el nodo anterior con el nodo siguiente, eliminando el actual
        prev?.next = next
        next?.prev = prev
    }
    
    // Mueve un nodo existente al frente de la lista
    private func moveToHead(_ node: DLinkedNode) {
        removeNode(node) // Primero lo quitamos de donde esté
        addNode(node) // Luego lo añadimos al frente (después del head)
    }
    
    // Remueve el nodo menos recientemente usado (el que está al final)
    private func removeTail() -> DLinkedNode {
        let node = tail.prev! // El nodo menos reciente está justo antes del tail
        removeNode(node) // Lo removemos de la lista
        return node // Retornamos el nodo removido
    }
}

/**
 * Ejemplo de uso:
 * let obj = LRUCache(capacity)
 * let ret_1: Int = obj.get(key)
 * obj.put(key, value)
 */
