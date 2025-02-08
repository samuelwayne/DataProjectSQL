Aquí voy a explicar las conclusiones que saco de mis consultas.

***

Pasos a seguir en la revisión del código copiado de DBeaver:
- Revisar el código para que haya coherencia
- Explicar partes poco claras con comentarios
- Analizar resultados de los que nos estoy seguro si están correctos
- Revisar tipos de JOINS utilizados

***
-CONSULTAS-

2 - Existen 195 películas catalogadas 'R'.

3 - Nombres y apellidos de los actores cuyo "actor_id" está entre 30 y 40.

4 - Se obtiene como resultado una tabla vacía. Al analizar de forma separada y agrupar por nombre del idioma y hacer un recuento total, se corrobora que efectivamente todas las películas están en el mismo idioma 'English' y que todos los valores de "original_language_id" son 'NULL', razón por la que no obtuvimos ningún resultado de vuelta con la consulta.

5 - En los resultados de los títulos según su duración vemos que el menor valor es 46 min y si cambiamos el 'ORDER BY' de modo que añadimos un 'DESC' al final vemos que el mayor valor es 185 min (se asume que la duración es en minutos además de por los enunciados).

6 - Sólo existen 3 actores cuyo apellido sea 'ALLEN'. Un detalle importante a tener en cuenta que he notado es que los valores deben ser escritos en mayúsculas, puesto que la consulta es sensible a las mayúsculas y por tanto, si escribimos 'Allen' no obtendremos ningún resultado.

7 - Vemos las cantidades para las 5 categorías que existen. De nuevo vemos que la cantida de películas categoría 'R' es 195 como vimos en la consulta 2. También podemos observar a simple vista que la categoría más común es 'PG-13' (223) y la menos común 'G' (178).

8 - El resultado obtenido es 253 películas, lo cuál es lógico puesto que hay 223 películas de la categoría 'PG-13' como vimos en la consulta anterior, por lo que añadiendo las que además duran más de 180 min ese resultado debería ser mayor.

9 - Los valores mínimo y máximo de reemplazo son entre 9,99 y 29,99; si bien desconocemos en qué tipo de moneda están devueltos los resultados.

10 - Los valores mínimo y máximo de duración de las películas son 46 min y 185 min.

11 - La cantidad del antepenúltimo alquiler fue de 0,99 y fue el 2006-02-14.

12 - Encontramos las películas ordenadas por orden alfabético y hay 612 películas que cumplen con el filtro establecido, un resultado lógico con las cantidades de películas según sus categorías que vimos en la consulta 7.

13 - En esta consulta vemos poca variabilidad en las medias de duración según sus categorías. Podemos concluir que es un resultado lógico dado que en una misma categoría puede haber resultados muy dispares de películas (géneros, duraciones... etc) y al ser una gran cantidad la media tiende hacia un valor común.

14 - Obtenemos solo 39 películas que pasan el filtro. Es un resultado lógico porque una duración mayor a 180 min está muy cerca del límite y los resultados serán escasos.

15 - Los beneficios obtenidos son de 67416,51; aunque desconocemos el tipo de moneda al que se refiere. El resultado es razonable dada la cantidad de alquileres registrados, la media del alquiler (unos 2,98) y posibles reemplazos.

16 - El cliente con mayor valor de "customer_id" es el 599 por lo que esa es la cantidad de clientes.

17 - En la película 'EGG IGBY' aparecen 5 actores.

18 - La cantidad de títulos distintos es de 1000, lo cuál nos indica que no hay títulos repetidos, puesto que también hay 1000 de cantidad en "film_id".

19 - Sólamente hay 3 comedias que duren más de 3h.

20 - En la consulta de medias de duración > 110 min según sus categorías vemos que las que tienen mayores valores de duración en promedio son aquellas correspondientes a 'Sports' y 'Games' (128 min). Además hay 13 categorías distintas cuya media de duración es superior a 110 min.

21 - En promedio las películas se suelen alquilar durante poco más de 4 días y medio.

22 - La consulta nos muestra que hay 200 actores y actrices.

23 - Los primeros valores obtenidos parecen lógicos, si bien son cantidades altas ya que obtenemos que se alquilaron entre más de 400 y más de 600 por día en los meses vacacionales de julio y agosto. Sin embargo, dado que en los últimos resultados la cantidad de alquileres son muy bajos en comparación, podríamos asumir que para el resto de fechas no aparecen resultados porque no se efectuó ningún alquiler (la cantidad total para esos días es 'NULL').

24 - Existen 489 películas cuya duración es mayor a la media. Es un resultado lógico por que en un cantidad grande de datos la media tiende a posicionarse cerca del centro, por eso el resultado es cercano a 500.

25 - Los resultados concuerdan con la consulta 23, puesto que suman la cantidad de alquileres que es 16044.

