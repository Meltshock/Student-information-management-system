/*A teacher's view*/

/*
1. �Լ����ڵĿε��б�???
2. ���ڵ�ĳһ�ſεľ���ѧ��ѡ�����
3. �Լ�����һЩ�������ͼ
4. �нӵĴ󴴵���Ŀ��������׼���߾ܾ�
*/

CREATE ROLE Teacher_Tno

create login T0000001 with password='123456', default_database=E_Chain;
create user T0000001 for login T0000001 with default_schema=dbo

CREATE VIEW T0000001_TC AS SELECT Tcourse.Cterm, CourseBasic.Cno, Cname, Wday, Cbegin, Cend FROM CourseBasic, CTime, Tcourse WHERE Tcourse.Tno='0000001' AND Tcourse.Cno=CourseBasic.Cno AND Tcourse.Cno=CTime.Cno AND Tcourse.Cterm=CTime.Cterm

GRANT SELECT
ON T0000001_TC
TO T0000001

/*һ����ʦ���ڵ�һ�ſεľ���ѧ����Ϣ�����ں�����¼�ɼ�*/
CREATE VIEW TCS_T0000001__000002_Cterm AS SELECT Sno, Grade FROM Stu_Cour WHERE Stu_Cour.Cno='000002' AND Stu_Cour.Cterm='y'

GRANT SELECT, UPDATE(Grade)
ON TCS_Tno__Cno_Cterm 
TO Teacher_Tno

CREATE VIEW T2A_Tno
AS
SELECT Rcontent, Response
FROM T2A
WHERE T2A.Tno='x'

GRANT SELECT, UPDATE(Rcontent),INSERT/*?*/
ON T2A_Tno
TO Teacher_Tno

CREATE VIEW TP_Tno
AS
SELECT Sno, ProjectName, Reason, Response
FROM ProjectAppli, ProjectLst
WHERE ProjectLst.Tno='x' AND ProjectAppli.ProjectName=ProjectLst.ProgramName

GRANT SELECT, UPDATE(Response)
ON TP_Tno
TO Teacher_Tno



/*
ѧ������ͼ
1. ����ѧ�����еģ����Բ鿴���пγ̵���Ϣ
2. �Լ�����ѡ����Ϣ���˿�Ҫ���룬���ﲻ���ˣ�
3. ֻ�ܲ鿴�Լ��ĳɼ���
4. ѧ���鿴�Լ��Ļ�����Ϣ
5. �Լ���һ������
6. �Լ��Ľ�ѧ������
7. �Լ��Ĵ�����
*/

CREATE ROLE Student_Sno


create login S0000001 with password='123456', default_database=E_Chain;
create user ʩ�� for login ʩ�� with default_schema=dbo

CREATE VIEW Sno_Info_0000001 AS SELECT Sno , Sname, Ssex, Sdept, Sgrade FROM Student WHERE Sno='0000001'

GRANT SELECT ON Sno_Info_0000001 TO ʩ��
/*ѧ���鿴�Լ�����ѡ��*/


CREATE VIEW Sno_Course_0000001 AS SELECT DISTINCT Stu_Cour.Cno, Stu_Cour.Cterm FROM Stu_Cour WHERE Stu_Cour.Sno='x'
/*insert��ѡ�ε�ʱ������*/
GRANT SELECT, INSERT ON Sno_Course TO ʩ��

/*�������ͼһ����Բ鿴��λͬѧ��ѡ�οα�*/
/*SELECT Sno_Course.Cno, Cname, Tname, Sno_Course.Cterm, Wday, Cbegin, Cend FROM Sno_Course, CourseBasic, CTime, Tcourse, Teacher WHERE Sno_Course.Cno=CourseBasic.Cno AND Sno_Course.Cno=Tcourse.Cno AND Sno_Course.Cterm=Tcourse.Cterm AND Sno_Course.Cno=CTime.Cno AND Sno_Course.Cterm=CTime.Cterm
*/

GRANT SELECT ON CourseBasic TO S0000006
GRANT SELECT ON CTime TO S0000006
GRANT SELECT ON Tcourse TO S0000006
GRANT SELECT ON Teacher TO S0000006
GRANT SELECT ON ScholarAppli TO S0000006

CREATE VIEW Sno_Grade AS SELECT DISTINCT Stu_Cour.Cno, Cname, Cchar, Ccredit, Grade,Cterm FROM Stu_Cour, CourseBasicWHERE Stu_Cour.Sno='x' AND Stu_Cour.Cno=CourseBasic.Cno 

GRANT SELECT ON Sno_Grade TO Student_Sno



CREATE VIEW Sno_S2A AS SELECT Rcontent, Response FROM S2A WHERE Sno='x'
/*����ѧ������ʦ����дresponse������е��Ѷ�*/
GRANT SELECT, UPDATE(Rcontent),INSERT  ON Sno_S2A TO Student_Sno



CREATE VIEW Sno_Pro AS SELECT ProjectName, Reason, Response FROM ProjectAppli WHERE Sno='x'
 /*����ѧ������дresponse?*/
GRANT SELECT, UPDATE(ProjectName, Reason),INSERT ON Sno_Pro TO Student_Sno



CREATE VIEW Sno_Scho AS SELECT Scholarship, Reason, Response FROM ScholarAppli WHERE Sno='x'
/*����ѧ������дresponse?*/ 
GRANT SELECT, UPDATE(Scholarship, Reason),INSERT ON Sno_Scho TO Student_Sno