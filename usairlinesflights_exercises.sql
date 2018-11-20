/* 1. Quantitat de registres de la taula de vols. */

SELECT count(flightID)
FROM usairlineflights2.flights;

/* 2. Retard promig de sortida i arribada segons l’aeroport origen. */

SELECT origin as 'Aeroport Origen', avg(ArrDelay) as 'Retard Arribada', avg(DepDelay) as 'Retard Sortida' 
FROM usairlineflights2.flights 
group by 'Aeroport Origen';

/* 3.  Retard promig d’arribada dels vols, per mesos i segons l’aeroport origen. A més, volen que els resultat 
es mostrin de la següent forma (fixa’t en l’ordre de les files) */

SELECT origin as 'Aeroport Origen', colYear as 'Any', colMonth as 'Mes',  avg(ArrDelay) as 'Retard Arribada'
FROM usairlineflights2.flights 
group by 'Aeroport Origen', 'Any', 'Mes'
order by 'Aeroport Origen', 'Any', 'Mes' asc;

/* 4. Retard promig d’arribada dels vols, per mesos i segons l’aeroport origen (mateixa consulta que abans
 i amb el mateix ordre). Però a més, ara volen que en comptes del codi de l’aeroport es mostri el nom de la ciutat. */

SELECT CONCAT(City,', ',
	   colYear,', ',
       RIGHT(CONCAT('0',colMonth),2),', ',
       IF(AVG(ArrDelay)>0,'delay','on time')) AS DelayByCity
FROM Flights
LEFT JOIN USAirports
ON Flights.Origin=USAirports.IATA
GROUP BY Origin, colYear, colMonth
ORDER BY Origin, colYear, colMonth;

/* 5.  Les companyies amb més vols cancelats. A més, han d’estar ordenades de forma que les companyies amb més cancelacions
 apareguin les primeres.  */

SELECT description as 'Nom companyia aèria', count(cancelled) as 'Vols Cancel·lats' 
FROM usairlineflights2.flights
INNER JOIN usairlineflights2.carriers  
ON carriers.CarrierCode = flights.UniqueCarrier 
where cancelled = 1
group by description 
order by 'Vols Cancel·lats' desc;

/* 6. L’identificador dels 10 avions que més distància han recorregut fent vols. */

SELECT TailNum,SUM(Distance) AS TotalMiles
FROM Flights
WHERE NOT TailNum LIKE 'NA'
GROUP BY TailNum
ORDER BY SUM(Distance) DESC
LIMIT 10;

/* 7. Companyies amb el seu retard promig només d’aquelles les quals els seus vols arriben
 al seu destí amb un retràs promig major de 10 minuts.  */

SELECT Description as 'Companyia', avg(ArrDelay) as 'Retard'
FROM usairlineflights2.flights
LEFT JOIN usairlineflights2.carriers
ON flights.UniqueCarrier = carriers.CarrierCode
group by Companyia
HAVING Retard > 10

/* Done */