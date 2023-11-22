package com.example.demo

import org.springframework.stereotype.Service

@Service
class UserService {
    public val users = mutableMapOf<String, User>()

    fun createUser(user: User): User? {
        if (users.containsKey(user.email)) {
            return null
        }
        users[user.email] = user
        return users[user.email]
    }

    fun getAll(age: Int?=null): Map<String, User> {
        if (age!=null)return users.filter { it.value.age == age }
        return users
    }
    fun getUser(email: String): User? {
        if (!users.containsKey(email)) return null
        return users[email]
    }

    fun updateUser(email: String, updatedUser: User): User? {
        if (!users.containsKey(email)) return null
        users[email] = updatedUser
        return users[email]
    }

    fun deleteUser(email: String): Boolean {
        return users.remove(email) != null
    }

}
