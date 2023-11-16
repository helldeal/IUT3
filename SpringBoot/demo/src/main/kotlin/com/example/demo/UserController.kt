package com.example.demo

import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable

class UsersController{

    //Nom, Prenom, Age, Email
    @GetMapping("/api/users/{Nom}/{Prenom}/{Age}/{Email}")
    fun CreatePath(@PathVariable name: String){
       // ResponseEntity.badRequest().body("Already Exist")

        ResponseEntity.ok("")
    }
}
