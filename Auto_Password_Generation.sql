Create procedure Get_
--personal
@fname nvarchar(200),
@lname nvarchar(200),
@dob date,

--contact
@mno nvarchar(200),
@email nvarchar(250),
@coid int,
@sid int,

--bank
@bankano bigint,
@bname nvarchar(100),
@brname nvarchar(100),
@actype nvarchar(100)

as
begin

    declare @eid int,
            @empcode nvarchar(250),
            @year nvarchar(100),
            @username nvarchar(250),
            @password nvarchar(300)

    set @eid=(select COUNT(*) from ContactDetailsMaster where MobileNo=@mno and EmailId=@email)+1
    set @year= (select YEAR(getdate()))
    set @empcode=CONCAT('E-',SUBSTRING(@mno,7,4),@year,@eid)
    set @username=@email
    set @password= CONCAT(RIGHT(@fname,3), RIGHT(@lname,2),
                   DATEDIFF(YEAR,@dob,GETDATE()),month(getdate()),@eid,YEAR(getdate()))

    insert into PersonalDetailsMaster (EmployeeCode, FirstName,LastName,DateOfBirth,Age)
    values(@empcode, @fname, @lname,@dob,DATEDIFF(YEAR,@dob,GETDATE()))
    set @eid=@@IDENTITY

    insert into ContactDetailsMaster(EmployeeId,MobileNo,EmailId,CountryId,StateId)
    values(@eid,@mno,@email,@coid,@sid)

    insert into BankDetalsMaster (EmployeeId,BankAccountNo,BankName,BranchName,AccountType)
    values (@eid,@bankano,@bname,@brname,@actype)

    insert into LogIn(UserName,Password,EmployeeId,IsActive)
    values (@username,@password,@eid,1)
end 