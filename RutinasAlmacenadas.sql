-- Llamar rutinas y funciones almacenadas almacenadas

-- Rutina BorroAlumno() para borrar un alumno de la tabla
CALL BorroAlumno(4);

-- Rutina InstertoAlumnos() para agregar un nuevo registro de alumnos
CALL InsertoAlumnos(4, 'Paco Hertz');

-- Rutina MaximaVenta
CALL MaximaVenta();

-- Funcion Almacenada GananciaVenta()
SELECT GananciaVentas(2018,6) AS Ganancia;

--  Funcion Almacenada UtilidadTotal()
SELECT UtilidadTotal('2018-01-01','2018-01-31');

-- Rutina ALmacenada CodigosABC()
CALL CodigosABC('2018-01-01','2018-01-01');