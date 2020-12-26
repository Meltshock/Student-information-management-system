/*�޸Ŀγ���Ϣʱ��
�γ̱�Ų����޸ģ��γ����ƿ��޸�
�γ����ѡ���������޸ģ��޸����ֵ���ڵ�ǰ��ѡ������*/

CREATE TRIGGER Update_CourseInfo ON CourseBasic
AFTER UPDATE
AS
DECLARE @newCno varchar(9), @oldCno varchar(9), 
@newClimit SMALLINT, @oldCcur SMALLINT,@newCcur SMALLINT
SELECT @newCno=CB2.Cno, @oldCno=CB1.Cno, @newClimit=CB2.Climit,@oldCcur=CB1.Ccur, @newCcur=CB2.Ccur
FROM deleted CB1, inserted CB2
IF(@newCno<>@oldCno)OR(@oldCcur<>@newCcur)OR(@newClimit<@oldCcur)
BEGIN
ROLLBACK TRANSACTION
END

/*ɾ���γ�*/

/*��������*/


/*�޸Ľ�ʦ
��ʦ��Ų����޸�*//*��˵�޸ĵ�ʱ����������������ֱ�ӻᱨ���?*/
CREATE TRIGGER UPdate_TeacherInfo ON Teacher
AFTER UPDATE
AS
DECLARE @newTno char(4), @oldTno char(4)
SELECT @newTno=T2.Tno, @oldTno=T1.Tno
FROM deleted T1, inserted T2
IF(@newTno<>@oldTno)
BEGIN
ROLLBACK TRANSACTION
END

/*������ʦ*/

/*ɾ����ʦ*/


/*�޸�ѧ����Ϣ*/
CREATE TRIGGER UPdate_StudentInfo ON Student
AFTER UPDATE
AS
DECLARE @newSno char(9), @oldSno char(9)
SELECT @newSno=S2.Sno, @oldSno=S1.Sno
FROM deleted S1, inserted S2
IF(@newSno<>@oldSno)
BEGIN
ROLLBACK TRANSACTION
END

/*ɾ��ѧ��*/
CREATE TRIGGER Delete_Student ON Student
AFTER DELETE
AS BEGIN
	DECLARE @delSno char(9)
	SELECT @delSno=delStu.Sno FROM deleted delStu
	UPDATE CourseBasic
	SET Ccur=Ccur-1
	WHERE CourseBasic.Cno=(SELECT Cno FROM Stu_Cour, deleted delStu WHERE Stu_Cour.Sno=delStu.Sno)
END

/*����Ա�����˿�*/
DELETE FROM Stu_Cour
WHERE Sno='�����˿�ͬѧ' AND Cno='����Ŀ�' AND Cterm='�����˿ε�ѧ��'

UPDATE CourseBasic
SET Ccur=Ccur-1
WHERE CourseBasic.Cno='����Ŀ�'

/*��ѧ�𣺷���ѧУ����ֻ������߶ѧ�𣬸߶��������������������ֻ����һ��
�߶�����֮��ʼ���Ͷ�ù��߶��ֱ�Ӳ������� */
CREATE TRIGGER Update_sholar_status ON ScholarAppli
AFTER UPDATE
AS 
DECLARE @newRes char(1),@money SMALLINT
SELECT @newRes=newSchoAppli.Sno, @money=ScholarLst.money
FROM inserted newSchoAppli, ScholarLst
IF(@money>=5000 AND @newRes='1')
AS
	UPDATE ScholarAppli
END

/*�ڿ�ʼ����Ͷѧ���ʱ�����һ��ѧ���Ѿ�����˸߶��ô����ֱ�Ӳ���*/
CREATE TRIGGER Appli_sholar ON ScholarAppli
AFTER INSERT 
AS
DECLARE @newScholar varchar(20)
SELECT @newScholar=A1.Scholarship
FROM inserted A1
IF ((SELECT COUNT(ScholarLst.Scholarship)FROM ScholarLst, ScholarAppli WHERE Money>=5000 AND ScholarLst.Scholarship=ScholarAppli.Scholarship AND ScholarAppli.Response='1')>=1)
BEGIN
ROLLBACK TRANSACTION
END


	
	
/*ѧ��ѡ��
ʱ���ͻ�Ͳ���ѡ����ѡ��Ҫ+1*/

CREATE TRIGGER select_course ON Stu_Cour
AFTER INSERT
AS
DECLARE @newCno varchar(9), @newCterm SMALLINT
SELECT @newCno=SC.Cno, @newCterm=SC.Cterm
FROM inserted SC
IF((SELECT COUNT(CT1.Cno)
FROM CTime CT1, CTime CT2
WHERE CT2.Cterm=@newCterm AND CT2.Cno=@newCno AND CT2.Wday=CT1.Wday AND(NOT(CT1.Cbegin>CT2.Cend OR CT2.Cbegin>CT1.Cend)))>=1)
BEGIN
	ROLLBACK TRANSACTION
END
ELSE
BEGIN
	UPDATE CourseBasic
	SET Ccur=Ccur+1
	WHERE Cno=@newCno
END



/*��һ���鲻�ܶ���4����*/



