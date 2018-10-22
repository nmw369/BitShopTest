package com.withdog.service.domain;

public class ChatBot {
	private User user;
	private int questionNo;
	private String question;
	private String answer;
	private int questionCount;
	private String deleteFlag;
	private String connectAble;

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public int getQuestionNo() {
		return questionNo;
	}

	public void setQuestionNo(int questionNo) {
		this.questionNo = questionNo;
	}

	public String getQuestion() {
		return question;
	}

	public void setQuestion(String question) {
		this.question = question;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public int getQuestionCount() {
		return questionCount;
	}

	public void setQuestionCount(int questionCount) {
		this.questionCount = questionCount;
	}

	public String getDeleteFlag() {
		return deleteFlag;
	}

	public void setDeleteFlag(String deleteFlag) {
		this.deleteFlag = deleteFlag;
	}
	public String getConnectAble() {
		return connectAble;
	}

	public void setConnectAble(String connectAble) {
		this.connectAble = connectAble;
	}

	@Override
	public String toString() {
		return "ChatBot [user=" + user + ", questionNo=" + questionNo + ", question=" + question + ", answer=" + answer
				+ ", questionCount=" + questionCount + ", deleteFlag=" + deleteFlag + ", connectAble=" + connectAble
				+ "]";
	}



}
