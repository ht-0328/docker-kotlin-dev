package org.example.controller

import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

// REST API のコントローラクラス
@RestController
class HelloController {

    // GETリクエストで /hello にアクセスされたときに "Hello, World!" を返す
    @GetMapping("/hello")
    fun hello(): String {
        return "Hello, World!"
    }
}
