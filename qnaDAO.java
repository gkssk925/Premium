package qna;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import board.boardDTO;
import util.DatabaseUtil;


public class qnaDAO {

		DataSource dataSource;
		
		public qnaDAO() {
			/*try {
				InitialContext initContext = new InitialContext();
				Context envContext = (Context) initContext.lookup("java:/comp/env");
				dataSource=(DataSource)envContext.lookup("jdbc/UserChat");
			}catch(Exception e) {
				e.printStackTrace();
			}*/
		}
		
		public int write(String uid, String qnaTitle, String qnaContent) {
			String SQL="INSERT INTO QNA SELECT ?, IFNULL((SELECT MAX(qnaID)+1 FROM QNA),1),?,?,now(),IFNULL((SELECT MAX(qnaGroup)+1 FROM QNA),0),0,0,1";
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs=null; // sql문 실행후 결과값 출력
			
			try {
				conn= DatabaseUtil.getConnection();
				pstmt=conn.prepareStatement(SQL);
				pstmt.setString(1, uid);
				pstmt.setString(2, qnaTitle);
				pstmt.setString(3, qnaContent);
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
		
		public int update(String qnaID, String qnaTitle, String qnaContent) {
			String SQL="UPDATE QNA SET qnaTitle=? , qnaContent =? WHERE qnaID=?";
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs=null; 
			
			try {
				conn= DatabaseUtil.getConnection();
				pstmt=conn.prepareStatement(SQL);
				
				pstmt.setString(1, qnaTitle);
				pstmt.setString(2, qnaContent);
				pstmt.setInt(3,Integer.parseInt(qnaID));
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
		
		public int delete(String qnaID) {

			PreparedStatement pstmt = null;
			Connection conn=null;
			ResultSet rs = null;
			String SQL = "DELETE FROM QNA WHERE qnaID = ?";

			try {
				conn=DatabaseUtil.getConnection();
				pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, Integer.parseInt(qnaID));
				return pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try{if(conn!=null)conn.close();}catch(Exception e){e.printStackTrace();}
				try{if(pstmt!=null)pstmt.close();}catch(Exception e){e.printStackTrace();}
				try{if(rs!=null)rs.close();}catch(Exception e){e.printStackTrace();}
			}

			return -1;
		}
		

		public String getUserID(String qnaID) {

			PreparedStatement pstmt = null;
			Connection conn=null;
			ResultSet rs = null;
			String SQL = "SELECT uid FROM QNA WHERE qnaID = ?";

			try {
				conn=DatabaseUtil.getConnection();
				pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, Integer.parseInt(qnaID));
				rs = pstmt.executeQuery();
				while(rs.next()) {
					return rs.getString(1);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
			try{if(conn!=null)conn.close();}catch(Exception e){e.printStackTrace();}
			try{if(pstmt!=null)pstmt.close();}catch(Exception e){e.printStackTrace();}
			try{if(rs!=null)rs.close();}catch(Exception e){e.printStackTrace();}
			}

			return null; // 반환할 아이디값이 없는 경우

		}
		
		public int getAvail(String qnaID) {

			PreparedStatement pstmt = null;
			Connection conn=null;
			ResultSet rs = null;
			String SQL = "SELECT qnaAvailable FROM QNA WHERE qnaID = ?";

			try {
				conn=DatabaseUtil.getConnection();
				pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, Integer.parseInt(qnaID));
				rs = pstmt.executeQuery();
				while(rs.next()) {
					return rs.getInt(1);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
			try{if(conn!=null)conn.close();}catch(Exception e){e.printStackTrace();}
			try{if(pstmt!=null)pstmt.close();}catch(Exception e){e.printStackTrace();}
			try{if(rs!=null)rs.close();}catch(Exception e){e.printStackTrace();}
			}

			return -1; 

		}
		
		public qnaDTO getBoard(String qnaID) { 
			String SQL="SELECT * FROM QNA WHERE qnaID=?";
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs=null; 
			qnaDTO qna = new qnaDTO();
			try {
				conn= DatabaseUtil.getConnection();
				pstmt=conn.prepareStatement(SQL);
				pstmt.setString(1, qnaID);
				rs=pstmt.executeQuery();
				
				if(rs.next()) {
					qna.setUid(rs.getString("uid"));
					qna.setQnaID(rs.getInt("qnaID"));
					qna.setQnaTitle(rs.getString("qnaTitle").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
					qna.setQnaContent(rs.getString("qnaContent").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
					qna.setQnaDate(rs.getString("qnaDate").substring(0, 11));
					qna.setQnaGroup(rs.getInt("qnaGroup"));
					qna.setQnaSequence(rs.getInt("qnaSequence"));
					qna.setQnaLevel(rs.getInt("qnaLevel"));
					qna.setQnaAvailable(rs.getInt("qnaAvailable"));
				}

			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				try{if(conn!=null)conn.close();}catch(Exception e){e.printStackTrace();}
				try{if(pstmt!=null)pstmt.close();}catch(Exception e){e.printStackTrace();}
				try{if(rs!=null)rs.close();}catch(Exception e){e.printStackTrace();}
			}
			
			return qna;
		}
		
		
		public ArrayList<qnaDTO> getList(String pageNumber){ 
			ArrayList<qnaDTO> qnaList = null;
			PreparedStatement pstmt = null;
			String SQL = "SELECT * FROM QNA WHERE qnaGroup > (SELECT MAX(qnaGroup) FROM QNA)-? AND qnaGroup <=(SELECT MAX(qnaGroup) FROM QNA)-? ORDER BY qnaGroup DESC, qnaSequence ASC";
			Connection conn=null;
			ResultSet rs = null;
			
			try {
				conn=DatabaseUtil.getConnection();
				pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, Integer.parseInt(pageNumber)*10);
				pstmt.setInt(2, (Integer.parseInt(pageNumber)-1)*10);
				rs = pstmt.executeQuery();
				qnaList=new ArrayList<qnaDTO>();
			
					while(rs.next()){
						qnaDTO qna = new qnaDTO();
						qna.setUid(rs.getString("uid"));
						qna.setQnaID(rs.getInt("qnaID"));
						qna.setQnaTitle(rs.getString("qnaTitle").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
						qna.setQnaContent(rs.getString("qnaContent").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
						qna.setQnaDate(rs.getString("qnaDate").substring(0, 11));
						qna.setQnaGroup(rs.getInt("qnaGroup"));
						qna.setQnaSequence(rs.getInt("qnaSequence"));
						qna.setQnaLevel(rs.getInt("qnaLevel"));
						qna.setQnaAvailable(rs.getInt("qnaAvailable"));
						qnaList.add(qna);
					}
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try{if(conn!=null)conn.close();}catch(Exception e){e.printStackTrace();}
				try{if(pstmt!=null)pstmt.close();}catch(Exception e){e.printStackTrace();}
				try{if(rs!=null)rs.close();}catch(Exception e){e.printStackTrace();}
			}
			return qnaList;
		}
		
		
		public boolean nextPage(String pageNumber) {
			PreparedStatement pstmt = null;
			String SQL = "SELECT * FROM QNA WHERE qnaGroup >= ?";
			Connection conn=null;
			ResultSet rs = null;
			try {
				conn=DatabaseUtil.getConnection();
				pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, Integer.parseInt(pageNumber)*10);
				rs = pstmt.executeQuery();
				if(rs.next()){
					return true;
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try{if(conn!=null)conn.close();}catch(Exception e){e.printStackTrace();}
				try{if(pstmt!=null)pstmt.close();}catch(Exception e){e.printStackTrace();}
				try{if(rs!=null)rs.close();}catch(Exception e){e.printStackTrace();}
			}
			return false;
		}
		
		
		
		
		
		public int reply(String uid, String qnaTitle, String qnaContent, qnaDTO parent) {
			String SQL="INSERT INTO QNA SELECT ?, IFNULL((SELECT MAX(qnaID)+1 FROM QNA),1),?,?,now(),?,?,?,1";
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs=null; 
			avail(parent);
			try {
				conn= DatabaseUtil.getConnection();
				pstmt=conn.prepareStatement(SQL);
				pstmt.setString(1, uid);
				pstmt.setString(2, qnaTitle);
				pstmt.setString(3, qnaContent);
				pstmt.setInt(4, parent.getQnaGroup());
				pstmt.setInt(5, parent.getQnaSequence()+1);
				pstmt.setInt(6, parent.getQnaLevel()+1);
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
		
		public int avail(qnaDTO parent) {
			String SQL="UPDATE QNA SET qnaAvailable =0 WHERE qnaID=?";
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs=null; 
			
			try {
				conn= DatabaseUtil.getConnection();
				pstmt=conn.prepareStatement(SQL);
				
				pstmt.setInt(1,parent.getQnaID());
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
		
		public int replyUpdate(qnaDTO parent) {
			String SQL="UPDATE QNA SET qnaSequence = qnaSequence +1 WHERE qnaGroup=? AND qnaSequence > ?";
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs=null; 
			
			try {
				conn= DatabaseUtil.getConnection();
				pstmt=conn.prepareStatement(SQL);
				
				pstmt.setInt(1,parent.getQnaGroup());
				pstmt.setInt(2,parent.getQnaSequence());
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
		
}
