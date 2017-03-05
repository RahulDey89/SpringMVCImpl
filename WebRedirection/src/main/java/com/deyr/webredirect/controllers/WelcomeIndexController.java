package com.deyr.webredirect.controllers;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class WelcomeIndexController {

	@RequestMapping("/hello")
	public ModelAndView showHello(@RequestParam(value="name" ,required=false,defaultValue="World") String name,HttpServletRequest httpServletRequest) {
		System.out.println("In controller");
		ModelAndView view = new ModelAndView("helloW");
		ServletContext context = httpServletRequest.getServletContext();
		WebApplicationContext applicationContext =WebApplicationContextUtils.getRequiredWebApplicationContext(context);
		applicationContext.getDisplayName();
		view.addObject("message", "Howdy there !");
		view.addObject("name",name);
		return view;
	}
}
