package com.deyr.webredirect.controllers.test;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.ServletException;

import org.junit.Assert;
import org.junit.BeforeClass;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.mock.web.MockServletContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.ModelAndView;

import com.deyr.webredirect.controllers.WelcomeIndexController;

@ContextConfiguration(locations = {
        "classpath:dispatcher-serv.xml"})

@WebAppConfiguration
public class WelcomeIndexControllerTest extends AbstractJUnit4SpringContextTests{
	@Autowired
	WelcomeIndexController welcomeIndexController; 
	@Autowired
    private WebApplicationContext wac;


	
	@BeforeClass
    public void setUp() throws ServletException {
        MockServletContext sc = new MockServletContext("");
        ServletContextListener listener = new ContextLoaderListener(wac);
        ServletContextEvent event = new ServletContextEvent(sc);
        listener.contextInitialized(event);
    }


	
	@Test
	public void showHelloTest(){
		MockHttpServletRequest httpServletRequest = new MockHttpServletRequest();
		MockHttpServletResponse httpServletResponse = new MockHttpServletResponse();
		httpServletRequest.setParameter("name", "TITO");
		ModelAndView mv = welcomeIndexController.showHello("TITO",httpServletRequest);
		for(Object o:mv.getModel().values()){
			int t=0;
			o.toString();
		};
		Assert.assertEquals("go", "go");
	}

}
