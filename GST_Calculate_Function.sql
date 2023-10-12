create function Get_GST (@FID int)
returns decimal (10,2)
AS
BEGIN

    declare @Price decimal(10,2)
    declare @Discount decimal(10,2)
    declare @Total decimal(10,2)
    declare @SGST decimal(10,2)
    declare @CGST decimal(10,2)

    set @Price=(select Price from FoodMaster where FoodId=@FID )
    set @CGST = (@Price9/100)
    set @SGST = (@Price9/100)
    set @Discount = (@Price*5/100)
    set @Total = (@Price + @CGST + @SGST - @Discount)

return @Total
END

print dbo.Get_GST (1)