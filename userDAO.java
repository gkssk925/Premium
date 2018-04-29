package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DatabaseUtil;

public class userDAO {

	
	//로그인 시도
	public int login(String uid,String upw) {
		String SQL="SELECT upw FROM USER WHERE uid=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs=null; // sql문 실행후 결과값 출력
		
		try {
			conn= DatabaseUtil.getConnection();
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, uid);
			rs=pstmt.executeQuery();
			
			if(rs.next()) { // 쿼리 요청후 응답이 존재한다면 즉, 아이디가 존재한다면
				if(rs.getString(1).equals(upw)) {
					return 1; //로그인 성공
				}else {
					return 0; //비밀번호 틀림
				}
			}
			return -1; //아이디 없음
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try{if(conn!=null)conn.close();}catch(Exception e){e.printStackTrace();}
			try{if(pstmt!=null)pstmt.close();}catch(Exception e){e.printStackTrace();}
			try{if(rs!=null)rs.close();}catch(Exception e){e.printStackTrace();}
		}
		
		return -2; //db오류
	}
	
	
	// 회원가입 수행
	public int join(userDTO user) {
		String SQL="INSERT INTO USER VALUES(?,?,?,?,?,false,?)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs=null; // sql문 실행후 결과값 출력
		
		try {
			conn= DatabaseUtil.getConnection();
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUid());
			pstmt.setString(2, user.getUpw());
			pstmt.setString(3, user.getUemail());
			pstmt.setString(4, user.getUname());
			pstmt.setString(5, user.getUphone());
			pstmt.setString(6, user.getUemailHash());
			return pstmt.executeUpdate();

		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try{if(conn!=null)conn.close();}catch(Exception e){e.printStackTrace();}
			try{if(pstmt!=null)pstmt.close();}catch(Exception e){e.printStackTrace();}
			try{if(rs!=null)rs.close();}catch(Exception e){e.printStackTrace();}
		}
		
		return -1; // 이미 존재하는 아이디가 있음
	}
	
	
	public userDTO getUser(String uid) { // 1명의 사용자 정보 반환
		String SQL="SELECT * FROM user WHERE uid=?;";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs=null; // sql문 실행후 결과값 출력
		userDTO user = new userDTO();
		try {
			conn= DatabaseUtil.getConnection();
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, uid);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				user.setUid(uid);
				user.setUpw(rs.getString("upw"));
				user.setUemail(rs.getString("uemail"));
				user.setUname(rs.getString("uname"));
				user.setUphone(rs.getString("uphone"));
			}

		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try{if(conn!=null)conn.close();}catch(Exception e){e.printStackTrace();}
			try{if(pstmt!=null)pstmt.close();}catch(Exception e){e.printStackTrace();}
			try{if(rs!=null)rs.close();}catch(Exception e){e.printStackTrace();}
		}
		
		return user;
	}
	
	public int update(userDTO user) {
		String SQL="UPDATE USER SET upw = ? , uemail= ?, uname = ?, uphone = ? WHERE uid = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs=null; // sql문 실행후 결과값 출력
		
		try {
			conn= DatabaseUtil.getConnection();
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUpw());
			pstmt.setString(2, user.getUemail());
			pstmt.setString(3, user.getUname());
			pstmt.setString(4, user.getUphone());
			pstmt.setString(5, user.getUid());
			return pstmt.executeUpdate();

		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try{if(conn!=null)conn.close();}catch(Exception e){e.printStackTrace();}
			try{if(pstmt!=null)pstmt.close();}catch(Exception e){e.printStackTrace();}
			try{if(rs!=null)rs.close();}catch(Exception e){e.printStackTrace();}
		}
		
		return -1; 
	}
	
	
	
	// 사용자의 아이디를 받아서 이메일주소반환
	public boolean getUserEmailChecked(String uid) {
		String SQL="SELECT uemailChecked FROM user WHERE uid=?;";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs=null; // sql문 실행후 결과값 출력
		
		try {
			conn= DatabaseUtil.getConnection();
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, uid);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getBoolean(1);
			}

		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try{if(conn!=null)conn.close();}catch(Exception e){e.printStackTrace();}
			try{if(pstmt!=null)pstmt.close();}catch(Exception e){e.printStackTrace();}
			try{if(rs!=null)rs.close();}catch(Exception e){e.printStackTrace();}
		}
		
		return false; // 이메일 인증 실패, db요류
	}
	
	
	//이메일 인증확인함수
	public String getUserEmail(String uid) {
		String SQL="SELECT uemail FROM user WHERE uid=?;";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs=null; // sql문 실행후 결과값 출력
		
		try {
			conn= DatabaseUtil.getConnection();
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, uid);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try{if(conn!=null)conn.close();}catch(Exception e){e.printStackTrace();}
			try{if(pstmt!=null)pstmt.close();}catch(Exception e){e.printStackTrace();}
			try{if(rs!=null)rs.close();}catch(Exception e){e.printStackTrace();}
		}
		
		return null; 
	}
	
	// 특정사용자의 이메일 인증수행
	public boolean setUserEmailChecked(String uid) {
		String SQL="UPDATE user SET uemailChecked=true WHERE uid=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs=null; // sql문 실행후 결과값 출력
		
		try {
			conn= DatabaseUtil.getConnection();
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, uid);
			pstmt.executeUpdate();
			
			return true;
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try{if(conn!=null)conn.close();}catch(Exception e){e.printStackTrace();}
			try{if(pstmt!=null)pstmt.close();}catch(Exception e){e.printStackTrace();}
			try{if(rs!=null)rs.close();}catch(Exception e){e.printStackTrace();}
		}
		
		return false; 
	}
	
	
	
	
}
