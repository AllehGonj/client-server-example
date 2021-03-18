CREATE ROLE dbuser;
ALTER
ROLE dbuser WITH PASSWORD NULL;

CREATE TABLE ESTUDIANTE
(
    codigo            VARCHAR(10) NOT NULL,
    apellidos         VARCHAR(20) NOT NULL,
    nombres           VARCHAR(20) NOT NULL,
    genero            CHAR(1)     NOT NULL,
    fecha_nacimmiento DATE        NOT NULL,
    ciudad            VARCHAR(30) NOT NULL,
    telefono          VARCHAR(10),

    CONSTRAINT id_pk_est PRIMARY KEY (codigo)
);

CREATE TABLE DOCENTE
(
    id            VARCHAR(12) NOT NULL,
    nombre        VARCHAR(30) NOT NULL,
    profesion     VARCHAR(30) NOT NULL,
    especialdiad  VARCHAR(40),
    celular       VARCHAR(10),
    fecha_entrada DATE        NOT NULL,
    CONSTRAINT id_pk_doc PRIMARY KEY (id)
);

CREATE TABLE MATERIA
(
    codigo      VARCHAR(10) NOT NULL,
    descripcion VARCHAR(20) NOT NULL,
    creditos    SMALLINT    NOT NUll,

    CONSTRAINT id_pk_mat PRIMARY KEY (codigo)
);

CREATE TABLE CLASE
(
    codigo       VARCHAR(10) NOT NULL,
    fecha_inicio DATE        NOT NULL,
    fecha_fin    DATE        NOT NULL,
    id_materia   VARCHAR(10) NOT NULL,
    id_docente   VARCHAR(12) NOT NULL,

    CONSTRAINT id_pk_cla PRIMARY KEY (codigo)
);

CREATE TABLE INSCRIPCION
(
    codigo        VARCHAR(10) NOT NULL,
    observaciones VARCHAR(40) NOT NULL,
    id_clase      VARCHAR(10) NOT NULL,
    id_estudiante VARCHAR(10) NOT NULL,

    CONSTRAINT id_pk_ins PRIMARY KEY (codigo)
);

CREATE TABLE NOTA
(
    id             SMALLINT,
    nota           NUMERIC(2, 1) NOT NUll,
    id_inscripcion VARCHAR(10)   NOT NULL,

    CONSTRAINT id_pk_not PRIMARY KEY (id)
);


ALTER TABLE CLASE
    ADD CONSTRAINT cla_fk_mat FOREIGN KEY (id_materia) REFERENCES MATERIA (codigo),
    ADD CONSTRAINT cla_fk_doc FOREIGN KEY (id_docente) REFERENCES DOCENTE (id);

ALTER TABLE INSCRIPCION
    ADD CONSTRAINT ins_fk_cla FOREIGN KEY (id_clase) REFERENCES CLASE (codigo),
    ADD CONSTRAINT ins_fk_est FOREIGN KEY (id_estudiante) REFERENCES ESTUDIANTE (codigo);

ALTER TABLE NOTA
    ADD CONSTRAINT not_fk_ins FOREIGN KEY (id_inscripcion) REFERENCES INSCRIPCION (codigo);


INSERT INTO ESTUDIANTE (codigo, apellidos, nombres, genero, fecha_nacimmiento, ciudad, telefono)
VALUES ('201612345',
        'Amezquita Mesa',
        'Viviana',
        'F',
        '07/12/92',
        'tunja',
        '3012141833');

INSERT INTO ESTUDIANTE (codigo, apellidos, nombres, genero, fecha_nacimmiento, ciudad, telefono)
VALUES ('201622345',
        'Gonzalez Rodriguez',
        'Alejandro',
        'M',
        '07/07/98',
        'tunja',
        '3004997995');

INSERT INTO ESTUDIANTE (codigo, apellidos, nombres, genero, fecha_nacimmiento, ciudad, telefono)
VALUES ('201632345',
        'Castellanos',
        'Julian',
        'M',
        '07/12/92',
        'tunja',
        '3012141834');

INSERT INTO DOCENTE
    (id, nombre, profesion, especialdiad, celular, fecha_entrada)
VALUES ('123456',
        'profe1',
        'Ingeniero de sistemas',
        'programacion',
        '3012141834',
        '07/12/92');

INSERT INTO DOCENTE
    (id, nombre, profesion, especialdiad, celular, fecha_entrada)
VALUES ('789456',
        'profe2',
        'Ingeniero de sistemas',
        'Bases de datos',
        '3012141834',
        '07/12/92');

INSERT INTO DOCENTE
    (id, nombre, profesion, especialdiad, celular, fecha_entrada)
VALUES ('456123',
        'profe3',
        'Ingeniero de sistemas',
        'Redes',
        '3012141834',
        '07/12/92');

