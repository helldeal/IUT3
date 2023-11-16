package com.example.demo

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
class UserController @Autowired constructor(private val userService: UserService){

    @PostMapping("/api/users")
    fun createUser(@RequestBody user: User): ResponseEntity<User> {
        if (userService.users.containsKey(user.email)) {
            return ResponseEntity.status(HttpStatus.CONFLICT).build()
        }
        userService.users[user.email] = user
        return ResponseEntity.ok(user)
    }

    @GetMapping("/api/users")
    fun findAll(@RequestParam(required = false) age: Int?)=if (age!=null) {
             ResponseEntity.ok(userService.users.values.filter { it.age == age })
        } else {
         ResponseEntity.ok(userService.users)
    }

    @GetMapping("/api/users/{email}")
    fun findOne(@PathVariable email: String): ResponseEntity<User> {
        val user = userService.users[email]
        return if (user != null) {
            ResponseEntity.ok(user)
        } else {
            ResponseEntity.notFound().build()
        }
    }
    @PutMapping("/api/users/{email}")
    fun updateUser(@RequestBody user: User, @PathVariable email: String): ResponseEntity<User> {
        if (userService.users.containsKey(user.email)) {
            userService.users[email] = user
            return ResponseEntity.ok(user)
        }
        return ResponseEntity.notFound().build()
    }
    @DeleteMapping("/api/users/{email}")
    fun deleteUser(@PathVariable email: String): ResponseEntity<Unit> {
        return if (userService.users.containsKey(email)) {
            userService.users.remove(email)
            ResponseEntity.noContent().build()
        } else {
            ResponseEntity.badRequest().build()
        }
    }
}
data class User(val firstName: String, val lastName: String, val age: Int, val email: String)
