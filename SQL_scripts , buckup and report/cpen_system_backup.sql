--
-- PostgreSQL database dump
--

-- Dumped from database version 16.9
-- Dumped by pg_dump version 16.9

-- Started on 2025-06-22 21:03:55

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 223 (class 1255 OID 16570)
-- Name: get_outstanding_fees(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_outstanding_fees() RETURNS json
    LANGUAGE plpgsql
    AS $$
DECLARE
    result JSON;
BEGIN
    SELECT json_agg(
        json_build_object(
            'student_id', student_id,
            'academic_year', academic_year,
            'total_fee_amount', total_fee_amount,
            'amount_paid', amount_paid,
            'outstanding_fee', total_fee_amount - amount_paid
        )
    ) INTO result
    FROM fees;

    RETURN result;
END;
$$;


ALTER FUNCTION public.get_outstanding_fees() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 216 (class 1259 OID 16521)
-- Name: courses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.courses (
    course_id integer NOT NULL,
    course_code character varying(20) NOT NULL,
    course_title character varying(225) NOT NULL,
    credits integer NOT NULL
);


ALTER TABLE public.courses OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16554)
-- Name: enrollments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.enrollments (
    enrollment_id integer NOT NULL,
    student_id integer NOT NULL,
    course_id integer NOT NULL,
    enrollment_date date DEFAULT CURRENT_DATE,
    grade character varying(2)
);


ALTER TABLE public.enrollments OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16542)
-- Name: fees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fees (
    fee_id integer NOT NULL,
    student_id integer NOT NULL,
    academic_year character varying(20) NOT NULL,
    total_fee_amount numeric(10,2) NOT NULL,
    amount_paid numeric(10,2) DEFAULT 0.00,
    payment_date date DEFAULT CURRENT_DATE
);


ALTER TABLE public.fees OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16528)
-- Name: lecturers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lecturers (
    lecturer_id integer NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    email character varying(100) NOT NULL
);


ALTER TABLE public.lecturers OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16513)
-- Name: students; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.students (
    student_id integer NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    date_of_birth date,
    gender character varying(10),
    admission_date date DEFAULT CURRENT_DATE
);


ALTER TABLE public.students OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16535)
-- Name: teaching_assistant; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.teaching_assistant (
    ta_id integer NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    email character varying(100) NOT NULL
);


ALTER TABLE public.teaching_assistant OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16576)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying(120),
    password_hash character varying(170) NOT NULL,
    username character varying(40)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16575)
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
-- TOC entry 4950 (class 0 OID 0)
-- Dependencies: 221
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 4764 (class 2604 OID 16579)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 4938 (class 0 OID 16521)
-- Dependencies: 216
-- Data for Name: courses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.courses (course_id, course_code, course_title, credits) FROM stdin;
101801	CPEN101	Introduction to Engineering	2
101802	MATH201	Calculus I	4
101803	ENG102	Academic Writing	3
101804	PHY104	General Physics	3
101805	CHEM105	Applied Electricity	3
101806	CPEN210	Software Engineering	3
101809	CPEN215	Datbase Systems Design	3
101810	SENG201	Introduction to Programming	3
101807	CPEN202	Data Communication	3
101808	CPEN208	Data Structures and Algorithm	3
\.


--
-- TOC entry 4942 (class 0 OID 16554)
-- Dependencies: 220
-- Data for Name: enrollments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.enrollments (enrollment_id, student_id, course_id, enrollment_date, grade) FROM stdin;
5001	22061868	101801	2024-09-01	A
5002	22102226	101802	2024-09-02	B+
5003	22109631	101803	2024-09-03	A-
5004	22167139	101804	2024-09-04	B
5005	22026602	101805	2024-09-05	C+
5006	22131339	101806	2024-09-06	A
5007	22043997	101807	2024-09-07	B-
5008	22043774	101808	2024-09-08	C
5009	22121444	101809	2024-09-09	B+
5010	22163384	101810	2024-09-10	A
5011	22012424	101801	2024-09-11	C+
5012	22014453	101802	2024-09-12	B
5013	22132121	101803	2024-09-13	A-
5014	22043540	101804	2024-09-14	B-
5015	22019085	101805	2024-09-15	C
5016	22250041	101806	2024-09-16	A
5017	22040299	101807	2024-09-17	B+
5018	22025934	101808	2024-09-18	A-
5019	22098362	101809	2024-09-19	B
5020	22083064	101810	2024-09-20	C+
5021	22232978	101801	2024-09-21	A
5022	11365437	101802	2024-09-22	B-
5023	22039499	101803	2024-09-23	C
5024	22148117	101804	2024-09-24	B+
5025	22018349	101805	2024-09-25	A
5026	22031160	101806	2024-09-26	C+
5027	22012574	101807	2024-09-27	B
5028	22071976	101808	2024-09-28	A-
5029	22163947	101809	2024-09-29	B-
5030	22021280	101810	2024-09-30	C
\.


