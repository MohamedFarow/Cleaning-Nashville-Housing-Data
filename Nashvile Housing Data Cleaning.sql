--Standarizing Data
use PortfolioProject
select * from NashvileHousing

select saledate, convert(date, saledate) from NashvileHousing

update NashvileHousing set SaleDate = convert(date, saledate)
alter table NashvileHousing add SalesDateCnverted date
update NashvileHousing set SalesDateCnverted =  convert(date,SaleDate)
-- Populating propert adress and finding if there is null value, if found a null then make a join on the tabl itself 

select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, isnull(a.PropertyAddress,b.PropertyAddress) from NashvileHousing a
join NashvileHousing b
on a.ParcelID = b.ParcelID and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null




update a set propertyaddress = isnull(a.propertyaddress, b.propertyaddress)
from NashvileHousing a join NashvileHousing b  on a.ParcelID = b.ParcelID and a.[UniqueID ] <> b.[UniqueID ] 
where a.PropertyAddress is null


--Breaking address into individual Columns
select * from NashvileHousing

select 
SUBSTRING(propertyaddress,1, CHARINDEX(',', propertyaddress)-1) as adress,
SUBSTRING(propertyaddress,CHARINDEX(',', PropertyAddress)+1, len(propertyaddress)) as Address
from NashvileHousing

alter table NashvileHousing add PropertySplitAddress nvarchar(255)

update NashvileHousing set PropertySplitAddress =  SUBSTRING(propertyaddress,1, CHARINDEX(',', propertyaddress)-1) 

alter table NashvileHousing add PropertySplitCity nvarchar(255)

update NashvileHousing set PropertySplitCity = SUBSTRING(propertyaddress,CHARINDEX(',', PropertyAddress)+1, len(propertyaddress))

sp_rename 'NashvileHousing.PrpoertySplitAddress', 'NewColumnName';

Select * from NashvileHousing

select owneraddress from NashvileHousing

select 
PARSENAME (replace(owneraddress,',','.'),3),
PARSENAME (replace(owneraddress,',','.'),2),
PARSENAME (replace(owneraddress,',','.'),1)
from NashvileHousing

alter table NashvileHousing add OwnerSplitAddress nvarchar(255)

update NashvileHousing set OwnerSplitAddress =  PARSENAME (replace(owneraddress,',','.'),3)

alter table NashvileHousing add OwnerSplitCity nvarchar(255)

update NashvileHousing set OwnerSplitCity = PARSENAME (replace(owneraddress,',','.'),2)

alter table NashvileHousing add OwnerSplitState nvarchar(255)

update NashvileHousing set OwnerSplitState =  PARSENAME (replace(owneraddress,',','.'),1)
alter table nashvilehousing drop column NewColumnName

------

select distinct(soldasvacant) ,count(soldasvacant) from NashvileHousing
group by soldasvacant
order by 2

select soldasvacant, case when soldasvacant ='Y' then 'Yes'
	 when soldasvacant = 'N' then 'No'
	 else SoldAsVacant
	 end
from NashvileHousing

update NashvileHousing 
set SoldAsVacant = case when soldasvacant ='Y' then 'Yes'
	 when soldasvacant = 'N' then 'No'
	 else SoldAsVacant
	 end

	 -- Detecting Duplicates 
	 with rownumcte as (
	 select *, 
	 ROW_NUMBER() over(
	 partition by parcelid,propertyaddress,saleprice,saledate,legalreference order by uniqueid) row_num
	 from NashvileHousing
	 --order by ParcelID
	 ) 
	 select * from rownumcte where row_num >1 order by PropertyAddress

	 -- Removing Duplicates

	  with rownumcte as (
	 select *, 
	 ROW_NUMBER() over(
	 partition by parcelid,propertyaddress,saleprice,saledate,legalreference order by uniqueid) row_num
	 from NashvileHousing
	 --order by ParcelID
	 ) 
	 delete  from rownumcte where row_num >1 --order by PropertyAddress
	select *, ROW_NUMBER() over(partition by uniqueid order by uniqueid)as row_num from NashvileHousing order by ParcelID

	select * from NashvileHousing

	alter table nashvilehousing 
	drop column owneraddress,propertyaddress,taxdistrict,saledate
	