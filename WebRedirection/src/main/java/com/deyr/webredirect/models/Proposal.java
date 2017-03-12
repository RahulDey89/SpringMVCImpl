package com.deyr.webredirect.models;

public class Proposal {
private String name;
private User user;
private int proposalId;
private int testId;
private int ansId;
private String testDesc;
private String title;
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}
public User getUser() {
	return user;
}
public void setUser(User user) {
	this.user = user;
}
public int getProposalId() {
	return proposalId;
}
public void setProposalId(int proposalId) {
	this.proposalId = proposalId;
}
public int getTestId() {
	return testId;
}
public void setTestId(int testId) {
	this.testId = testId;
}
public int getAnsId() {
	return ansId;
}
public void setAnsId(int ansId) {
	this.ansId = ansId;
}
public String getTestDesc() {
	return testDesc;
}
public void setTestDesc(String testDesc) {
	this.testDesc = testDesc;
}
public String getTitle() {
	return title;
}
public void setTitle(String title) {
	this.title = title;
}
}
