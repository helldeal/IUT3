package com.example.demo

import org.springframework.http.HttpHeaders
import org.springframework.http.HttpStatusCode
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.MethodArgumentNotValidException
import org.springframework.web.bind.annotation.ControllerAdvice
import org.springframework.web.context.request.WebRequest
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler

@ControllerAdvice
class HttpErrorHandler : ResponseEntityExceptionHandler() {

    override fun handleMethodArgumentNotValid(e: MethodArgumentNotValidException,
                                              headers: HttpHeaders,
                                              status: HttpStatusCode,
                                              request: WebRequest
    )
            : ResponseEntity<Any>? {
        return ResponseEntity.badRequest().body("You're arg is invalid")
    }
}