INSERT INTO MATERIA
    (codigo, descripcion, creditos)
VALUES ('MT01',
        'Sistemas Operativos',
        8);

INSERT INTO MATERIA
    (codigo, descripcion, creditos)
VALUES ('MT02',
        'Programacion I',
        8);

INSERT INTO MATERIA
    (codigo, descripcion, creditos)
VALUES ('MT03',
        'Sistemas Operativos',
        8);

INSERT INTO CLASE
    (codigo, fecha_inicio, fecha_fin, id_materia, id_docente)
VALUES ('C1',
        '07/02/20',
        '07/05/20',
        'MT01',
        '456123');

INSERT INTO CLASE
    (codigo, fecha_inicio, fecha_fin, id_materia, id_docente)
VALUES ('C2',
        '07/02/20',
        '07/05/20',
        'MT02',
        '456123');

INSERT INTO CLASE
    (codigo, fecha_inicio, fecha_fin, id_materia, id_docente)
VALUES ('C3',
        '07/02/20',
        '07/05/20',
        'MT03',
        '789456');

INSERT INTO INSCRIPCION
    (codigo, observaciones, id_clase, id_estudiante)
VALUES ('I1',
        '20 estudiantes max',
        'C1',
        '201612345');

INSERT INTO INSCRIPCION
    (codigo, observaciones, id_clase, id_estudiante)
VALUES ('I2',
        '20 estudiantes max',
        'C2',
        '201612345');

INSERT INTO INSCRIPCION
    (codigo, observaciones, id_clase, id_estudiante)
VALUES ('I3',
        '20 estudiantes max',
        'C3',
        '201612345');

INSERT INTO INSCRIPCION
    (codigo, observaciones, id_clase, id_estudiante)
VALUES ('I4',
        '20 estudiantes max',
        'C1',
        '201622345');

INSERT INTO INSCRIPCION
    (codigo, observaciones, id_clase, id_estudiante)
VALUES ('I5',
        '20 estudiantes max',
        'C1',
        '201632345');

INSERT INTO INSCRIPCION
    (codigo, observaciones, id_clase, id_estudiante)
VALUES ('I6',
        '20 estudiantes max',
        'C3',
        '201632345');

INSERT INTO NOTA(id, nota, id_inscripcion)
VALUES (1, 1.1, 'I1');

INSERT INTO NOTA(id, nota, id_inscripcion)
VALUES (2, 4.2, 'I2');

INSERT INTO NOTA(id, nota, id_inscripcion)
VALUES (3, 3.5, 'I3');

INSERT INTO NOTA(id, nota, id_inscripcion)
VALUES (4, 2.8, 'I4');

INSERT INTO NOTA(id, nota, id_inscripcion)
VALUES (5, 3.7, 'I5');

INSERT INTO NOTA(id, nota, id_inscripcion)
VALUES (6, 1.5, 'I6');

-- Datos del Profesor con datos de las materias asignadas
SELECT d.*, m.*
FROM materia m
         INNER JOIN CLASE c ON m.codigo = c.id_materia
         INNER JOIN DOCENTE d on c.id_docente = d.id
WHERE d.id = '456123';

-- Datos del Profesor con la suma de las materias asignadas
SELECT d.*, COUNT(m.codigo) suma_materias
FROM materia m
         INNER JOIN CLASE c ON m.codigo = c.id_materia
         INNER JOIN DOCENTE d ON c.id_docente = d.id
WHERE d.id = '456123'
GROUP BY d.id;

-- Nombre de Estudiante, nombre de materia, y nota definitiva
SELECT e.nombres,
       (SELECT m.descripcion
        FROM inscripcion ins
                 INNER JOIN CLASE c ON ins.id_clase = c.codigo
                 INNER JOIN Materia m ON c.id_materia = m.codigo
        WHERE ins.codigo = i.codigo),
       n.nota
FROM estudiante e
         INNER JOIN INSCRIPCION i ON e.codigo = i.id_estudiante
         INNER JOIN nota n ON n.id_inscripcion = i.codigo
where e.codigo = '201612345';

-- Datos de la clase con el promedio general de notas de todos los estudiantes
SELECT c.*, ROUND(AVG(n.nota), 1) promedio
FROM clase c
         INNER JOIN INSCRIPCION i ON c.codigo = i.id_clase
         INNER JOIN nota n ON n.id_inscripcion = i.codigo
GROUP BY c.codigo;

-- Datos del estudiante con cuantas materias tiene inscritas
SELECT e.*, COUNT(*) materias_ins
FROM estudiante e
         INNER JOIN INSCRIPCION i ON e.codigo = i.id_estudiante
WHERE e.codigo = '201612345'
GROUP BY e.codigo;
