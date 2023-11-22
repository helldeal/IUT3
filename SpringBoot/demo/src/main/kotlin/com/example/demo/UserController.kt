package com.example.demo

import io.swagger.v3.oas.annotations.Operation
import io.swagger.v3.oas.annotations.Parameter
import io.swagger.v3.oas.annotations.media.ArraySchema
import io.swagger.v3.oas.annotations.media.Content
import io.swagger.v3.oas.annotations.media.Schema
import io.swagger.v3.oas.annotations.responses.ApiResponse
import io.swagger.v3.oas.annotations.responses.ApiResponses
import jakarta.validation.Valid
import jakarta.validation.constraints.Email
import jakarta.validation.constraints.Min
import jakarta.validation.constraints.Size
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.context.annotation.Description
import org.springframework.http.HttpHeaders
import org.springframework.http.HttpStatus
import org.springframework.http.HttpStatusCode
import org.springframework.http.ResponseEntity
import org.springframework.validation.annotation.Validated
import org.springframework.web.bind.MethodArgumentNotValidException
import org.springframework.web.bind.annotation.*
import org.springframework.web.context.request.WebRequest

@RestController
@Validated
class UserController @Autowired constructor(private val userService: UserService){

    @Operation(summary = "Create user", description = "Create a user with a User object")
    @ApiResponses(value = [
        ApiResponse(responseCode = "200", description = "User",
            content = [Content(mediaType = "application/json",
                array = ArraySchema(
                    schema = Schema(implementation = User::class)
                )
            )])])
    @PostMapping("/api/users")
    fun createUser(@Valid @RequestBody user: User): ResponseEntity<User> {
        if (userService.users.containsKey(user.email)) {
            return ResponseEntity.status(HttpStatus.CONFLICT).build()
        }
        userService.users[user.email] = user
        return ResponseEntity.ok(user)
    }

    @Operation(summary = "Liste users")
    @GetMapping("/api/users")
    fun findAll(@RequestParam(required = false) age: Int?)=if (age!=null) {
             ResponseEntity.ok(userService.users.values.filter { it.age == age })
        } else {
         ResponseEntity.ok(userService.users)
    }
    @Operation(summary = "Find user")
    @GetMapping("/api/users/{email}")
    fun findOne(@Parameter(description = "email of the user")@PathVariable email: String): ResponseEntity<User> {
        val user = userService.users[email]
        return if (user != null) {
            ResponseEntity.ok(user)
        } else {
            ResponseEntity.notFound().build()
        }
    }
    @Operation(summary = "Update users")
    @PutMapping("/api/users/{email}")
    fun updateUser(@Valid @RequestBody user: User, @PathVariable email: String): ResponseEntity<User> {
        if (userService.users.containsKey(user.email)) {
            userService.users[email] = user
            return ResponseEntity.ok(user)
        }
        return ResponseEntity.notFound().build()
    }
    @Operation(summary = "Delete users")
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
data class User(
    @field:Size(min=2,max=30)
    val firstName: String,
    @field:Min(1)
    val lastName: String,
    @field:Min(15)
    val age: Int,
    @Email
    val email: String
)


