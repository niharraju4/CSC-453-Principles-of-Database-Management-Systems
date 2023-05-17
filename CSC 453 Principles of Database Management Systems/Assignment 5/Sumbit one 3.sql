DROP TABLE CONTRACT CASCADE CONSTRAINTS;

DROP TABLE TASK CASCADE CONSTRAINTS;

 

CREATE TABLE TASK (

TaskID CHAR(3),

TaskName VARCHAR(20),

ContractCount NUMERIC(1,0) DEFAULT 0,

CONSTRAINT PK_TASK PRIMARY KEY (TaskID)

);

 

CREATE TABLE CONTRACT

(

TaskID CHAR(3),

WorkerID CHAR(7),

Payment NUMERIC(6,2),

CONSTRAINT PK_CONTRACT PRIMARY KEY (TaskID, WorkerID),

CONSTRAINT FK_CONTRACTTASK FOREIGN KEY (TaskID) REFERENCES TASK (TaskID)

);

 
 

INSERT INTO TASK (TaskID, TaskName) VALUES ('555', 'Security' );

INSERT INTO TASK (TaskID, TaskName) VALUES ('444', 'Infrastructure');

INSERT INTO TASK (TaskID, TaskName) VALUES ('777', 'Compliance' );

 

SELECT * FROM TASK;

COMMIT;




create or replace trigger newContract 
before insert on contract 
for each row

declare
acontractCount task.contractcount%TYPE;

begin
    select contractcount into acontractcount from task
        where taskid = :new.taskid;
        
        if acontractCount = 3 then -- no more room
            raise_application_error (-20888, 'Error: the task is full');         
        else
       
            update task
            set contractcount = contractcount +1
            where taskid = :new.taskid;
        end if;
end;


create or replace trigger EndContract
after delete on contract 

for each row -- row-level

begin
  
    update task
    set contractcount = contractcount -1
    where taskid = :old.taskid;
end;


create or replace trigger NoChanges
before update on contract

begin
    raise_application_error (-20889, 'Error: no updates are permitted to existing rows of CONTRACT');         
end;


-- FIRST 3 COMMANDS WILL EXECUTE 4TH wont be able to exectue
INSERT INTO CONTRACT (TaskID, WorkerID, Payment) VALUES ('555', '879', 1.0 );
INSERT INTO CONTRACT (TaskID, WorkerID, Payment) VALUES ('555', '789', 2.0 );
INSERT INTO CONTRACT (TaskID, WorkerID, Payment) VALUES ('555', '256', 3.0 );
INSERT INTO CONTRACT (TaskID, WorkerID, Payment) VALUES ('555', '234', 4.0 );
-- the last line wony get executed
delete from contract where WorkerID = 22;
delete from contract where WorkerID = 33;
INSERT INTO CONTRACT (TaskID, WorkerID, Payment) VALUES ('555', '11', 1.0 );
INSERT INTO CONTRACT (TaskID, WorkerID, Payment) VALUES ('555', '22', 2.0 );
INSERT INTO CONTRACT (TaskID, WorkerID, Payment) VALUES ('555', '33', 3.0 );
-- test noChanges trigger
update contract set payment = 12312 where taskid = 555;