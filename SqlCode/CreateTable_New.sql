create table Systbl(
    stuNum SMALLINT,/*ѧ��������*/
)

create table Dept(
    Dname varchar(50) PRIMARY KEY,
    Dintro varchar(200),/*introduction*/
)


create table Student(
    Sno varchar(10) PRIMARY KEY,/*ѧ�ţ�ÿλ���������ַ�*/
    Sname varchar(10),
    Ssex char(2),/*Լ������orŮ*/
    Sdept varchar(50),/**/ 
    Sgrade char(4),/*��ѧ�꼶*/
    FOREIGN KEY(Sdept) REFERENCES Dept(Dname),
)

create table Teacher(
    Tno varchar(4) PRIMARY KEY,/*���ţ�ÿλ���������ַ�*/
    Tname varchar(10),
    Tdept varchar(50),
    FOREIGN KEY(Tdept) REFERENCES Dept(Dname),
)

/*
*ATTENTION����������
*һѧ���У�һ�ſ�ֻ��һ����ʦ���ڣ�ֻ��һ�Σ���������1��2������
*ÿ�ſεĿ�������һ����ÿ�ſ�ֻ��һ���Ͽεص�
*/
create table CourseBasic(
    Cno varchar(9)PRIMARY KEY,
    Cname varchar(50),
    Climit SMALLINT,/*ѡ����������*/
    Ccur SMALLINT,/*��ǰѡ��������ÿѡ�γɹ�һ���ˣ���Ҫ��Trigger����*/
    Cchar varchar(30),/*ѡ������*/
    Cdept varchar(50),
    Ccredit SMALLINT,
    Cgrade char(4),/*�����꼶*/
    FOREIGN KEY(Cdept) REFERENCES Dept(Dname) ,

)




create table CTime(
    Cno varchar(9),
    Cterm SMALLINT , /*����1��2*/
    Wday SMALLINT,
    Cbegin SMALLINT,
    Cend SMALLINT,
    FOREIGN KEY(Cno) REFERENCES CourseBasic(Cno)  ON DELETE CASCADE,
)
/*ѡ�β������ǵ�����*/

create table Tcourse(/*��ʦ�̿α�*/
    Cno varchar(9),
    Tno varchar(4),
    Cterm SMALLINT, /*����1��2*/
    FOREIGN KEY(Cno) REFERENCES CourseBasic(Cno) ON DELETE CASCADE,
    FOREIGN KEY(Tno) REFERENCES Teacher(Tno)ON DELETE CASCADE
    /*�ڵ�ǰѧ�ڵ��ﾳ�£�����Ҫָ��ѧ��*/
)

create table Stu_Cour(
    Sno varchar(10),
    Cno varchar(9), 
    Cterm SMALLINT, /*����1��2*/
    Grade SMALLINT,
    PRIMARY KEY(Sno, Cno, Cterm),
    FOREIGN KEY(Cno) REFERENCES CourseBasic(Cno) ON DELETE CASCADE ,
    FOREIGN KEY(Sno) REFERENCES Student(Sno) ON DELETE CASCADE ,
)

/*��ʦ��ѧ���������һЩ�������������ı��������Ա���룬����Ҫ��ѧ�������С��˿Σ����һ�����ڡ�����ʦ���涼��һ�����޸Ŀγ���Ϣ���Ĵ��ڣ������������ʵ������д�����ű��С�����д���֮����Sys���е�AdminNotice���1*/
/*������һ�������ԣ�һ���к����ܰ��������...*/
create table T2A(
    Tno varchar(4) NOT NULL,/*������ʦ����*/
    Rcontent varchar(200) NOT NULL,/*�������ݣ���٣��˿Σ��޸Ŀγ���������֮���*/
    Response varchar(50),/*Admin����*/
    FOREIGN KEY(Tno) REFERENCES Teacher(Tno) ON DELETE CASCADE,
    PRIMARY KEY(Tno, Rcontent),
)

create table S2A(
    Sno varchar(10) NOT NULL,/*����ѧ��ѧ��*/
    Rcontent varchar(200) NOT NULL,/*�������ݣ���٣��˿Σ��޸Ŀγ���������֮���*/
    Response varchar(50),/*Admin����*/
    FOREIGN KEY(Sno) REFERENCES Student(Sno)  ON DELETE CASCADE,
    PRIMARY KEY(Sno, Rcontent),
)


/*ѧ����������ʦ���뱨������Ŀ
���뱨������Ŀ�ɹ�Ϊ��ͨ����*/
create table ProjectLst(
    ProgramName varchar(40) PRIMARY KEY,
    Tno varchar(4) NOT NULL,
    ProIntro varchar(400),
    FOREIGN KEY(Tno) REFERENCES Teacher(Tno)  ON DELETE CASCADE,
)

/*��һ���뷨��֪���в��У���ÿ����Ŀ��4�ˣ�����������˿��Բ�ֹ�ĸ�
������ʦֻ��ͬ���ĸ�
Ȼ��ѧ���ӽǿ��Կ����Լ��Ƿ�ͨ��
��������Ŀ����ֻҪselect Response='ͨ��'�ͺ���

һ���������룬��������ʦ*/
create table ProjectAppli(
    Sno varchar(10), 
    ProjectName varchar(40),
    Reason varchar(400),
    Response varchar(6),/*ͨ�����߲�ͨ��*/
    FOREIGN KEY(Sno) REFERENCES Student(Sno) ON DELETE CASCADE ,
    FOREIGN KEY(ProjectName) REFERENCES ProjectLst(ProgramName) ON DELETE CASCADE ,
)



/*���뽱ѧ��֮��Admin���յ�����*/
/*��ѧ��չʾ��*/
create table ScholarLst(
    Scholarship varchar(20) PRIMARY KEY,
    SchoIntro varchar(200),/*��ѧ����ܣ�������ѡҪ��*/
    Money SMALLINT,/* ��5k�ȽϿ��Ƿ�߶һ�������Ѿ��õ��߶������߶ѧ��͵Ͷѧ�𲻿�������*/
)

/*��ѧ�������
���Ǻ�����һ����˼·��ѧ���ӽǿ��Կ����Լ��Ƿ�ͨ��
������Ŀ����ֻҪselect Response='ͨ��'�ͺ���
��Triggerʵ������Ѿ���һ��ͨ���ĸ߶����룬�򲻸�����

һ��ѧ����������һ���߶���ɵͶ�
�ȴӸ߶ʼ������һ��ѧ����ø߶ѧ��֮��������������״̬��ɲ��ɼ��*/
create table ScholarAppli(
    Sno varchar(10),
    Scholarship varchar(20),
    Reason varchar(200),
    Response char(1) CHECK(Response IN ('0','1','2','3')),/*1-ͨ��, 0-��ͨ��, 2-���ɼ�ã�3-δ���*/
    FOREIGN KEY(Sno) REFERENCES Student(Sno) ON DELETE CASCADE,
    FOREIGN KEY(Scholarship) REFERENCES ScholarLst(Scholarship) ON DELETE CASCADE 
)


