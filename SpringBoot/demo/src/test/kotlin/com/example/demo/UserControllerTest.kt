package com.example.demo

import org.assertj.core.api.Assertions.assertThat
import org.junit.jupiter.api.Test

import org.junit.jupiter.api.Assertions.*
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest
import org.springframework.test.web.servlet.MockMvc
import org.springframework.test.web.servlet.get

@WebMvcTest(UserController::class)
class UserControllerTest {
    private val service = UserService()
    //private val userController = UserController(userService = service)
    @Autowired
    private lateinit var mockMvc: MockMvc

    @Test
    fun get() {
        mockMvc.get("/api/users")
            .andExpect {
                status { isOk() }
            }
    }
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