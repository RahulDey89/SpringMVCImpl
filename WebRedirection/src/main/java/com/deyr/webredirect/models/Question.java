package com.deyr.webredirect.models;

public class Question {
private int qid;
private String option_1;
private String Option_2;
private String questionDesc;
private String questionType;
public String getQuestionType() {
	return questionType;
}
public void setQuestionType(String questionType) {
	this.questionType = questionType;
}
public int getQid() {
	return qid;
}
public void setQid(int qid) {
	this.qid = qid;
}
public String getOption_1() {
	return option_1;
}
public void setOption_1(String option_1) {
	this.option_1 = option_1;
}
public String getOption_2() {
	return Option_2;
}
public void setOption_2(String option_2) {
	Option_2 = option_2;
}
public String getQuestionDesc() {
	return questionDesc;
}
public void setQuestionDesc(String questionDesc) {
	this.questionDesc = questionDesc;
}
}
