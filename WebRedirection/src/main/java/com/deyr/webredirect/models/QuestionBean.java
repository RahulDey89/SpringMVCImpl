package com.deyr.webredirect.models;

import java.util.ArrayList;
import java.util.List;

public class QuestionBean {
	private List<QuestionObj> questions = new ArrayList<QuestionObj>();

	public List<QuestionObj> getQuestions() {
		return questions;
	}

	public void setQuestions(List<QuestionObj> questions) {
		this.questions = questions;
	}
}
