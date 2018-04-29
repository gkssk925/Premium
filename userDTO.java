package user;

public class userDTO {

	private String uid;
	private String upw;
	private String uemail;
	private String uname;
	private String uphone;
	private String uemailHash;
	private boolean uemailChecked;
	
	
	public String getUemailHash() {
		return uemailHash;
	}

	public void setUemailHash(String uemailHash) {
		this.uemailHash = uemailHash;
	}

	public userDTO() {}
	
	
	
	public userDTO(String uid, String upw, String uemail, String uname, String uphone, String uemailHash,
			boolean uemailChecked) {
		this.uid = uid;
		this.upw = upw;
		this.uemail = uemail;
		this.uname = uname;
		this.uphone = uphone;
		this.uemailHash = uemailHash;
		this.uemailChecked = uemailChecked;
	}

	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getUpw() {
		return upw;
	}
	public void setUpw(String upw) {
		this.upw = upw;
	}
	public String getUemail() {
		return uemail;
	}
	public void setUemail(String uemail) {
		this.uemail = uemail;
	}
	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
	public String getUphone() {
		return uphone;
	}
	public void setUphone(String uphone) {
		this.uphone = uphone;
	}
	public boolean isUemailChecked() {
		return uemailChecked;
	}
	public void setUemailChecked(boolean uemailChecked) {
		this.uemailChecked = uemailChecked;
	}
	
}
