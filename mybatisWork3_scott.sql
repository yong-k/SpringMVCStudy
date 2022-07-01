SELECT USER
FROM DUAL;
--==>> SCOTT

/*
   - ��� ���� : scott
   - ���̺� : TBL_STUDENT
     �����̺� ���� : SID	NUMBER		-- PK
		   , NAME	VARCHAR2(30)
		   , TEL	VARCHAR2(40)

   - ���̺� : TBL_GRADE
     �����̺� ���� : SID	NUMBER		-- PK/FK
		   , SUB1	NUMBER(3)
		   , SUB2	NUMBER(3)
		   , SUB3	NUMBER(3)

   - �� : STUDENTVIEW
     ���� ���� : SID, NAME, TEL, SUB
			         --- ���� ���ڵ� ��
 
   - �� : GRADEVIEW	
    ���� ���� : SUD, NAME, SUB1, SUB2, SUB3, TOT, AVG, CH
					     ---  ---  --
				             ���� ��� ���(�հ�, ����, ���հ�)
*/


--�� �ǽ� ���̺� ����
CREATE TABLE TBL_STUDENT
( SID   NUMBER
, NAME  VARCHAR2(30)
, TEL   VARCHAR2(40)
, CONSTRAINT STUDENT_SID_PK PRIMARY KEY(SID)
);
--==>> Table TBL_STUDENT��(��) �����Ǿ����ϴ�.


--�� ���� ������ �Է�
INSERT INTO TBL_STUDENT(SID, NAME, TEL)
VALUES(1, '��ȣ��', '010-1111-1111');
INSERT INTO TBL_STUDENT(SID, NAME, TEL)
VALUES(2, '�ּ���', '010-2222-2222');
INSERT INTO TBL_STUDENT(SID, NAME, TEL)
VALUES(3, '�Ӽҹ�', '010-3333-3333');
INSERT INTO TBL_STUDENT(SID, NAME, TEL)
VALUES(4, 'ȫ����', '010-4444-4444');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 4


--�� �ǽ� ���̺� ����
CREATE TABLE TBL_GRADE
( SID   NUMBER
, SUB1  NUMBER(3)
, SUB2  NUMBER(3)
, SUB3  NUMBER(3)
, CONSTRAINT GRADE_SID_PK PRIMARY KEY(SID)
, CONSTRAINT GRADE_SID_FK FOREIGN KEY(SID)
             REFERENCES TBL_STUDENT(SID)
, CONSTRAINT GRADE_SUB1_CK CHECK(SUB1 BETWEEN 0 AND 100)
, CONSTRAINT GRADE_SUB2_CK CHECK(SUB2 BETWEEN 0 AND 100)
, CONSTRAINT GRADE_SUB3_CK CHECK(SUB3 BETWEEN 0 AND 100)
);
--==>> Table TBL_GRADE��(��) �����Ǿ����ϴ�.


--�� ���� ������ �Է�
INSERT INTO TBL_GRADE(SID, SUB1, SUB2, SUB3)
VALUES(1, 90, 80, 70);
INSERT INTO TBL_GRADE(SID, SUB1, SUB2, SUB3)
VALUES(2, 92, 82, 72);
INSERT INTO TBL_GRADE(SID, SUB1, SUB2, SUB3)
VALUES(3, 70, 60, 50);
INSERT INTO TBL_GRADE(SID, SUB1, SUB2, SUB3)
VALUES(4, 74, 64, 54);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 4


SELECT *
FROM TBL_STUDENT;

SELECT *
FROM TBL_GRADE;


--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� �� ����(STUDENTVIEW)
CREATE OR REPLACE VIEW STUDENTVIEW
AS
SELECT S.SID, S.NAME, S.TEL
     , (SELECT COUNT(*)
        FROM TBL_GRADE
        WHERE SID=S.SID) AS SUB
FROM TBL_STUDENT S;
--==>> View STUDENTVIEW��(��) �����Ǿ����ϴ�.


--�� �� ����(GRADEVIEW)
-- ��
CREATE OR REPLACE VIEW GRADEVIEW
AS
SELECT S.SID
     , (SELECT NAME
        FROM TBL_STUDENT
        WHERE SID=G.SID) AS NAME
     , G.SUB1, G.SUB2, G.SUB3
     , (SUB1+SUB2+SUB3) AS TOT
     , (SUB1+SUB2+SUB3)/3 AS AVG
     , CASE WHEN SUB1<40 OR SUB2<40 OR SUB3<40 THEN '����'
            WHEN (SUB1+SUB2+SUB3)/3 < 60 THEN '���հ�'
            ELSE '�հ�'
       END AS CH
FROM TBL_GRADE G; 
--==>> View GRADEVIEW��(��) �����Ǿ����ϴ�.

--��
CREATE OR REPLACE VIEW GRADEVIEW
AS
SELECT S.SID AS SID
     , S.NAME AS NAME
     , G.SUB1 AS SUB1
     , G.SUB2 AS SUB2
     , G.SUB3 AS SUB3
     , (G.SUB1 + G.SUB2 + G.SUB3) AS TOT
     , (G.SUB1 + G.SUB2 + G.SUB3)/3 AS AVG
     , (CASE WHEN (G.SUB1 + G.SUB2 + G.SUB3)/3 < 60 THEN '���հ�'
             WHEN (G.SUB1 <= 40) OR (G.SUB2 <= 40) OR (G.SUB3 <= 40) THEN '����'
             ELSE '�հ�'
             END) AS CH
FROM TBL_STUDENT S JOIN TBL_GRADE G
ON S.SID = G.SID;
--==>> View GRADEVIEW��(��) �����Ǿ����ϴ�.


--�� �� ��ȸ
SELECT SID, NAME, TEL, SUB
FROM STUDENTVIEW;
--==>>
/*
1	��ȣ��	010-1111-1111	1
2	�ּ���	010-2222-2222	1
3	�Ӽҹ�	010-3333-3333	1
4	ȫ����	010-4444-4444	1
*/


--�� �� ��ȸ
SELECT SID, NAME, SUB1, SUB2, SUB3, TOT, AVG, CH
FROM GRADEVIEW;
--==>>
/*
1	��ȣ��	90	80	70	240	80	�հ�
2	�ּ���	92	82	72	246	82	�հ�
3	�Ӽҹ�	70	60	50	180	60	�հ�
4	ȫ����	74	64	54	192	64	�հ�
*/


--�� �ο� �� Ȯ��
SELECT COUNT(*) AS COUNT
FROM TBL_STUDENT;
--==>> 4
