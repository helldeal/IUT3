package com.example.demo

import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RestController

    @RestController
class HelloController {
    @GetMapping("/hello/{name}")
    fun helloPath(@PathVariable name: String) = if (name.length <= 2) {
        ResponseEntity.badRequest().body("Name size must be > 2")
    } else {
        ResponseEntity.ok("world of $name")
    }
}