--
-- TOC entry 4941 (class 0 OID 16542)
-- Dependencies: 219
-- Data for Name: fees; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fees (fee_id, student_id, academic_year, total_fee_amount, amount_paid, payment_date) FROM stdin;
8301	22061868	2024/2025	2500.00	1500.00	2025-01-15
4928	22102226	2024/2025	2700.00	2000.00	2025-02-10
6293	22109631	2024/2025	2600.00	1000.00	2025-03-05
3754	22167139	2024/2025	2800.00	2800.00	2025-04-12
5102	22026602	2024/2025	2400.00	1200.00	2025-05-20
7115	22131339	2024/2025	2500.00	500.00	2025-06-25
8330	22043997	2024/2025	2900.00	2900.00	2025-07-14
1924	22043774	2024/2025	2600.00	2000.00	2025-08-08
4107	22121444	2024/2025	2700.00	1700.00	2025-09-30
6579	22163384	2024/2025	2500.00	500.00	2025-10-15
7250	22012424	2024/2025	2550.00	1800.00	2025-01-20
3205	22014453	2024/2025	2650.00	1200.00	2025-02-15
4096	22132121	2024/2025	2450.00	950.00	2025-03-25
8741	22043540	2024/2025	2800.00	2800.00	2025-04-05
5338	22019085	2024/2025	2500.00	500.00	2025-05-10
9110	22250041	2024/2025	2700.00	2000.00	2025-06-17
2824	22040299	2024/2025	2900.00	2900.00	2025-07-22
6457	22025934	2024/2025	2600.00	1300.00	2025-08-27
3874	22098362	2024/2025	2500.00	800.00	2025-09-14
7261	22083064	2024/2025	2750.00	2750.00	2025-10-01
5379	22232978	2024/2025	2650.00	1500.00	2025-01-11
6592	11365437	2024/2025	2400.00	1200.00	2025-02-22
3408	22039499	2024/2025	2850.00	2850.00	2025-03-08
8119	22148117	2024/2025	2600.00	1300.00	2025-04-14
9427	22018349	2024/2025	2500.00	900.00	2025-05-07
1083	22031160	2024/2025	2750.00	2750.00	2025-06-30
4627	22012574	2024/2025	2800.00	1900.00	2025-07-12
3759	22071976	2024/2025	2500.00	600.00	2025-08-19
8124	22163947	2024/2025	2650.00	1300.00	2025-09-22
2036	22021280	2024/2025	2550.00	2550.00	2025-10-28
9483	22122810	2024/2025	2500.00	1000.00	2025-01-06
5629	22046970	2024/2025	2750.00	2750.00	2025-02-14
3057	22047065	2024/2025	2850.00	1600.00	2025-03-30
7902	22231991	2024/2025	2500.00	750.00	2025-04-15
8231	22064019	2024/2025	2700.00	2000.00	2025-05-20
1347	22046462	2024/2025	2600.00	1400.00	2025-06-10
6759	22066228	2024/2025	2550.00	2550.00	2025-07-30
4896	22154235	2024/2025	2800.00	2800.00	2025-08-21
2375	22049764	2024/2025	2750.00	1700.00	2025-09-10
9182	22243185	2024/2025	2500.00	500.00	2025-10-05
\.


--
-- TOC entry 4939 (class 0 OID 16528)
-- Dependencies: 217
-- Data for Name: lecturers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lecturers (lecturer_id, first_name, last_name, email) FROM stdin;
1	John	Assiamah	jassiahmah@ug.edu.gh
2	Jane	Smith	janesmith@ug.edu.gh
3	Michael	Owusu	michaelowusu@ug.edu.gh
4	Ama	Boateng	amaboateng@ug.edu.gh
5	Kwame	Mensah	kwamemensah@ug.edu.gh
6	Akosua	Appiah	akosuaappiah@ug.edu.gh
7	Emmanuel	Tetteh	emmanueltetteh@ug.edu.gh
8	Patricia	Asare	patriciaasare@ug.edu.gh
9	Francis	Agyeman	francisagyeman@ug.edu.gh
10	Sarah	Quartey	sarahquartey@ug.edu.gh
\.


