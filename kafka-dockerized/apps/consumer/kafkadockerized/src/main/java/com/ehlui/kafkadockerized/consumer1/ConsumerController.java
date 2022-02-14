package com.ehlui.kafkadockerized.consumer1;

import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import org.slf4j.Logger;

import javax.servlet.http.HttpServletRequest;

@RestController
public class ConsumerController {

    private final static Logger logger = LoggerFactory.getLogger(ConsumerController.class);

    @RequestMapping("/")
    public String main(HttpServletRequest request){
        logger.info("Root endpoint requested from " + request.getRemoteAddr());
        return "Hello";
    }
}
