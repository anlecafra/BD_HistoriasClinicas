CREATE TABLE IF NOT EXISTS "Angel Calderón".diagnosticos
(
    id integer NOT NULL DEFAULT nextval('"Angel Calderón".diagnosticos_id_seq'::regclass),
    codigo character varying(10) COLLATE pg_catalog."default" NOT NULL,
    descripcion character varying(255) COLLATE pg_catalog."default" NOT NULL,
    activo boolean NOT NULL DEFAULT true,
    CONSTRAINT diagnosticos_pkey PRIMARY KEY (id)
)

CREATE TABLE IF NOT EXISTS "Angel Calderón".eps
(
    id integer NOT NULL DEFAULT nextval('"Angel Calderón".eps_id_seq'::regclass),
    codigo character varying(10) COLLATE pg_catalog."default" NOT NULL,
    descripcion character varying(255) COLLATE pg_catalog."default" NOT NULL,
    regimen character varying(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT eps_pkey PRIMARY KEY (id),
    CONSTRAINT regimen FOREIGN KEY (id)
        REFERENCES "Angel Calderón".regimenes (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

CREATE TABLE IF NOT EXISTS "Angel Calderón".especialidades
(
    id integer NOT NULL DEFAULT nextval('"Angel Calderón".especialidades_id_seq'::regclass),
    descripcion character varying(100) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT especialidades_pkey PRIMARY KEY (id)
)
CREATE TABLE IF NOT EXISTS "Angel Calderón".medicamentos
(
    id integer NOT NULL DEFAULT nextval('"Angel Calderón".medicamentos_id_seq'::regclass),
    codigo_cum character varying(20) COLLATE pg_catalog."default" NOT NULL,
    descripcion character varying(255) COLLATE pg_catalog."default" NOT NULL,
    activo boolean NOT NULL DEFAULT true,
    CONSTRAINT medicamentos_pkey PRIMARY KEY (id)
)

CREATE TABLE IF NOT EXISTS "Angel Calderón".ordenes_medicas
(
    id_orden integer NOT NULL DEFAULT nextval('"Angel Calderón".ordenes_medicas_id_orden_seq'::regclass),
    id_registro_clinico integer NOT NULL,
    fecha_orden date NOT NULL,
    fecha_vencimiento date NOT NULL,
    medicamento integer,
    procedimiento integer,
    CONSTRAINT ordenes_medicas_pkey PRIMARY KEY (id_orden),
    CONSTRAINT medicamentos FOREIGN KEY (medicamento)
        REFERENCES "Angel Calderón".medicamentos (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT procedimiento FOREIGN KEY (id_orden)
        REFERENCES "Angel Calderón".procedimientos (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

CREATE TABLE IF NOT EXISTS "Angel Calderón".pacientes
(
    id integer NOT NULL DEFAULT nextval('"Angel Calderón".pacientes_id_seq'::regclass),
    documento character varying(50) COLLATE pg_catalog."default" NOT NULL,
    primer_nombre character varying(100) COLLATE pg_catalog."default" NOT NULL,
    segundo_nombre character varying(100) COLLATE pg_catalog."default",
    primer_apellido character varying(100) COLLATE pg_catalog."default" NOT NULL,
    segundo_apellido character varying(100) COLLATE pg_catalog."default",
    fecha_nacimiento date NOT NULL,
    genero character varying(10) COLLATE pg_catalog."default" NOT NULL,
    ocupacion character varying(100) COLLATE pg_catalog."default" NOT NULL,
    direccion character varying(255) COLLATE pg_catalog."default" NOT NULL,
    telefono character varying(20) COLLATE pg_catalog."default",
    correo_electronico character varying(100) COLLATE pg_catalog."default",
    eps integer,
    CONSTRAINT pacientes_pkey PRIMARY KEY (id),
    CONSTRAINT eps FOREIGN KEY (eps)
        REFERENCES "Angel Calderón".eps (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

CREATE TABLE IF NOT EXISTS "Angel Calderón".procedimientos
(
    id integer NOT NULL DEFAULT nextval('"Angel Calderón".procedimientos_id_seq'::regclass),
    codigo_cup character varying(20) COLLATE pg_catalog."default" NOT NULL,
    descripcion character varying(255) COLLATE pg_catalog."default" NOT NULL,
    activo boolean NOT NULL DEFAULT true,
    CONSTRAINT procedimientos_pkey PRIMARY KEY (id)
)

CREATE TABLE IF NOT EXISTS "Angel Calderón".profesionales
(
    id integer NOT NULL DEFAULT nextval('"Angel Calderón".profesionales_id_seq'::regclass),
    documento character varying(20) COLLATE pg_catalog."default" NOT NULL,
    nombres character varying(100) COLLATE pg_catalog."default" NOT NULL,
    apellidos character varying(100) COLLATE pg_catalog."default" NOT NULL,
    codigo_especialidad integer NOT NULL,
    registro_profesional character varying(50) COLLATE pg_catalog."default" NOT NULL,
    direccion character varying(255) COLLATE pg_catalog."default" NOT NULL,
    telefono character varying(20) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT profesionales_pkey PRIMARY KEY (id),
    CONSTRAINT especialidad FOREIGN KEY (codigo_especialidad)
        REFERENCES "Angel Calderón".especialidades (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)
CREATE TABLE IF NOT EXISTS "Angel Calderón".regimenes
(
    id integer NOT NULL DEFAULT nextval('"Angel Calderón".regimenes_id_seq'::regclass),
    descripcion character varying(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT regimenes_pkey PRIMARY KEY (id)
)
CREATE TABLE IF NOT EXISTS "Angel Calderón".registros_clinicos
(
    id_hc integer NOT NULL DEFAULT nextval('"Angel Calderón".registros_clinicos_id_hc_seq'::regclass),
    fecha_hc timestamp without time zone NOT NULL,
    pacientes_id_pcientes integer NOT NULL,
    "Motivo_consulta" character varying(50) COLLATE pg_catalog."default" NOT NULL,
    "Peso" integer NOT NULL,
    "Talla" integer NOT NULL,
    "tensión Arterial" integer NOT NULL,
    "Frecuencia Cardiaca" integer NOT NULL,
    "Frecuencia respiratoria" integer NOT NULL,
    "Diagnostico principal" integer NOT NULL,
    "Diagnostico secundario" integer NOT NULL,
    tratamiento character varying(500) COLLATE pg_catalog."default" NOT NULL,
    profesional integer,
    ordenes_medicas integer,
    CONSTRAINT registros_clinicos_pkey PRIMARY KEY (id_hc),
    CONSTRAINT "diagnostico 1" FOREIGN KEY ("Diagnostico principal")
        REFERENCES "Angel Calderón".diagnosticos (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT "diagnostico 2" FOREIGN KEY ("Diagnostico secundario")
        REFERENCES "Angel Calderón".diagnosticos (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT ordenes_medicas FOREIGN KEY (ordenes_medicas)
        REFERENCES "Angel Calderón".ordenes_medicas (id_orden) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT pacientes FOREIGN KEY (pacientes_id_pcientes)
        REFERENCES "Angel Calderón".pacientes (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT profesional FOREIGN KEY (profesional)
        REFERENCES "Angel Calderón".profesionales (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT "tesnion arterial" FOREIGN KEY ("tensión Arterial")
        REFERENCES "Angel Calderón".tension_arterial (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

CREATE TABLE IF NOT EXISTS "Angel Calderón".tension_arterial
(
    id integer NOT NULL DEFAULT nextval('"Angel Calderón".tension_arterial_id_seq'::regclass),
    usuario_id integer NOT NULL,
    fecha timestamp without time zone DEFAULT now(),
    sistolica integer NOT NULL,
    diastolica integer NOT NULL,
    observaciones text COLLATE pg_catalog."default",
    CONSTRAINT tension_arterial_pkey PRIMARY KEY (id),
    CONSTRAINT tension_arterial_diastolica_check CHECK (diastolica >= 30 AND diastolica <= 150),
    CONSTRAINT tension_arterial_sistolica_check CHECK (sistolica >= 50 AND sistolica <= 250)
)


