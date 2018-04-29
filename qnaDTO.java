package qna;

public class qnaDTO {
	
	String uid;
	int qnaID;
	String qnaTitle;
	String qnaContent;
	String qnaDate;
	int qnaGroup;   
	int qnaSequence; 
	int qnaLevel;
	int qnaAvailable;
	
	
	public qnaDTO() {}
	
	public qnaDTO(String uid, int qnaID, String qnaTitle, String qnaContent, String qnaDate, int qnaGroup,
			int qnaSequence, int qnaLevel) {
		this.uid = uid;
		this.qnaID = qnaID;
		this.qnaTitle = qnaTitle;
		this.qnaContent = qnaContent;
		this.qnaDate = qnaDate;
		this.qnaGroup = qnaGroup;
		this.qnaSequence = qnaSequence;
		this.qnaLevel = qnaLevel;
	}
	
	
	public int getQnaAvailable() {
		return qnaAvailable;
	}

	public void setQnaAvailable(int qnaAvailable) {
		this.qnaAvailable = qnaAvailable;
	}

	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public int getQnaID() {
		return qnaID;
	}
	public void setQnaID(int qnaID) {
		this.qnaID = qnaID;
	}
	public String getQnaTitle() {
		return qnaTitle;
	}
	public void setQnaTitle(String qnaTitle) {
		this.qnaTitle = qnaTitle;
	}
	public String getQnaContent() {
		return qnaContent;
	}
	public void setQnaContent(String qnaContent) {
		this.qnaContent = qnaContent;
	}
	public String getQnaDate() {
		return qnaDate;
	}
	public void setQnaDate(String qnaDate) {
		this.qnaDate = qnaDate;
	}
	public int getQnaGroup() {
		return qnaGroup;
	}
	public void setQnaGroup(int qnaGroup) {
		this.qnaGroup = qnaGroup;
	}
	public int getQnaSequence() {
		return qnaSequence;
	}
	public void setQnaSequence(int qnaSequence) {
		this.qnaSequence = qnaSequence;
	}
	public int getQnaLevel() {
		return qnaLevel;
	}
	public void setQnaLevel(int qnaLevel) {
		this.qnaLevel = qnaLevel;
	}

	
	
	
	
	
	
}
