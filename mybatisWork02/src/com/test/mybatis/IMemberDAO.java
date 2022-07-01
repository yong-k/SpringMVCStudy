/*=======================
	IMemberDAO.java
	- 인터페이스
========================*/

package com.test.mybatis;

import java.util.ArrayList;

public interface IMemberDAO
{
	// 원래 throws SQLException 다 붙여서 만들었었는데,
	// 이제는 그거 필요 없음!!
	public int add(MemberDTO m);
	public int count();
	public ArrayList<MemberDTO> list();
	
	/* public int remove(String mid); */
	public int remove(int mid);
}