--
-- TOC entry 4937 (class 0 OID 16513)
-- Dependencies: 215
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.students (student_id, first_name, last_name, email, date_of_birth, gender, admission_date) FROM stdin;
22061868	Abdallah Abdul	Haleem	aaabdallah@ug.st.edu.gh	2004-07-12	Male	2024-01-01
22102226	Adda	Jefferson	ajjefferson@ug.st.edu.gh	2004-11-23	Male	2024-01-03
22109631	Adu Damoah	Herbert	adherbert@ug.st.edu.gh	2005-03-05	Male	2024-01-05
22167139	Aganyi	Magdalene	ammagdalene@ug.st.edu.gh	2005-06-17	Female	2024-01-07
22026602	Agnes Katherine	Aboagye	akaboagye@ug.st.edu.gh	2006-09-29	Female	2024-01-09
22131339	Ahiafrogah	John Godson	ajgodson@ug.st.edu.gh	2004-02-02	Male	2024-01-11
22043997	Aidoo-Taylor	Kwamena	atkwamena@ug.st.edu.gh	2005-10-08	Male	2024-01-13
22043774	Akowuah Addo	Baffour	aabaffour@ug.st.edu.gh	2004-05-20	Male	2024-01-15
22121444	Akuffo Addo	Thelma	aathelma@ug.st.edu.gh	2006-08-14	Female	2024-01-17
22163384	Alfred	Darkwa	addarkwa@ug.st.edu.gh	2005-12-30	Male	2024-01-19
22012424	Amilkar	Hayonmie	ahhayonmie@ug.st.edu.gh	2005-04-03	Male	2024-01-21
22014453	Amo	Joshua	ajjoshua@ug.st.edu.gh	2004-09-10	Male	2024-01-23
22132121	Amoah Pearl	Owusua	apowusua@ug.st.edu.gh	2006-06-25	Female	2024-01-25
22043540	Andoh	Osgood Junior	aojunior@ug.st.edu.gh	2005-01-01	Male	2024-01-27
22019085	Aopare	Benedict	abbenedict@ug.st.edu.gh	2006-11-05	Male	2024-01-29
22250041	Asare Andrews	Larbi	aalarbi@ug.st.edu.gh	2004-02-27	Male	2024-01-31
22040299	Ashitey Glenn Nii	Ashiteyfio	agnashiteyfio@ug.st.edu.gh	2005-07-19	Male	2024-01-02
22025934	Asiedu	Nana Yaw	anyaw@ug.st.edu.gh	2006-10-31	Male	2024-01-04
22098362	Baah	Christopher	bcchristopher@ug.st.edu.gh	2004-03-21	Male	2024-01-06
22083064	Baidu	Sarah	bsarah@ug.st.edu.gh	2005-12-09	Female	2024-01-08
22232978	Boateng Kissi	Benjamin	bkbenjamin@ug.st.edu.gh	2006-05-14	Male	2024-01-10
11365437	Captain	Godsgift	cggodsgift@ug.st.edu.gh	2004-08-22	Male	2024-01-12
22039499	Chinbuah Ankrah Ryangel Nii	Amponsah	carankrah@ug.st.edu.gh	2005-06-06	Male	2024-01-14
22148117	Daniel Delawoe	Fugar	ddfugar@ug.st.edu.gh	2006-09-01	Male	2024-01-16
22018349	Dunyo	Derrick	ddderrick@ug.st.edu.gh	2004-04-07	Male	2024-01-18
22031160	Edmond	Asoe	eaasoe@ug.st.edu.gh	2005-11-15	Male	2024-01-20
22012574	Effah Asare	Kofi	eakofi@ug.st.edu.gh	2006-02-08	Male	2024-01-22
22071976	Eklo	Christopher Yao	ecyao@ug.st.edu.gh	2004-07-28	Male	2024-01-24
22163947	Ekumah	Mark Kwamena	emkwamena@ug.st.edu.gh	2005-10-11	Male	2024-01-26
22021280	Emmanuel	Mozu - Simpson	emsimpson@ug.st.edu.gh	2006-03-03	Female	2024-01-28
22122810	Erica Yaa	Kwakye	eykwakye@ug.st.edu.gh	2004-06-30	Male	2024-01-30
22046970	Essilfie Nana Yaw	Amoako	enamoako@ug.st.edu.gh	2006-08-25	Male	2024-01-01
22047065	Gyamfi George Kwabena	Kuffour	gkkuffour@ug.st.edu.gh	2005-01-17	Male	2024-01-03
22231991	Henry Otwey	Baidoo	hobbaidoo@ug.st.edu.gh	2004-09-04	Male	2024-01-05
22064019	Issaka Abdul-Hakeem	Timbilla	ihtimbilla@ug.st.edu.gh	2005-04-29	Male	2024-01-07
22046462	Ivan Nii Lartey	Boye	ilboye@ug.st.edu.gh	2006-11-20	Male	2024-01-09
22066228	Jessica Amemor	Yorm	jayorm@ug.st.edu.gh	2004-06-12	Male	2024-01-11
22154235	Julius	Babanawo	jbabanawo@ug.st.edu.gh	2005-08-08	Male	2024-01-13
22049764	Krampah	Jonathan	kjjonathan@ug.st.edu.gh	2006-10-02	Male	2024-01-15
22243185	Kwofie	Seth Pius	kspius@ug.st.edu.gh	2004-02-05	Male	2024-01-17
22020624	Manal Abdul - Kadi	Mohammed	makadi@ug.st.edu.gh	2005-07-27	Male	2024-01-19
22013980	Mcgorni Attipoe	El-Hark	maelhark@ug.st.edu.gh	2006-12-18	Male	2024-01-21
22042860	Mensah	Philemon	mphilemon@ug.st.edu.gh	2004-03-09	Male	2024-01-23
22047984	Misorya	Mosore	mmmosore@ug.st.edu.gh	2005-09-22	Male	2024-01-25
22032191	Nana Boakye Osei	Frimpong	nboafimpong@ug.st.edu.gh	2006-05-06	Male	2024-01-27
22046644	Ofori	Godfred Safo	ogsaforo@ug.st.edu.gh	2004-08-14	Male	2024-01-29
22225243	Ohnyu	Lee	olee@ug.st.edu.gh	2005-02-28	Male	2024-01-31
22060951	Oppong	Joseph Yaw	ojyaw@ug.st.edu.gh	2006-07-01	Male	2024-01-02
22069520	Paa Kodwo Mensa	Odom	pkomensa@ug.st.edu.gh	2004-10-16	Male	2024-01-04
22123779	Prince Henry Afedi	Dadebo	phdadebo@ug.st.edu.gh	2005-04-04	Male	2024-01-06
22045499	Prince	Yeboah	pyeboah@ug.st.edu.gh	2006-11-10	Male	2024-01-08
22017451	Princess	Azumah	pazumah@ug.st.edu.gh	2004-06-23	Female	2024-01-10
22242417	Quao	Jonathan	qjonathan@ug.st.edu.gh	2005-08-19	Male	2024-01-12
22089266	Sarpong Achiaa	Akosua	saakosua@ug.st.edu.gh	2006-12-02	Female	2024-01-14
22016968	Sarpong Jeffrey	Somuah	sjsomuah@ug.st.edu.gh	2004-02-09	Male	2024-01-16
22246299	Sasu	Thomas Ansong	stan@ug.st.edu.gh	2005-07-31	Male	2024-01-18
22087947	Sherrif Issaka	Akparibo	siaakparibo@ug.st.edu.gh	2006-10-28	Male	2024-01-20
22012489	Tetteh	Emmanuel Etornam	teeetornam@ug.st.edu.gh	2004-03-17	Male	2024-01-22
22206565	Tiburu	Elvis Kwason	tekquason@ug.st.edu.gh	2005-09-21	Male	2024-01-24
22245852	Ukachukwu	Jubilee	ujubilee@ug.st.edu.gh	2006-05-12	Male	2024-01-26
22138141	Waniyaki A	Hamdallah	wahamdallah@ug.st.edu.gh	2004-08-26	Male	2024-01-28
22077794	Zeh	Etornam Edmund	zeedmund@ug.st.edu.gh	2005-11-30	Male	2024-01-30
10720838	Fynn	Emmanuel Junior	fejunior@ug.st.edu.gh	2006-04-15	Male	2024-01-20
\.


