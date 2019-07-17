package com.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Controller
public class MyWebSocketController {
    /**
     * @param userId 模拟登陆，登录的用户名称
     */
    @RequestMapping(value = "/WebSocket/{userId}")
    public String test(@PathVariable("userId") String userId, Model model) throws Exception{
        model.addAttribute("userId",userId);
        return "WebSocketJSP";
    }
}
