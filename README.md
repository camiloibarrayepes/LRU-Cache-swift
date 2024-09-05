# LRUCache

## Description

`LRUCache` is an implementation of the Least Recently Used (LRU) cache algorithm. This cache stores a fixed number of key-value pairs and evicts the least recently used item when the cache reaches its capacity. The implementation provides `get` and `put` operations, both of which run in O(1) average time complexity.

## Features

- **Initialization**: Set the cache capacity.
- **Get**: Retrieve the value associated with a key if it exists, otherwise return -1.
- **Put**: Insert or update the value for a key. If the cache exceeds its capacity, evict the least recently used key.

## Requirements

- Swift 5.0+
- XCTest for testing

## Installation

To use this `LRUCache` implementation in your Swift project, simply include the `LRUCache` class and the `DoublyLinkedList` implementation in your project.

## Usage

Here's an example of how to use the `LRUCache`:

```swift
let cache = LRUCache(2) // Initialize cache with capacity of 2
cache.put(1, 1)        // Cache is {1=1}
print(cache.get(1))    // Returns 1

cache.put(2, 2)        // Cache is {1=1, 2=2}
print(cache.get(1))    // Returns 1

cache.put(3, 3)        // LRU key was 2, evicts key 2, cache is {1=1, 3=3}
print(cache.get(2))    // Returns -1 (not found)

cache.put(4, 4)        // LRU key was 1, evicts key 1, cache is {3=3, 4=4}
print(cache.get(1))    // Returns -1 (not found)
print(cache.get(3))    // Returns 3
print(cache.get(4))    // Returns 4