--
-- TOC entry 4940 (class 0 OID 16535)
-- Dependencies: 218
-- Data for Name: teaching_assistant; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.teaching_assistant (ta_id, first_name, last_name, email) FROM stdin;
201801	Eric	Mensah	ericmensah@ug.edu.gh
201802	Sandra	Owusu	sandraowusu@ug.edu.gh
201803	James	Tetteh	jamestetteh@ug.edu.gh
201804	Linda	Amoah	lindaamoah@ug.edu.gh
201805	Michael	Boateng	michaelboateng@ug.edu.gh
201806	Patricia	Asare	patriciaasare@ug.edu.gh
201807	Francis	Nyarko	francisnyarko@ug.edu.gh
201808	Joyce	Appiah	joyceappiah@ug.edu.gh
201809	Emmanuel	Kuffour	emmanuelkuffour@ug.edu.gh
201810	Sarah	Quartey	sarahquartey@ug.edu.gh
\.


--
-- TOC entry 4944 (class 0 OID 16576)
-- Dependencies: 222
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, password_hash, username) FROM stdin;
1	aoparebenedict@gmail.com	$2b$10$B6yzgs38RVUfYaEcy0xuK.0aHyOD0V4V/FOiPmPtS9Jqk3ePPl45u	ben1z
2	aoparebenedict1@gmail.com	$2b$10$ufIathRKcC47JCytIxCT.uXn/FFS9Xb3/8kXwh/v/9rHg/HN1rRfi	ben
3	aoparebenedict3@gmail.com	$2b$10$/kzhiIldrBqJ6KTjIT05HeQpxhruD4/7S3BUBT7oMLrbMvPn3ULLu	benn
4	j@gmail.com	$2b$10$x4VbBIsHsV6zvGqy/KviFOxtUeaDtvIJXbaxocwsG0uGltnO4ymoa	jj
\.


