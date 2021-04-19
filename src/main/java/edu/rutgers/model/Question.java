package edu.rutgers.model;

/**
 * Question model for the database.
 * Models the generic question relation in the backend.
 * 
 * @author Mikita Belausau
 * @author Muskan Burman
 * @author Dorian Hobot
 * @author Jared Tulayan
 */
public class Question {
    private Integer id;
    private String euLogin;
    private String crLogin;
    private String questionText;
    private String answerText;

    public void setID(Integer i) {
        id = i;
    }

    public Integer getID() {
        return id;
    }

    public void setEULogin(String login) {
        euLogin = login;
    }

    public String getEULogin() {
        return euLogin;
    }

    public void setCRLogin(String login) {
        crLogin = login;
    }

    public String getCRLogin() {
        return crLogin;
    }

    public void setQuestionText(String text) {
        questionText = text;
    }

    public String getQuestionText() {
        return questionText;
    }

    public void setAnswerText(String text) {
        answerText = text;
    }

    public String getAnswerText() {
        return answerText;
    }

    @Override
    public boolean equals(Object other) {
        return (other instanceof Question) ? 
                ((Question)other).id == this.id:
                (other == this);
    }

    @Override
    public int hashCode() {
        return (id != null) ? (this.getClass().hashCode() + id.hashCode()) : super.hashCode();
    }
    
    @Override
    public String toString() {
        return String.format("Question[id=%i,euLogin=%s,crLogin=%s,questionText=%s,answerText=%s]", 
            id, 
            euLogin,
            crLogin,
            questionText,
            answerText
        );
    } 
}
