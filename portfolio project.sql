/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [UniqueID ]
      ,[ParcelID]
      ,[LandUse]
      ,[PropertyAddress]
      ,[SaleDate]
      ,[SalePrice]
      ,[LegalReference]
      ,[SoldAsVacant]
      ,[OwnerName]
      ,[OwnerAddress]
      ,[Acreage]
      ,[TaxDistrict]
      ,[LandValue]
      ,[BuildingValue]
      ,[TotalValue]
      ,[YearBuilt]
      ,[Bedrooms]
      ,[FullBath]
      ,[HalfBath]
  FROM [PortfolioProject].[dbo].[NashfileHousing]

  select SaleDateconverted, CONVERT(date, saledate)
  from NashfileHousing

  select SaleDate, CONVERT(date, saledate)
  from NashfileHousing


  alter table nashfilehousing
  add Saledateconverted date;

  update NashfileHousing
  set SaleDateconverted = CONVERT(date, saledate)


  --property address
  select*
  from NashfileHousing
  where PropertyAddress is null
  order by ParcelID


  select*
  from NashfileHousing
  where PropertyAddress is not null
  order by ParcelID

select a.parcelid, a.propertyaddress, b.parcelid, b.propertyaddress,b.propertyaddress, ISNULL(a.propertyaddress, b.propertyaddress)
from NashfileHousing a
join NashfileHousing b
on a.parcelid = b.parcelid
and a.[uniqueid] <> b.[uniqueid]
where a.propertyaddress is null

update a
set propertyaddress = ISNULL(a.propertyaddress, b.propertyaddress)
from NashfileHousing a
join NashfileHousing b
on a.parcelid = b.parcelid
and a.[uniqueid] <> b.[uniqueid]
where a.propertyaddress is null


select propertyaddress
from NashfileHousing


SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as Address

from NashfileHousing

ALTER TABLE nashfilehousing
Add PropertySplitAddress Nvarchar(255);

Update NashfileHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )


ALTER TABLE nashfilehousing
Add PropertySplitCity Nvarchar(255);

Update NashfileHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))
 
 
Select *
From NashfileHousing


select owneraddress
from NashfileHousing
where OwnerAddress is not null 


select owneraddress
from NashfileHousing

Select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From NashfileHousing



Update NashfileHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)

ALTER TABLE NashfileHousing
Add OwnerSplitCity Nvarchar(255);

Update NashfileHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)


ALTER TABLE NashfileHousing
Add OwnerSplitState Nvarchar(255);

Update NashfileHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)



Select *
From NashfileHousing


select distinct (soldasvacant)
from NashfileHousing



select distinct (soldasvacant), count (soldasvacant)
from NashfileHousing

group by SoldAsVacant
order by 2


select soldasvacant
, case when soldasvacant = 'Y' then 'Yes'
when soldasvacant = 'N' then 'No'
else soldasvacant
end
from nashfilehousing


Update nashfilehousing
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END

select *
from NashfileHousing


alter table nashfilehousing
drop column taxdistrict


select *
from NashfileHousing