--
-- TOC entry 4951 (class 0 OID 0)
-- Dependencies: 221
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 4, true);


--
-- TOC entry 4770 (class 2606 OID 16527)
-- Name: courses courses_course_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_course_code_key UNIQUE (course_code);


--
-- TOC entry 4772 (class 2606 OID 16525)
-- Name: courses courses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (course_id);


--
-- TOC entry 4784 (class 2606 OID 16559)
-- Name: enrollments enrollments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT enrollments_pkey PRIMARY KEY (enrollment_id);


--
-- TOC entry 4782 (class 2606 OID 16548)
-- Name: fees fees_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fees
    ADD CONSTRAINT fees_pkey PRIMARY KEY (fee_id);


--
-- TOC entry 4774 (class 2606 OID 16534)
-- Name: lecturers lecturers_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lecturers
    ADD CONSTRAINT lecturers_email_key UNIQUE (email);


--
-- TOC entry 4776 (class 2606 OID 16532)
-- Name: lecturers lecturers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lecturers
    ADD CONSTRAINT lecturers_pkey PRIMARY KEY (lecturer_id);


--
-- TOC entry 4766 (class 2606 OID 16520)
-- Name: students students_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_email_key UNIQUE (email);


--
-- TOC entry 4768 (class 2606 OID 16518)
-- Name: students students_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_pkey PRIMARY KEY (student_id);


--
-- TOC entry 4778 (class 2606 OID 16541)
-- Name: teaching_assistant teaching_assistant_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teaching_assistant
    ADD CONSTRAINT teaching_assistant_email_key UNIQUE (email);


--
-- TOC entry 4780 (class 2606 OID 16539)
-- Name: teaching_assistant teaching_assistant_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teaching_assistant
    ADD CONSTRAINT teaching_assistant_pkey PRIMARY KEY (ta_id);


--
-- TOC entry 4786 (class 2606 OID 16583)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 4788 (class 2606 OID 16581)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4790 (class 2606 OID 16585)
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- TOC entry 4792 (class 2606 OID 16565)
-- Name: enrollments enrollments_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT enrollments_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.courses(course_id);


--
-- TOC entry 4793 (class 2606 OID 16560)
-- Name: enrollments enrollments_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT enrollments_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(student_id);


--
-- TOC entry 4791 (class 2606 OID 16549)
-- Name: fees fees_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fees
    ADD CONSTRAINT fees_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(student_id);


-- Completed on 2025-06-22 21:03:55

--
-- PostgreSQL database dump complete
--

