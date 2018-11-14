/* 1. Cantidad de registros de vuelos. */

SELECT count(flightID)
FROM usairlineflights2.flights;

/* 2. Retardo promedio de salida y llegada según el aeropuerto de origen. */

SELECT origin as 'Aeroport Origen', avg(ArrDelay) as 'Retard Arribada', avg(DepDelay) as 'Retard Sortida' 
FROM usairlineflights2.flights 
group by 'Aeroport Origen';

/* 3.  Retardo promedio de llegada de los vuelos, por meses y según el aeropuerto de origen: */

SELECT origin as 'Aeroport Origen', colYear as 'Any', colMonth as 'Mes',  avg(ArrDelay) as 'Retard Arribada'
FROM usairlineflights2.flights 
group by 'Aeroport Origen', 'Any', 'Mes'
order by 'Aeroport Origen', 'Any', 'Mes' asc;

/* 4. Retardo promedio de llegada de los vuelos, por meses y según el aeropuerto de
origen (misma consulta que antes y con el mismo orden. Además, ahora queremos que en lugar
del código del aeropuerto se muestre el nombre de la ciudad. */

SELECT airport as 'Aeroport Origen', colYear as 'Any', colMonth as 'Mes',  avg(ArrDelay) as 'Retard Arribada'
FROM usairlineflights2.usairports 
INNER JOIN usairlineflights2.flights 
ON usairports.IATA = flights.flightID 
group by 'Aeroport Origen', 'Any', 'Mes'
order by 'Aeroport Origen', 'Any', 'Mes' asc;

/* 5. Compañías con más vuelos cancelados. Además han de estar ordenadas de forma que
las compañias con más cancelaciones aparezcan las primeras. */

SELECT description as 'Nom companyia aèria', count(cancelled) as 'Vols Cancel·lats' 
FROM usairlineflights2.flights
INNER JOIN usairlineflights2.carriers  
ON carriers.CarrierCode = flights.UniqueCarrier 
where cancelled = 1
group by description 
order by 'Vols Cancel·lats' desc;

/* 6. El identificador de los 10 aviones que más kilómetros han recorrido haciendo
vuelos comerciales. */

SELECT TailNum as 'Avió', sum(distance) as 'Distància' 
from usairlineflights2.flights 
group by TailNum 
order by Distància 
DESC LIMIT 10;

/* Compañías con su retardo promedio, pero solo de aquellas cuyos vuelos llegan a su
destino con un retraso promedio mayor de 10 minutos. */

SELECT Description as 'Companyia', avg(ArrDelay) as 'Retard'
FROM usairlineflights2.flights
LEFT JOIN usairlineflights2.carriers
ON flights.UniqueCarrier = carriers.CarrierCode
group by Companyia
HAVING Retard > 10

/* Done */