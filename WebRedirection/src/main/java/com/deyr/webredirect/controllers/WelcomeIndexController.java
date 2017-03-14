package com.deyr.webredirect.controllers;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.ModelAndView;

import com.deyr.webredirect.models.Answer;
import com.deyr.webredirect.models.Proposal;
import com.deyr.webredirect.models.ProposalBean;
import com.deyr.webredirect.models.Question;
import com.deyr.webredirect.models.QuestionBean;
import com.deyr.webredirect.models.QuestionObj;
import com.deyr.webredirect.models.User;

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
	@RequestMapping("/evaluate")
	public ModelAndView loginController(HttpServletRequest request,HttpServletResponse response,@ModelAttribute  User user){
		int t=0;
		t++;
		t--;
		--t;
		ModelAndView view = new ModelAndView("user");
		view.addObject("message", "<input type='text' placeholder='Username' name='name'>Howdy there !");
		List<Proposal> proplist=new ArrayList<Proposal>();
		Proposal prop1 = new Proposal();
		prop1.setName("Java Test");
		prop1.setTestDesc("java test exp 2-3"); 
		prop1.setTestId(1);
		prop1.setProposalId(123);
		proplist.add(prop1);
		Proposal prop2 = new Proposal();
		prop2.setName("Database Test");
		prop2.setTestDesc("Oracle test exp 2-3");
		prop2.setTestId(2);
		prop2.setProposalId(123);
		proplist.add(prop2);
		Proposal prop3 = new Proposal();
		prop3.setName("Arch Test");
		prop3.setTestDesc("Arch test exp 2-3");
		prop3.setTestId(3);
		prop3.setProposalId(123);
		proplist.add(prop3);
		ProposalBean bean = new ProposalBean();
		bean.setProposals(proplist);
		view.addObject("prop",bean);
		return view;
	}
	@RequestMapping("/test")
	public ModelAndView testCtrl(@RequestParam(value="test" ,required=false,defaultValue="World") String name,HttpServletRequest httpServletRequest){
		ModelAndView view = new ModelAndView("formSubmit");
		List<QuestionObj> questionObjs = new ArrayList<QuestionObj>();
		QuestionObj obj1= new QuestionObj();
		Question question1= new Question();
		question1.setQid(1);
		question1.setQuestionDesc("how do you do");
		question1.setOption_1("fine");
		question1.setOption_2("ok");
		question1.setQuestionType("MCQ");
		Answer answer1 = new Answer();
		answer1.setQid(1);
		answer1.setAnsDesc("");
		obj1.setAnswer(answer1);
		obj1.setQuestion(question1);
		questionObjs.add(obj1);
		
		QuestionObj obj2= new QuestionObj();
		Question question2= new Question();
		question2.setQid(2);
		question2.setQuestionDesc("how are stuff");
		question2.setOption_1("good");
		question2.setOption_2("fantastic");
		question2.setQuestionType("MCQ");
		Answer answer2 = new Answer();
		answer2.setQid(2);
		answer2.setAnsDesc("");
		obj2.setAnswer(answer2);
		obj2.setQuestion(question1);
		questionObjs.add(obj2);
		
		QuestionObj obj3= new QuestionObj();
		Question question3= new Question();
		question3.setQid(1);
		question3.setQuestionDesc("what is life");
		question3.setQuestionType("TXT");
		Answer answer3 = new Answer();
		answer3.setQid(3);
		answer3.setAnsDesc("");
		obj3.setAnswer(answer3);
		obj3.setQuestion(question3);
		questionObjs.add(obj3);
		
		QuestionBean questionBean = new QuestionBean();
		questionBean.setQuestions(questionObjs);
		
		view.addObject("questionBean",questionBean);
		int t=0;
		t++;
		return view;
	}
	
	@RequestMapping("/frmsubmit")
	public ModelAndView frmSubmit(@ModelAttribute QuestionBean bean,HttpServletRequest httpServletRequest){
		bean.getQuestions();
		int t=9;
		t++;
		t--;
		return null;
	}
	
	
}
