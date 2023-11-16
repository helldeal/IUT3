package com.example.demo

import org.assertj.core.api.Assertions.assertThat
import org.junit.jupiter.api.Test

import org.junit.jupiter.api.Assertions.*

class UserControllerTest {
    private val service = UserService()
    //private val userController = UserController(userService = service)
    @Test
    fun createUser() {
        val user=service.createUser(User("Clenet","Alex",20,"djzejfo"))
        assertThat(user).isEqualTo(User("Clenet","Alex",20,"djzejfo"))
        assertThat(service.createUser(User("Clenet","Alex",20,"djzejfo"))).isEqualTo(null)
    }

    @Test
    fun findAll() {
        assertThat(service.getAll()).isEqualTo(mutableMapOf<String, User>())
    }

    @Test
    fun findOne() {
        service.createUser(User("Clenet","Alex",20,"djzejfo"))
        assertThat(service.getUser("djzejfo")).isEqualTo(User("Clenet","Alex",20,"djzejfo"))
    }

    @Test
    fun updateUser() {
        service.createUser(User("Clenet","Alex",20,"djzejfo"))
        service.updateUser("djzejfo",User("Clenet","Alexandre",70,"djzejfo"))
        assertThat(service.getUser("djzejfo")).isEqualTo(User("Clenet","Alexandre",70,"djzejfo"))
    }

    @Test
    fun deleteUser() {
        service.createUser(User("Clenet","Alex",20,"djzejfo"))
        service.deleteUser("djzejfo")
        assertThat(service.getUser("djzejfo")).isEqualTo(null)

    }
}