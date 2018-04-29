package exdata;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import exdata.exdataDTO;
import util.DatabaseUtil;

public class exdataDAO {

	public exdataDTO getBoard(String table_name) { 
		String SQL="SELECT * FROM doc_combine WHERE table_name=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs=null; 
		exdataDTO exdata = new exdataDTO();
		try {
			conn= DatabaseUtil.getConnection();
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, table_name);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				exdata.setTable_name(rs.getString("table_name"));
				exdata.setEnvironment(rs.getString("environment"));
				exdata.setChannel(rs.getString("channel"));
				exdata.setCh_bw(rs.getString("ch_bw"));
			}

		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try{if(conn!=null)conn.close();}catch(Exception e){e.printStackTrace();}
			try{if(pstmt!=null)pstmt.close();}catch(Exception e){e.printStackTrace();}
			try{if(rs!=null)rs.close();}catch(Exception e){e.printStackTrace();}
		}
		
		return exdata;
	}

	public ArrayList<exdataDTO> getList (String tcid, String bw,String bwtc,int pageNumber){ //검색기능
		

		ArrayList<exdataDTO> boardList = null;
		PreparedStatement pstmt = null;
		String SQL = "";
		Connection conn=null;
		ResultSet rs = null;
		
		try {
			if(tcid.equals("")&&bw.equals("")&&bwtc.equals("")) {
				SQL = "SELECT * FROM doc_combine ORDER BY table_name DESC LIMIT " + pageNumber * 15 + ", " + pageNumber * 15 + 16;
				conn=DatabaseUtil.getConnection();
				pstmt = conn.prepareStatement(SQL);
			} else if(tcid.equals("")&&!bw.equals("")&&!bwtc.equals("")) {
				SQL = "SELECT * FROM doc_combine WHERE CONCAT(ch_bw) LIKE ? AND CONCAT(channel) LIKE ? ORDER BY table_name DESC LIMIT " + pageNumber * 15 + ", " + pageNumber * 15 + 16;
				conn=DatabaseUtil.getConnection();
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, "%" + bw + "%");
				pstmt.setString(2, "%" + bwtc + "%");
			}else if(!tcid.equals("")&&!bw.equals("")&&bwtc.equals("")) {
				SQL = "SELECT * FROM doc_combine WHERE CONCAT(table_name) LIKE ? AND CONCAT(ch_bw) LIKE ? ORDER BY table_name DESC LIMIT " + pageNumber * 15 + ", " + pageNumber * 15 + 16;
				conn=DatabaseUtil.getConnection();
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, "%" + tcid + "%");
				pstmt.setString(2, "%" + bw + "%");
			}else if(!tcid.equals("")&&bw.equals("")&&!bwtc.equals("")) {
				SQL = "SELECT * FROM doc_combine WHERE CONCAT(table_name) LIKE ? AND CONCAT(channel) LIKE ? ORDER BY table_name DESC LIMIT " + pageNumber * 15 + ", " + pageNumber * 15 + 16;
				conn=DatabaseUtil.getConnection();
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, "%" + tcid + "%");
				pstmt.setString(2, "%" + bwtc + "%");
			}else if(!tcid.equals("")&&bw.equals("")&&bwtc.equals("")) {
				SQL = "SELECT * FROM doc_combine WHERE CONCAT(table_name) LIKE ? ORDER BY table_name DESC LIMIT " + pageNumber * 15 + ", " + pageNumber * 15 + 16;
				conn=DatabaseUtil.getConnection();
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, "%" + tcid + "%");
			}else if(tcid.equals("")&&!bw.equals("")&&bwtc.equals("")) {
				SQL = "SELECT * FROM doc_combine WHERE CONCAT(ch_bw) LIKE ? ORDER BY table_name DESC LIMIT " + pageNumber * 15 + ", " + pageNumber * 15 + 16;
				conn=DatabaseUtil.getConnection();
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, "%" + bw + "%");
			}else if(tcid.equals("")&&bw.equals("")&&!bwtc.equals("")) {
				SQL = "SELECT * FROM doc_combine WHERE CONCAT(channel) LIKE ? ORDER BY table_name DESC LIMIT " + pageNumber * 15 + ", " + pageNumber * 15 + 16;
				conn=DatabaseUtil.getConnection();
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, "%" + bwtc + "%");
			}else {
				SQL = "SELECT * FROM doc_combine WHERE CONCAT(table_name) LIKE ? AND CONCAT(ch_bw) LIKE ? AND CONCAT(channel) LIKE ?  ORDER BY table_name DESC LIMIT " + pageNumber * 15 + ", " + pageNumber * 15 + 16;
				conn=DatabaseUtil.getConnection();
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, "%" + tcid + "%");
				pstmt.setString(2, "%" + bw + "%");
				pstmt.setString(3, "%" + bwtc + "%");
			}
			rs = pstmt.executeQuery();

			boardList = new ArrayList<exdataDTO>();

			while(rs.next()) {
				exdataDTO board = new exdataDTO(
					rs.getString(1),
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
}
