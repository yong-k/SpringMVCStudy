/*======================
	FileManager.java
=======================*/

package com.test.util;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletResponse;

/*
서버에 있는거 다운받을 때
클라이언트도 해당 파일 객체를 만들어서
서버에 있는거 한 번에 다 받는게 아니라 패킷을 잘라서 받음
시각적으로 볼 때는 A 파일이 딱 만들어지는 것처럼 보이겠지만,
실제로 내부적으로 그렇지는 않음

Stream 통해서 파일 읽어들임
그 중에서도 파일 컨트롤할 때는 byte기반의 stream 사용
부분적으로 읽어오고 읽어오고 하는 과정 필요함
읽어오는 과정에서 인코딩 방식도 맞아야함


아래 코드 복잡해보여도
→ 인코딩방식 맞춰놓고, 바이트 단위로 끊어서 읽어오는 내용 합쳐놓은게 다임

서버에 있는 그 파일 내용물을 클라이언트의 자원에도 써서 똑같이 만들어야 한다.
서버의 해당 파일에는 어떤 내용물이 채워져있을 것이고,
클라이언트에게도 그 파일 담을만한 형태로 틀을 만든 다음에
조금씩 읽어오는 것(→ 바이트 스트림을 잘라오고, 바이트 스트림을 저장하고)  
*/
public class FileManager
{
	// 파일 다운로드
	// - saveFileName : 서버에 저장된 파일 이름
	// - originalFileName : 클라이언트가 업로드한 파일 이름
	// - path : 서버에 저장된 경로
	// - response : HttpServletResponse
	public static boolean dofileDownload(String saveFileName, String originalFileName, String path, HttpServletResponse response)
	{
		String loadDir = path + File.separator + saveFileName;
		
		// 확인
		System.out.println(loadDir);
		
		try
		{
			// 인코딩 지정해서 문자열 만들어야 함
			if (originalFileName == null || originalFileName.equals(""))
				originalFileName = saveFileName;
			
			originalFileName = new String(originalFileName.getBytes("EUC-KR"), "8859_1");
		
			
		} catch (UnsupportedEncodingException e)	//-- 인코딩 지원안되면 예외발생할테니까
		{
			System.out.println(e.toString());
		}
		
		try
		{
			File file = new File(loadDir);
			
			if (file.exists())
			{
				byte[] readByte = new byte[4096];	// 4096 b == 4 Kb
				//-- 바이트기반의 배열(↓ 4kb 씩 읽어오고 쓰고 반복하겠다.)
				
				response.setContentType("application/octet-stream");
				response.setHeader("Content-disposition", "attachment;filename=" + originalFileName);
				
				// BufferedInputStream 으로 감싼 FileInputStream 객체
				BufferedInputStream fis = new BufferedInputStream(new FileInputStream(file));
				
				OutputStream os = response.getOutputStream();
				
				int read;
				while ( (read = fis.read(readByte, 0, 4096)) != -1 )
					os.write(readByte, 0, read);
				
				os.flush();
				os.close();
				fis.close();
				
				// 파일이 존재할 경우 true 반환
				return true;
			}
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}

		// 파일이 존재하지 않아 정상적인 처리가 이루어지지 않을 경우 false 반환
		return false;
		
	}//end doFileDownload
	
	
	// 실제 파일 삭제(제거)
	public static void doFileDelete(String fileName, String path)
	{
		try
		{
			File file = null;
			
			String fullfileName = path + File.pathSeparator + fileName;
			file = new File(fullfileName);
			
			if (file.exists())
				file.delete();
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
	}
}















