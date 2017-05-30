CREATE PROCEDURE LoadVendorsIntoDatabase
AS
BEGIN
	-- load vendor
	INSERT INTO [vendor] (Code, [Name], [Address], City, [State], Zip, Phone, Email, IsPreapproved)
		VALUES ('AMAZ0001', 'Amazon', '123 Any Street', 'Cincinnati', 'OH', '45209', NULL, NULL, 1)

	INSERT INTO [vendor] (Code, [Name], [Address], City, [State], Zip, Phone, Email, IsPreapproved)
		VALUES ('TARG0100', 'Target', '123 Any Street', 'Cincinnati', 'OH', '45209', NULL, NULL, 1)

	INSERT INTO [vendor] (Code, [Name], [Address], City, [State], Zip, Phone, Email, IsPreapproved)
		VALUES ('COST0333', 'Costco', '123 Any Street', 'Cincinnati', 'OH', '45209', NULL, NULL, 1)

	-- load product
	DECLARE @vendorId int

	-- Amazon products
	SELECT @vendorId = id FROM [vendor] WHERE code = 'AMAZ001'
	INSERT INTO [product] (VendorID, [Name], PartNumber, Price, Unit, PhotoPath)
		VALUES (@vendorId, 'Echo', 'AMZN-Echo', 99.99, 'Each', NULL)
END


-- exec LoadVendorsIntoDatabase