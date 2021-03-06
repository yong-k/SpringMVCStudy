SELECT USER
FROM DUAL;
--==>> SCOTT


--○ 기존 테이블 제거
DROP TABLE TBL_MEMBERLIST;
--==>> Table TBL_MEMBERLIST이(가) 삭제되었습니다.


--○ 실습 테이블 생성(TBL_MEMBERLIST)
CREATE TABLE TBL_MEMBERLIST
( MID       NUMBER
, NAME      VARCHAR2(30)
, TELEPHONE VARCHAR2(40)
, CONSTRAINT MEMBERLIST_MID_PK PRIMARY KEY(MID)
);
--==>> Table TBL_MEMBERLIST이(가) 생성되었습니다.


--○ 기존 시퀀스 제거 
DROP SEQUENCE MEMBERLISTSEQ;
--==>> Sequence MEMBERLISTSEQ이(가) 삭제되었습니다.


--○ 실습 시퀀스 생성
CREATE SEQUENCE MEMBERLISTSEQ;
--==>> Sequence MEMBERLISTSEQ이(가) 생성되었습니다.


--○ 데이터 입력
INSERT INTO TBL_MEMBERLIST(MID, NAME, TELEPHONE)
VALUES(MEMBERLISTSEQ.NEXTVAL, '김태형', '010-1111-1111');
--==>> 1 행 이(가) 삽입되었습니다.

--이제는 한 줄로 구성할 필요 없음


--○ 확인 (리스트 조회)
SELECT MID, NAME, TELEPHONE
FROM TBL_MEMBERLIST
ORDER BY MID;
--==>> 1	김태형	010-1111-1111


--○ 커밋
COMMIT;
--==>> 커밋 완료.


--○ 인원 수 확인
SELECT COUNT(*) AS COUNT
FROM TBL_MEMBERLIST;
--==>> 1


--○ 데이터 추가 입력
INSERT INTO TBL_MEMBERLIST(MID, NAME, TELEPHONE)
VALUES(MEMBERLISTSEQ.NEXTVAL, '우수정', '010-2222-2222');
--==>> 1 행 이(가) 삽입되었습니다.

--○ 커밋
COMMIT;
--==>> 커밋 완료.


