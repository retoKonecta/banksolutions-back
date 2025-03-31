--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

-- Started on 2025-03-31 16:04:43

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 858 (class 1247 OID 16412)
-- Name: enum_Sales_franchise; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."enum_Sales_franchise" AS ENUM (
    'AMEX',
    'VISA',
    'MASTERCARD'
);


ALTER TYPE public."enum_Sales_franchise" OWNER TO postgres;

--
-- TOC entry 855 (class 1247 OID 16405)
-- Name: enum_Sales_product; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."enum_Sales_product" AS ENUM (
    'Credito de Consumo',
    'Libranza Libre Inversión',
    'Tarjeta de Credito'
);


ALTER TYPE public."enum_Sales_product" OWNER TO postgres;

--
-- TOC entry 861 (class 1247 OID 16420)
-- Name: enum_Sales_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."enum_Sales_status" AS ENUM (
    'Open',
    'In Progress',
    'Completed'
);


ALTER TYPE public."enum_Sales_status" OWNER TO postgres;

--
-- TOC entry 849 (class 1247 OID 16390)
-- Name: enum_users_role; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_users_role AS ENUM (
    'Administrador',
    'Asesor'
);


ALTER TYPE public.enum_users_role OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 220 (class 1259 OID 16428)
-- Name: Sales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Sales" (
    id integer NOT NULL,
    product public."enum_Sales_product" NOT NULL,
    "requestedLimit" character varying(20) NOT NULL,
    franchise public."enum_Sales_franchise",
    rate numeric(4,2),
    status public."enum_Sales_status" DEFAULT 'Open'::public."enum_Sales_status",
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "createdBy" integer,
    "updatedBy" integer
);


ALTER TABLE public."Sales" OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16427)
-- Name: Sales_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Sales_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Sales_id_seq" OWNER TO postgres;

--
-- TOC entry 4932 (class 0 OID 0)
-- Dependencies: 219
-- Name: Sales_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Sales_id_seq" OWNED BY public."Sales".id;


--
-- TOC entry 218 (class 1259 OID 16396)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    email character varying(50) NOT NULL,
    password character varying(100) NOT NULL,
    role public.enum_users_role NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16395)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 4933 (class 0 OID 0)
-- Dependencies: 217
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 4760 (class 2604 OID 16431)
-- Name: Sales id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Sales" ALTER COLUMN id SET DEFAULT nextval('public."Sales_id_seq"'::regclass);


--
-- TOC entry 4759 (class 2604 OID 16399)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 4926 (class 0 OID 16428)
-- Dependencies: 220
-- Data for Name: Sales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Sales" (id, product, "requestedLimit", franchise, rate, status, "createdAt", "updatedAt", "createdBy", "updatedBy") FROM stdin;
4	Tarjeta de Credito	100000	VISA	9.00	Open	2025-03-31 10:49:25.109-05	2025-03-31 10:49:25.109-05	1	1
2	Credito de Consumo	100000	MASTERCARD	2.00	Open	2025-03-31 05:57:25.192-05	2025-03-31 15:04:14.772-05	1	1
\.


--
-- TOC entry 4924 (class 0 OID 16396)
-- Dependencies: 218
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, password, role, "createdAt", "updatedAt") FROM stdin;
1	caro	caro@gmail.com	$2b$10$5FeBjJdGf7dF4Vkv8BELS.Rpbe6TYxN9k1OhBz9EMFpsFJb.lPLcq	Administrador	2025-03-30 19:38:25-05	2025-03-30 19:38:25-05
\.


--
-- TOC entry 4934 (class 0 OID 0)
-- Dependencies: 219
-- Name: Sales_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Sales_id_seq"', 4, true);


--
-- TOC entry 4935 (class 0 OID 0)
-- Dependencies: 217
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 7, true);


--
-- TOC entry 4775 (class 2606 OID 16434)
-- Name: Sales Sales_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Sales"
    ADD CONSTRAINT "Sales_pkey" PRIMARY KEY (id);


--
-- TOC entry 4763 (class 2606 OID 16508)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 4765 (class 2606 OID 16510)
-- Name: users users_email_key1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key1 UNIQUE (email);


--
-- TOC entry 4767 (class 2606 OID 16512)
-- Name: users users_email_key2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key2 UNIQUE (email);


--
-- TOC entry 4769 (class 2606 OID 16514)
-- Name: users users_email_key3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key3 UNIQUE (email);


--
-- TOC entry 4771 (class 2606 OID 16516)
-- Name: users users_email_key4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key4 UNIQUE (email);


--
-- TOC entry 4773 (class 2606 OID 16401)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4776 (class 2606 OID 16519)
-- Name: Sales Sales_createdBy_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Sales"
    ADD CONSTRAINT "Sales_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 4777 (class 2606 OID 16524)
-- Name: Sales Sales_updatedBy_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Sales"
    ADD CONSTRAINT "Sales_updatedBy_fkey" FOREIGN KEY ("updatedBy") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE SET NULL;


-- Completed on 2025-03-31 16:04:43

--
-- PostgreSQL database dump complete
--

