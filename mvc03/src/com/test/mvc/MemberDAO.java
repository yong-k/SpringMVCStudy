/*================================================
 	MemberDAO.java
 	- 데이터베이스 액션 처리 클래스
 	- IMemberDAO 인터페이스를 구현하는 클래스
 	- Connection 객체에 대한 의존성 주입
 	  준비 → setter 메소드 추가
=================================================*/

package com.test.mvc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

public class MemberDAO implements IMemberDAO
{

	// ※ Connection 객체에 대한 의존성 주입을 위한 준비
	// ① 인터페이스 형태의 데이터 타입을 취하는 속성 구성
	//    (DataSource가 인터페이스임)
	private DataSource dataSource;
	
	// ② setter 구성
	public void setDataSource(DataSource dataSource)
	{
		this.dataSource = dataSource;
	}
	
	
	// 우리는 여기서 쿼리문 필요 → 작업객체 필요
	//→ 작업객체는 Connection 통해서 생성 가능 but 지금 Connection 없음
	//   spring이 쓰는 Connection 쓸것이다. (dataSource)
	// 어떤 계정 정보, 어떤 ip 등의 정보는 dataSource bean 등록하는 과정에서
	// 속성값으로 xml 에서 넘겨주게 될 것이다.
	// 그러면 그걸 spring container 에서 주입받아서 connection 이루어 질 것이고
	// 그걸로 작업객체 생성하고, 그 작업객체 통해서 쿼리문 수행할 것이다.
	
	// ※ IMemberDAO 인터페이스의 메소드 오버라이딩
	
	@Override
	public int add(MemberDTO dto) throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		//-- driver, sid ..의 정보는 xml 에서 property 로 넘겨줄 것이다.
		
		String sql = "INSERT INTO TBL_MEMBERLIST(MID, NAME, TELEPHONE)"
				  + " VALUES(MEMBERLISTSEQ.NEXTVAL, ?, ?)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, dto.getName());
		pstmt.setString(2, dto.getTelephone());
		
		result = pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		return result;
	}


	@Override
	public int count() throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT COUNT(*) AS COUNT FROM TBL_MEMBERLIST";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		while (rs.next())
			result = rs.getInt("COUNT");
	
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}

	@Override
	public ArrayList<MemberDTO> list() throws SQLException
	{
		ArrayList<MemberDTO> result = new ArrayList<MemberDTO>();
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT MID, NAME, TELEPHONE FROM TBL_MEMBERLIST ORDER BY MID";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		while (rs.next())
		{
			MemberDTO dto = new MemberDTO();
			dto.setMid(rs.getInt("MID"));
			dto.setName(rs.getString("NAME"));
			dto.setTelephone(rs.getString("TELEPHONE"));
			
			result.add(dto);
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}
	

}