26 - La media 4,2 nos indica la cantidad que han pagado de media los clientes. Puesto que la cantidad media pagada es un poco mayor que la media del valor de alquiler podemos concluir que los clientes pagan algún tipo de interés añadido (sobre un 40%). La desviación estándar nos indica cuánto suele ser habitual que los valores se separen de la media y la varianza es el cuadrado de la desviación estándar.

27 - Los resultados obtenidos son 659, lo cual nos indica que casi 2/3 del total están por encima del precio medio. En vista también de los resultados obtenidos (parece que solo hay dos valores posibles 2,99 y 4,99), y sabiendo que también existe el precio de 0,99, parece que solamente hay esos 3 precios. Esto sería lógico en vista de la cantidad devuelta por la consulta.

28 - Solo hay dos actores que han participado en más de 40 películas.

29 - A simple vista parece que la disponibilidad de las películas está entre 0 (sin stock) y 8, habiendo disponibilidad para la mayoría.

30 - A simple vista, los actores han actuado en diferentes películas entre más de 10 y 40 (consulta 28).

31 - Obtenemos una tabla muy grande (5462 resultados) porque todos los datos de películas están repetidos para cada uno de los actores que aparecen en las mismas. De media podríamos decir que aparecen por película unos 5 actores.

32 - El tamaño de la tabla es igual al anterior (5462), lo cual nos indica que a pesar de haber utilizado 'LEFT JOINS' no debe existir ningún valor 'NULL'; tanto con el resultado de la consulta 31 como la 32, es decir que todo actor tiene películas asignadas y toda película tiene actores asignados.

33 - En total hay registrados 16044 alquileres, lo cual encaja con los datos ya obtenidos.

34 - Los cinco clientes que más dinero han gastado están en torno a 200, siendo 221,55 el mayor valor.

35 y 36 - Solo hay dos actores cuyo nombre sea 'JOHNNY'.

37 - Con esta consulta podemos ver claramente los límites de valor de "actor_id", corroborando de nuevo que hay 200 actores.

38 - Lo mismo que en el enunciado anterior.

39 - Nombres completos de actores ordenados por apellido alfabéticamente.

40 - Las cinco primeras películas de la tabla "film" parecen estar ordenadas por orden alfabético.

41 - Los dos nombres de actores son 'PENELOPE' y 'KENNETH', estando repetidos 4 veces.

42 - En esta consulta vemos el "rental_id" ordenado por número y con el correspondiente nombre del cliente que lo realizó.

43 - En esta consulta, similar a la anterior, también podemos ver el título de la película que alquiló.

44 - Esta consulta no tiene utilidad porque genera muchos datos que además no nos sirven porque ni siquiera sabemos a qué categoría corresponde cada película originalmente.

45 - Los actores que han hecho al menos una película de 'Action' son 166.

46 - De acuerdo con la conclusión que sacamos tras las consultas 31 y 32, vemos que esta consulta no devuleve reuslatdos puesto que todos los actores registrados han participado en películas.

47 - No veo diferencia con la consulta 30.

48 - Vista de actores y cantidad de películas en que han participado.

49 - En la consulta podemos observar que cada cliente a alquilado entre 12 y 46 películas.

50 - La duración total de todas las películas de la categoría 'Action' es 7143 min.

51 - Total de alquileres por clientes en CTE.

52 - Películas que han sido alquiladas más de 10 veces en CTE.

53 - Según esta consulta parece que 'TAMMY SANDERS' no tiene ninguna película pendiente por devolver.

54 - En esta consulta vemos que hay 167 actores que han actuado al menos una vez en la películas de la categoría 'Sci-Fi'.

55 - Actores que han actuado en películas que se alquilaron después de que ‘Spartacus Cheaper' se alquilara por primera vez, alfabéticamente por apellido. Hay cientos de películas alquiladas que pasan por este filtro, nos aporta poca información.

56 - Hay 56 actores que no han actuado en ninguna película de la categoría 'Music'.

57 - Hay casi 900 películas que se alquilaron por más de 8 días.

58 - Solo hay 66 películas de la categoría 'Animation'.

59 - Existen 7 películas más que duran lo mismo que 'DANCING FEVER' (sin contar la misma).

60 - Esta consulta es poco esclarecedora, pues de acuerdo con la consulta 16 podemos fijarnos que todos los clientes (599) han alquilado más de 7 películas distintas.

61 - Existen 16 categorías en total, siendo 'Sports' de la que más se han alquilado (1179) y 'Music' la menos alquilada (830).

62 - De nuevo, de películas estrenadas en 2006 la categoría más común es 'Sports' (74) y la menos común 'Music' (51). Podemos deducir que el porcentaje de películas según categoría es similar al total también con las películas estrenadas en 2006.

63 - Haciendo esta consulta nos damos cuenta de que solo existen 2 tiendas y 2 empleados.

64 - Cantidad de películas por clientes con sus nombres.
