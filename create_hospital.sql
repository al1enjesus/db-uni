CREATE TABLE H_Doctor 
    ( 
     ID_DOCTOR INTEGER NOT NULL , 
     SURNAME VARCHAR(50) , 
     FIRSTNAME VARCHAR(50) , 
     MIDDLE_NAME VARCHAR(50) ,
     code_spec INTEGER NOT NULL     
     );

ALTER TABLE H_Doctor 
    ADD CONSTRAINT "Doctor PK" PRIMARY KEY ( ID_Doctor ) ;

CREATE TABLE H_Patient 
    ( 
     N_CARD INTEGER , 
     SURNAME VARCHAR(50) , 
     FIRSTNAME VARCHAR(50), 
     MIDDLE_NAME VARCHAR(50), 
     ADDRESS VARCHAR(50), 
     Phone CHAR(13)
    ) 
;

ALTER TABLE H_PATIENT 
    ADD CONSTRAINT Patient_PK PRIMARY KEY ( N_CARD ) ;

CREATE TABLE H_Services 
    ( 
     CODE_SRV INTEGER NOT NULL , 
     TITLE VARCHAR(50), 
     Price NUMERIC(8,2) 
    ) 
;

ALTER TABLE H_Services 
    ADD CONSTRAINT "Services PK" PRIMARY KEY ( Code_Srv ) ;

CREATE TABLE H_Speciality 
    ( 
     CODE_SPEC INTEGER NOT NULL , 
     Title VARCHAR(50)
    ) 
;

ALTER TABLE H_Speciality 
    ADD CONSTRAINT "Speciality PK" PRIMARY KEY ( Code_Spec ) ;

CREATE TABLE H_Visit 
    ( 
     N_Visit INTEGER NOT NULL , 
     ID_Doctor INTEGER , 
     ID_Patient INTEGER , 
     DATE_VISIT DATE ,     
     CODE_SRV INTEGER     
    ) 
;

ALTER TABLE H_Visit 
    ADD CONSTRAINT "Visit PK" PRIMARY KEY ( N_Visit ) ;

ALTER TABLE H_Visit 
    ADD CONSTRAINT DOCTOR_VISIT FOREIGN KEY 
    ( ID_DOCTOR ) 
    REFERENCES H_DOCTOR 
    ( ID_Doctor ) 
;

ALTER TABLE H_Doctor 
    ADD CONSTRAINT Spec_Doctor FOREIGN KEY 
    ( 
     code_spec
    ) 
    REFERENCES H_Speciality 
    ( 
     CODE_SPEC
    ) 
;

ALTER TABLE H_Visit 
    ADD CONSTRAINT Srv_Visit FOREIGN KEY 
    ( 
     CODE_SRV
    ) 
    REFERENCES H_Services 
    ( 
     CODE_SRV
    ) 
;

ALTER TABLE H_Visit 
    ADD CONSTRAINT Visit_Patient FOREIGN KEY 
    ( 
     ID_Patient
    ) 
    REFERENCES H_Patient 
    ( 
     N_CARD
    ) 
;
