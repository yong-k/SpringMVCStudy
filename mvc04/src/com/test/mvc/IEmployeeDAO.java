/*=========================
	#5. IEmployeeDAO.java
	- 인터페이스
==========================*/

package com.test.mvc;

import java.sql.SQLException;
import java.util.ArrayList;

public interface IEmployeeDAO
{
	public ArrayList<Employee> list() throws SQLException;
	
	
/*
	employeeDAO 에 지역,부서,직위 리스트 메소드 있다.
	regionDAO, positionDAO, departmentDAO 에 각각 list() 있는데도
	→ 효율적, 합리적 Ⅹ
	→ 근데 왜 ??
	→ IEmployeeDAO 가 저거 가지고 있지 않으면
	직원정보 입력,수정하는 과정에서 목록보여줘야하는데
	employeeinsertform 출동시키는 employeeinsertformController는
	employeeDAO 만 주입받아서는 해결못하게 된다.
	지역,직위,부서 DAO 각각 다 주입받아야 한다!...!
	그거 귀찮고 번거로우니까 중복되었지만, 이렇게 쓴거
*/
	public ArrayList<Region> regionList() throws SQLException;
	public ArrayList<Department> departmentList() throws SQLException;
	public ArrayList<Position> positionList() throws SQLException;
	
	public int getMinBasicPay(String positionId) throws SQLException;
	public int employeeAdd(Employee employee) throws SQLException;
	public int remove(String employeeId) throws SQLException;
	public int modify(Employee employee) throws SQLException;
	public Employee searchId(String employeeId) throws SQLException;
	//-- 직원ID는 왜 검색할까?
	//   수정할 때 수정폼에 그 사원의 데이터를 얻어와서 
	//   수정폼 안에 내용 채워넣어놓으려고!
	
	public String login(String id, String pw) throws SQLException;
	public String loginAdmin(String id, String pw) throws SQLException;
}
