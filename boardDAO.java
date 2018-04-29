package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import util.DatabaseUtil;

public class boardDAO {

	
	public int write(boardDTO BoardDTO) { //글쓰기 함수

		String SQL = "INSERT INTO board VALUES (NULL, ?, ?, ?);";
		PreparedStatement pstmt = null;
		Connection conn=null;
		ResultSet rs = null;

		try {
			conn=DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, BoardDTO.getBoardTitle().replaceAll("<", "&lt;").replaceAll(">", " &gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(2, BoardDTO.getBoardWriter().replaceAll("<", "&lt;").replaceAll(">", " &gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(3, BoardDTO.getBoardContent().replaceAll("<", "&lt;").replaceAll(">", " &gt;").replaceAll("\r\n", "<br>"));

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
	
	
	public ArrayList<boardDTO> getList (String searchType, String search,int pageNumber){ //검색기능
		if(searchType.equals("전체")) {
			searchType = "";
		}

		ArrayList<boardDTO> boardList = null;
		PreparedStatement pstmt = null;
		String SQL = "";
		Connection conn=null;
		ResultSet rs = null;
		
		try {
			if(searchType.equals("작성자")) {
				SQL = "SELECT * FROM BOARD WHERE CONCAT(boardWriter) LIKE ? ORDER BY boardID DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
			} else if(searchType.equals("내용")) {
				SQL = "SELECT * FROM BOARD WHERE CONCAT(boardTitle, boardContent) LIKE ? ORDER BY boardID DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
			}else {
				SQL = "SELECT * FROM BOARD WHERE CONCAT(boardTitle,boardWriter, boardContent) LIKE ? ORDER BY boardID DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
			}
			conn=DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, "%" + search + "%");
			rs = pstmt.executeQuery();

			boardList = new ArrayList<boardDTO>();

			while(rs.next()) {
				boardDTO board = new boardDTO(
					rs.getInt(1),
					rs.getString(2),
					rs.getString(3),
					rs.getString(4)
				);
				boardList.add(board);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try{if(conn!=null)conn.close();}catch(Exception e){e.printStackTrace();}
			try{if(pstmt!=null)pstmt.close();}catch(Exception e){e.printStackTrace();}
			try{if(rs!=null)rs.close();}catch(Exception e){e.printStackTrace();}
		}
		return boardList;
	}
	
	
	
	
	public int delete(String boardId) {

		PreparedStatement pstmt = null;
		Connection conn=null;
		ResultSet rs = null;
		String SQL = "DELETE FROM BOARD WHERE boardId = ?";

		try {
			conn=DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, Integer.parseInt(boardId));
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

	

	public String getUserID(String boardId) {

		PreparedStatement pstmt = null;
		Connection conn=null;
		ResultSet rs = null;
		String SQL = "SELECT boardWriter FROM BOARD WHERE boardId = ?";

		try {
			conn=DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, Integer.parseInt(boardId));
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

	
	
	
}
