--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.10
-- Dumped by pg_dump version 9.6.13

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
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: admin; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin (
    username character varying NOT NULL,
    password character varying NOT NULL
);


ALTER TABLE public.admin OWNER TO postgres;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id character varying NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user (
    id character varying NOT NULL,
    username character varying NOT NULL,
    password character varying NOT NULL,
    first_name character varying,
    last_name character varying,
    email character varying,
    phone_number character varying,
    is_active boolean DEFAULT true NOT NULL,
    status integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.auth_user OWNER TO postgres;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_groups (
    id integer NOT NULL,
    group_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO postgres;

--
-- Name: bank; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bank (
    id character varying NOT NULL,
    name character varying NOT NULL,
    registration_number character varying,
    address character varying,
    phone_number character varying,
    scb_address character varying DEFAULT ''::character varying NOT NULL,
    token_symbol character varying DEFAULT ''::character varying NOT NULL,
    sub_domain character varying NOT NULL,
    balance numeric(18,2) DEFAULT 0.00
);


ALTER TABLE public.bank OWNER TO postgres;

--
-- Name: bank_documents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bank_documents (
    id character varying NOT NULL,
    bank_id character varying NOT NULL,
    document_type character varying NOT NULL,
    document_name character varying
);


ALTER TABLE public.bank_documents OWNER TO postgres;

--
-- Name: bank_fixed_loan_product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bank_fixed_loan_product (
    id character varying NOT NULL,
    name character varying DEFAULT ''::character varying NOT NULL,
    principle numeric(18,2) NOT NULL,
    interest numeric(18,2) NOT NULL,
    time_period integer NOT NULL,
    bank_id character varying NOT NULL,
    tnc_document_id character varying NOT NULL,
    rule_id character varying DEFAULT ''::character varying NOT NULL,
    emi numeric(18,2) NOT NULL
);


ALTER TABLE public.bank_fixed_loan_product OWNER TO postgres;

--
-- Name: bank_sme_partnership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bank_sme_partnership (
    id character varying NOT NULL,
    bank_id character varying NOT NULL,
    sme_id character varying NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    scrm_address character varying DEFAULT ''::character varying NOT NULL,
    scrm_channel character varying DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.bank_sme_partnership OWNER TO postgres;

--
-- Name: bank_transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bank_transactions (
    id character varying NOT NULL,
    bank_id character varying NOT NULL,
    date_of_payment character varying NOT NULL,
    amount_paid numeric(18,2) NOT NULL,
    transaction_type integer NOT NULL,
    transaction_id character varying NOT NULL,
    loan_product_id character varying DEFAULT ''::character varying NOT NULL,
    approved_by_bank_user character varying DEFAULT ''::character varying NOT NULL,
    transaction_description character varying DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.bank_transactions OWNER TO postgres;

--
-- Name: bank_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bank_user (
    id character varying NOT NULL,
    auth_user_id character varying NOT NULL,
    bank_id character varying NOT NULL
);


ALTER TABLE public.bank_user OWNER TO postgres;

--
-- Name: document_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.document_types (
    id character varying NOT NULL,
    name character varying NOT NULL,
    validity integer
);


ALTER TABLE public.document_types OWNER TO postgres;

--
-- Name: network_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.network_config (
    id character varying NOT NULL,
    org_id character varying NOT NULL,
    org_name character varying NOT NULL,
    no_of_peers integer NOT NULL,
    end_point character varying NOT NULL,
    base_contract_version character varying DEFAULT 'v1'::character varying NOT NULL,
    scl_version character varying DEFAULT 'v1'::character varying NOT NULL,
    channel_name character varying NOT NULL,
    msp_id character varying NOT NULL,
    endorsing_peer character varying NOT NULL
);


ALTER TABLE public.network_config OWNER TO postgres;

--
-- Name: otp_table; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.otp_table (
    phone_number character varying NOT NULL,
    email character varying,
    username character varying,
    otp character varying NOT NULL,
    lastotpgenerationtime bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.otp_table OWNER TO postgres;

--
-- Name: rule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rule (
    id character varying NOT NULL,
    rule text NOT NULL,
    bank_id character varying NOT NULL,
    loan_product_rule text NOT NULL,
    tnc_document_id character varying DEFAULT ''::character varying NOT NULL,
    status integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.rule OWNER TO postgres;

--
-- Name: rule_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rule_type (
    id character varying NOT NULL,
    active integer NOT NULL
);


ALTER TABLE public.rule_type OWNER TO postgres;

--
-- Name: sme; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sme (
    id character varying NOT NULL,
    name character varying DEFAULT ''::character varying NOT NULL,
    registration_number character varying DEFAULT ''::character varying NOT NULL,
    address character varying DEFAULT ''::character varying NOT NULL,
    phone_number character varying DEFAULT ''::character varying NOT NULL,
    year_of_incorporation integer DEFAULT 0,
    city character varying DEFAULT ''::character varying NOT NULL,
    state character varying DEFAULT ''::character varying NOT NULL,
    description character varying DEFAULT ''::character varying NOT NULL,
    emi_day integer DEFAULT 15 NOT NULL,
    segment character varying DEFAULT ''::character varying NOT NULL,
    sub_segment character varying DEFAULT ''::character varying NOT NULL,
    sector_churn numeric(18,2) DEFAULT 0.00 NOT NULL,
    sector_attrition_reason character varying DEFAULT ''::character varying NOT NULL,
    spoc_name character varying DEFAULT ''::character varying NOT NULL,
    spoc_designation character varying DEFAULT ''::character varying NOT NULL,
    spoc_employee_id character varying DEFAULT ''::character varying NOT NULL,
    spoc_email_id character varying DEFAULT ''::character varying NOT NULL,
    spoc_contact_no_mobile character varying DEFAULT ''::character varying NOT NULL,
    spoc_contact_no_landline character varying DEFAULT ''::character varying NOT NULL,
    pbt numeric(18,2) DEFAULT 0.00 NOT NULL,
    pat numeric(18,2) DEFAULT 0.00 NOT NULL,
    turn_over numeric(18,2) DEFAULT 0.00 NOT NULL,
    no_of_employees integer DEFAULT 0 NOT NULL,
    asset_heaviness character varying DEFAULT ''::character varying NOT NULL,
    avg_staff_tenure integer DEFAULT 0 NOT NULL,
    permanent_staff_percentage numeric(18,2) DEFAULT 0.00 NOT NULL,
    avg_salary_bracket numeric(18,2) DEFAULT 0.00 NOT NULL,
    reputation_rating character varying DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.sme OWNER TO postgres;

--
-- Name: sme_custom_rules; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sme_custom_rules (
    id character varying NOT NULL,
    rule_id character varying NOT NULL,
    bank_sme_partnership_id character varying NOT NULL
);


ALTER TABLE public.sme_custom_rules OWNER TO postgres;

--
-- Name: sme_documents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sme_documents (
    id character varying NOT NULL,
    sme_id character varying NOT NULL,
    document_type character varying NOT NULL,
    document character varying,
    is_verified boolean DEFAULT false NOT NULL
);


ALTER TABLE public.sme_documents OWNER TO postgres;

--
-- Name: sme_employee_banks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sme_employee_banks (
    id character varying NOT NULL,
    name character varying(255) NOT NULL,
    branch character varying(255),
    ifsc_code character varying(100)
);


ALTER TABLE public.sme_employee_banks OWNER TO postgres;

--
-- Name: sme_employee_loan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sme_employee_loan (
    id character varying NOT NULL,
    sme_user_id character varying NOT NULL,
    sme_id character varying NOT NULL,
    sme_approval_status integer DEFAULT 0 NOT NULL,
    lender_approval_status integer DEFAULT 0 NOT NULL,
    loan_status integer DEFAULT 0 NOT NULL,
    principle numeric(18,2) NOT NULL,
    interest numeric(18,2) NOT NULL,
    time_period integer NOT NULL,
    bank_id character varying NOT NULL,
    reason character varying DEFAULT ''::character varying NOT NULL,
    creation_timestamp bigint NOT NULL,
    loan_start_timestamp bigint DEFAULT 0 NOT NULL,
    scl_address character varying DEFAULT ''::character varying NOT NULL,
    monthly_emi numeric(18,2) NOT NULL,
    flagged_reason character varying DEFAULT ''::character varying NOT NULL,
    loan_product_id character varying DEFAULT ''::character varying NOT NULL,
    rule_id character varying DEFAULT ''::character varying NOT NULL,
    remaining_time_period integer NOT NULL,
    amount_paid numeric(18,2) DEFAULT 0 NOT NULL,
    name character varying DEFAULT ''::character varying NOT NULL,
    principal_paid numeric(18,2) DEFAULT 0 NOT NULL,
    principal_outstanding numeric(18,2) DEFAULT 0 NOT NULL,
    interest_paid numeric(18,2) DEFAULT 0 NOT NULL,
    approved_by_sme_user character varying DEFAULT ''::character varying NOT NULL,
    approved_by_bank_user character varying DEFAULT ''::character varying NOT NULL,
    rejected_by_sme_user character varying DEFAULT ''::character varying NOT NULL,
    rejected_by_bank_user character varying DEFAULT ''::character varying NOT NULL,
    loan_close_timestamp bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.sme_employee_loan OWNER TO postgres;

--
-- Name: sme_employee_loan_payment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sme_employee_loan_payment (
    id character varying NOT NULL,
    transaction_id character varying DEFAULT ''::character varying NOT NULL,
    date_of_payment bigint DEFAULT 0 NOT NULL,
    amount_paid numeric(18,2) DEFAULT 0 NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    date_of_approval bigint DEFAULT 0 NOT NULL,
    sme_employee_loan_id character varying NOT NULL,
    emi_month integer NOT NULL,
    principal_component numeric(18,2) DEFAULT 0 NOT NULL,
    interest_component numeric(18,2) DEFAULT 0 NOT NULL,
    approved_by_sme_user character varying DEFAULT ''::character varying NOT NULL,
    approved_by_bank_user character varying DEFAULT ''::character varying NOT NULL,
    flagged_by_sme_user character varying DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.sme_employee_loan_payment OWNER TO postgres;

--
-- Name: sme_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sme_user (
    id character varying NOT NULL,
    auth_user_id character varying NOT NULL,
    sme_id character varying NOT NULL,
    auth_group integer DEFAULT 1 NOT NULL,
    employee_id character varying DEFAULT ''::character varying NOT NULL,
    employee_dept character varying DEFAULT ''::character varying NOT NULL,
    permanent_employee character varying DEFAULT ''::character varying NOT NULL,
    designation character varying DEFAULT ''::character varying NOT NULL,
    notification_token character varying DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.sme_user OWNER TO postgres;

--
-- Name: sme_user_documents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sme_user_documents (
    id character varying NOT NULL,
    sme_user_id character varying NOT NULL,
    document_type character varying NOT NULL,
    document_name character varying,
    is_verified integer DEFAULT 0 NOT NULL,
    flagged_reason character varying DEFAULT ''::character varying NOT NULL,
    flagged_by_sme_user character varying DEFAULT ''::character varying NOT NULL,
    approved_by_sme_user character varying DEFAULT ''::character varying NOT NULL,
    document_number character varying DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.sme_user_documents OWNER TO postgres;

--
-- Name: user_profile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_profile (
    id character varying NOT NULL,
    name character varying NOT NULL,
    gender character varying DEFAULT ''::character varying NOT NULL,
    dob character varying DEFAULT ''::character varying NOT NULL,
    age integer DEFAULT 0 NOT NULL,
    curr_add_line1 character varying DEFAULT ''::character varying NOT NULL,
    curr_add_line2 character varying DEFAULT ''::character varying NOT NULL,
    curr_add_city character varying DEFAULT ''::character varying NOT NULL,
    curr_add_state character varying DEFAULT ''::character varying NOT NULL,
    curr_add_pincode character varying DEFAULT ''::character varying NOT NULL,
    work_add_line1 character varying DEFAULT ''::character varying NOT NULL,
    work_add_line2 character varying DEFAULT ''::character varying NOT NULL,
    work_add_city character varying DEFAULT ''::character varying NOT NULL,
    work_add_state character varying DEFAULT ''::character varying NOT NULL,
    work_add_pincode character varying DEFAULT ''::character varying NOT NULL,
    whatsapp_number character varying DEFAULT ''::character varying NOT NULL,
    family_whatsapp_number character varying DEFAULT ''::character varying NOT NULL,
    aadhar_document_id character varying DEFAULT ''::character varying NOT NULL,
    pan_card_id character varying DEFAULT ''::character varying NOT NULL,
    bank_name character varying DEFAULT ''::character varying NOT NULL,
    name_as_in_bank character varying DEFAULT ''::character varying NOT NULL,
    account_number character varying DEFAULT ''::character varying NOT NULL,
    ifsc_code character varying DEFAULT ''::character varying NOT NULL,
    marital_status character varying DEFAULT ''::character varying NOT NULL,
    no_of_kids character varying DEFAULT ''::character varying NOT NULL,
    kids_occupation character varying DEFAULT ''::character varying NOT NULL,
    extended_family character varying DEFAULT ''::character varying NOT NULL,
    house_ownership character varying DEFAULT ''::character varying NOT NULL,
    vehicle_type character varying DEFAULT ''::character varying NOT NULL,
    education_history character varying DEFAULT ''::character varying NOT NULL,
    years_in_current_city integer DEFAULT 0 NOT NULL,
    mobile_connection character varying DEFAULT ''::character varying NOT NULL,
    native_city character varying DEFAULT ''::character varying NOT NULL,
    native_state character varying DEFAULT ''::character varying NOT NULL,
    working_years_current integer DEFAULT 0 NOT NULL,
    working_years_total integer DEFAULT 0 NOT NULL,
    statutory_deduction character varying DEFAULT ''::character varying NOT NULL,
    field_of_employment character varying DEFAULT ''::character varying NOT NULL,
    kids_school character varying DEFAULT ''::character varying NOT NULL,
    spouse_employed character varying DEFAULT ''::character varying NOT NULL,
    spouse_same_institution character varying DEFAULT ''::character varying NOT NULL,
    no_of_past_job character varying DEFAULT ''::character varying NOT NULL,
    salary numeric(18,2) DEFAULT 0 NOT NULL,
    active_loan character varying DEFAULT ''::character varying NOT NULL,
    active_loan_emi numeric(18,2) DEFAULT 0 NOT NULL,
    bank_statement_id character varying DEFAULT ''::character varying NOT NULL,
    salary_receipt_id character varying DEFAULT ''::character varying NOT NULL,
    photo_document_id character varying DEFAULT ''::character varying NOT NULL,
    debt_to_income_ratio numeric(18,2) DEFAULT 0 NOT NULL,
    expense_to_income_ration numeric(18,2) DEFAULT 0 NOT NULL,
    loan_required numeric(18,2) DEFAULT 0 NOT NULL,
    emi_pay numeric(18,2) DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_profile OWNER TO postgres;

--
-- Data for Name: admin; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin (username, password) FROM stdin;
admin@credth.io	$2a$10$y.EKm6hsLy5skphiKB97lufeu3Ckcq8vzfNg6F6YJ0dsxOyM6vsme
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user (id, username, password, first_name, last_name, email, phone_number, is_active, status) FROM stdin;
1	1	1	\N	\N	\N	\N	t	1
59165035-f2db-4a98-9526-2f7ca6b8b5b6	StanworthAdmin	$2a$10$TXApEFFstrgyEd/d7RXAgem2/jntswJ7JIlsKSD6EtzKxrkwjNfjS	Sandeep	Sangli	sandeep@credth.io	8884008500	t	1
079fbc0d-f5df-400f-b190-95c2d9f3445f	9548088668	$2a$10$2TFvBcBSfN5oD0A4RFLzK.6g3ciEKA/Z9SqkzMRwZ3rPra9fnZkua	Raju	Somala	manikanta.raju@gmail.com	9548088668	t	1
c0cacb4a-ebc7-497a-b4c3-04d0693915a6	9538088668	$2a$10$N3qSYLt1F4qAex1OrmyzNeJrzZIOGNQRlzhZ8FohpOefFCdlAfoi2	manikanta	raju	manikanta.raju@gmail.com	9538088668	t	2
8d8faa13-ceda-4ab1-9bac-dd2f53f5b9b5	999866657	$2a$10$un8EGOwEh0WFpQxjvUDNYe/wkD18BcmohlqdOLraLfjE53YPlbgl.	Jignesh	Vasoya	jignesh@credth.io	999866657	t	1
257f2d5c-3359-4954-8388-16b890d8809f	9998666657	$2a$10$i7c15q0cr/PnamZh7tGenujKBPFaIGlFuB7fqByjT9BeO9kG9TVYm	Jignesh	Vasoya	jignesh@credth.io	9998666657	t	2
604ab4bb-1d86-4368-96b7-2fca3b875e19	9916606657	$2a$10$bQT0jJqXFnV7XDNoeZwQ4euG6vOCs.w1Sjn/Q2On8kZmbJb9FAu.G	Jignesh	Admin	jignesh@credth.io	9916606657	t	2
5a74f122-0ab7-493f-b4f5-01918c2ea606	9538088667	$2a$10$o7l/ulqjEOAI5xhr8cq9aO0OVH6gQhlfCEXPjUofshiHJuiBNz1NC	mani	raju	manikantaraju@gmail.com	9538088667	t	2
9f3a1bfc-ebf5-46c7-89d4-397088a1abda	8892594392	$2a$10$f3LKoB5DPyOOYPQMzM/Jnec.fwCA4y7OCmfBgF4cDQNP4AvjDtuQS	vinay	kumar	vinay@ceegees.in	8892594392	t	1
5d514442-920c-4994-ae6c-236166f04e39	8892594393	$2a$10$9.0ESYfiQCyrU9XrcPD27OReUaONL96Ihu/7GvinukhxIuekcat3q	vinay	kumar	vinay@ceegees.in	8892594393	t	1
52c059d7-3fa6-4110-a46a-475eae719d33	8867613269	$2a$10$EGAfnrmNTdrQgN0ZRveat.wFK4thAS964/gc33wdwVkVdb.nnYN8a	Jignesh	Steel	jignesh@credth.io	8867613269	t	2
6ed04610-067c-4096-8baf-b4594889debb	8526557451	$2a$10$c/tbSgM4Qs7jJq0NcgaIHu7xL/.LgeN2NKBS5Q/ITWsXP4/cmnGGC	Marimuthu	 	noormhdr@gmail.com	8526557451	t	1
79693e18-e1d4-416a-8b02-4400cefe3746	7338123707	$2a$10$qDvVzzJYiEbJ42KfGC2V6O7IpcUfjlwbXZgpvOmMSYLDSXHkIFRRC	Sandeep	Sangli	sandeepsangli@gmail.com	7338123707	t	2
e27ac109-da2f-41c3-bcb9-444d1487983a	8122264735	$2a$10$16fhOZuq/8ygH2s5tzLE5enl3icQNBDHwaarH5cjKLwH2hRIeLeIm	Puvikaran	Selvakulasingam	puvikaran@ceegees.in	8122264735	t	1
45712504-b3e7-4eaa-800f-03a4aacaa03f	9998977432	$2a$10$FTAs04kUVNrZTGYywnlAIObhqlLkAr3VjLg/8Un/MDnPmqebEjii2	Darshan	Shah	darshan@credth.io	9998977432	t	2
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user_groups (id, group_id, user_id) FROM stdin;
\.


--
-- Data for Name: bank; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bank (id, name, registration_number, address, phone_number, scb_address, token_symbol, sub_domain, balance) FROM stdin;
b550feab-b769-4743-b5ca-a91570f7e8f4	Standworth Finance Pvt Limited	U65910TG1994PTC016841	PLOT NO. 304, L-III, ROAD NO. 78, JUBILEE HILLS HYDERABAD Hyderabad TG 500096 IN	8374712244	sc1555408847	stanworth	stanworth	15296.10
\.


--
-- Data for Name: bank_documents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bank_documents (id, bank_id, document_type, document_name) FROM stdin;
\.


--
-- Data for Name: bank_fixed_loan_product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bank_fixed_loan_product (id, name, principle, interest, time_period, bank_id, tnc_document_id, rule_id, emi) FROM stdin;
\.


--
-- Data for Name: bank_sme_partnership; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bank_sme_partnership (id, bank_id, sme_id, status, scrm_address, scrm_channel) FROM stdin;
d69fcbbe-6df4-45d9-8a1f-022b6baffeea	b550feab-b769-4743-b5ca-a91570f7e8f4	2c0cce0f-e899-4889-b9bd-2f4034de4168	2		stanfinandcredth
ad00069f-db9d-438e-b957-e0681dfdb94b	b550feab-b769-4743-b5ca-a91570f7e8f4	1c4cda15-55f2-407a-bb41-08d6819fbf61	2		stanfinandcredth
4cb40194-3448-4abf-b161-72693caa4bb0	b550feab-b769-4743-b5ca-a91570f7e8f4	1646e40c-8c73-44b4-b191-c953795f36fc	2		stanfinandcredth
\.


--
-- Data for Name: bank_transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bank_transactions (id, bank_id, date_of_payment, amount_paid, transaction_type, transaction_id, loan_product_id, approved_by_bank_user, transaction_description) FROM stdin;
da4edc02-b26b-4597-b9bf-f688ea3438f6	b550feab-b769-4743-b5ca-a91570f7e8f4	1555408945	100000.00	1	172ffdb327ff18429ca846a72c1c44736cbcc9df2a2348e60b684431c8e1732f		85cf2543-d40b-4d8f-936e-8ed9ebfcfc50	Added New Funds
ed4abe6d-8ac5-4d43-8ec3-d3702f38285b	b550feab-b769-4743-b5ca-a91570f7e8f4	1555409184	10000.00	2	2f5c62638f351de2b8d434f94066052614c8b261668cfe4888c2eea6bc6d525b		85cf2543-d40b-4d8f-936e-8ed9ebfcfc50	Disbursed new loan
e32e6945-47d9-4d05-9b34-1e9405808237	b550feab-b769-4743-b5ca-a91570f7e8f4	1555409207	2782.80	1	6264ad8bf1d1c310f2b99477a0cee1f7e2b8537e6a3d0cd435ef48213c81a9ae		85cf2543-d40b-4d8f-936e-8ed9ebfcfc50	Loan EMI Repayment
1f873441-5f34-4e18-9234-eeac42c3abe8	b550feab-b769-4743-b5ca-a91570f7e8f4	1555409232	2782.80	1	7cc9eb3b75f9a8e77b00cdcb67db12bae11b781aeecbece83b0b8cd252e4ef15		85cf2543-d40b-4d8f-936e-8ed9ebfcfc50	Loan EMI Repayment
d6fbea2e-44f4-4a06-a5f8-4a365f35d460	b550feab-b769-4743-b5ca-a91570f7e8f4	1555409247	2782.80	1	aa9df5012efd16ee293101e1a3b4df34f496c6d58de9215b8871318a7b2f16b0		85cf2543-d40b-4d8f-936e-8ed9ebfcfc50	Loan EMI Repayment
b37a503f-0cc6-4616-8248-fa9b2f087259	b550feab-b769-4743-b5ca-a91570f7e8f4	1555409289	2782.80	1	88732d9d877e6bba11d79657645801cc5757c1ea027069f8dfc3c8fbb0f2a6de		85cf2543-d40b-4d8f-936e-8ed9ebfcfc50	Loan EMI Repayment
0af7d726-fa99-4405-8f6d-e85c4239f74c	b550feab-b769-4743-b5ca-a91570f7e8f4	1556085613	15296.10	2	39deb7540d962f89a2b6bcde682c924b5ed9d8c43944b44744ce5844445399f0		85cf2543-d40b-4d8f-936e-8ed9ebfcfc50	Disbursed new loan
\.


--
-- Data for Name: bank_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bank_user (id, auth_user_id, bank_id) FROM stdin;
85cf2543-d40b-4d8f-936e-8ed9ebfcfc50	59165035-f2db-4a98-9526-2f7ca6b8b5b6	b550feab-b769-4743-b5ca-a91570f7e8f4
\.


--
-- Data for Name: document_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.document_types (id, name, validity) FROM stdin;
\.


--
-- Data for Name: network_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.network_config (id, org_id, org_name, no_of_peers, end_point, base_contract_version, scl_version, channel_name, msp_id, endorsing_peer) FROM stdin;
ad8dfd07-87ea-44ec-b230-6117bb74efda	credth	credthpeer.io	1	http://api.credthpeer.io:4001	v1	v1	stanfinandcredth	credthpeer.ioMSP	peer1-credthpeer.io:7051
4392fc0b-3de3-4546-a739-77203eb079aa	b550feab-b769-4743-b5ca-a91570f7e8f4	stanfin	1	http://api.stanfin:4001	v1	v1	stanfinandcredth	stanfinMSP	peer1-stanfin:7051
\.


--
-- Data for Name: otp_table; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.otp_table (phone_number, email, username, otp, lastotpgenerationtime) FROM stdin;
\.


--
-- Data for Name: rule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rule (id, rule, bank_id, loan_product_rule, tnc_document_id, status) FROM stdin;
aa355e76-7b22-4924-adeb-d29d75183fcc	{"sme":{"segment":"IT"},"employee":{}}	b550feab-b769-4743-b5ca-a91570f7e8f4	{"creditscore":[{"id":0,"range":[500,100000000000000],"loan_param":{"principal_factor":100,"interest":12,"repayment_period":3}}]}		0
018ffb82-a5a8-4189-8444-f553984e21d5	{"sme":{},"employee":{}}	b550feab-b769-4743-b5ca-a91570f7e8f4	{"creditscore":[{"id":0,"range":[500,100000000000000],"loan_param":{"principal_factor":10000,"interest":12,"repayment_period":3}}]}		0
\.


--
-- Data for Name: rule_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rule_type (id, active) FROM stdin;
\.


--
-- Data for Name: sme; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sme (id, name, registration_number, address, phone_number, year_of_incorporation, city, state, description, emi_day, segment, sub_segment, sector_churn, sector_attrition_reason, spoc_name, spoc_designation, spoc_employee_id, spoc_email_id, spoc_contact_no_mobile, spoc_contact_no_landline, pbt, pat, turn_over, no_of_employees, asset_heaviness, avg_staff_tenure, permanent_staff_percentage, avg_salary_bracket, reputation_rating) FROM stdin;
1646e40c-8c73-44b4-b191-c953795f36fc	Unique Steel Products	29AAFU2193G1Z2	235/E, Bommasandra Industrial Area, Phase 3, Bangalore 560099	9902014700	1988	Bangalore	Karnataka	Kitchen Equipment Manufacturers for commercial kitchens, bars	22	Manufacturing	fabrication	20.00	Financial incentive	Noor Mohammad	Operations Manager	E5	noormhdr@gmail.com	9663200999	8029765228	30.00	20.00	15000000.00	50	light	2	80.00	15000.00	high
1c4cda15-55f2-407a-bb41-08d6819fbf61	Ceegees Software Solutions Private limited	U72200KA2011PTC059696	60, Ground Floor, 4th Main, 1st Cross Domlur 2nd Stage Bangalore, 560071	9916606657	2011	Bangalore	Karnataka	Software Development services	22	IT	IT_Services	14.00	Financial Incentives	Soja	Accounts Manager		jignesh@credth.io	9164085085	8047944359	40.00	30.00	10000000.00	22	light	2	80.00	40000.00	Bottom
2c0cce0f-e899-4889-b9bd-2f4034de4168	ceegees				1900				15	Educational	IT - Training Services	0.00	Career Aspiration							0.00	0.00	0.00	0	Zero	0	0.00	0.00	Bottom half
\.


--
-- Data for Name: sme_custom_rules; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sme_custom_rules (id, rule_id, bank_sme_partnership_id) FROM stdin;
\.


--
-- Data for Name: sme_documents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sme_documents (id, sme_id, document_type, document, is_verified) FROM stdin;
\.


--
-- Data for Name: sme_employee_banks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sme_employee_banks (id, name, branch, ifsc_code) FROM stdin;
\.


--
-- Data for Name: sme_employee_loan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sme_employee_loan (id, sme_user_id, sme_id, sme_approval_status, lender_approval_status, loan_status, principle, interest, time_period, bank_id, reason, creation_timestamp, loan_start_timestamp, scl_address, monthly_emi, flagged_reason, loan_product_id, rule_id, remaining_time_period, amount_paid, name, principal_paid, principal_outstanding, interest_paid, approved_by_sme_user, approved_by_bank_user, rejected_by_sme_user, rejected_by_bank_user, loan_close_timestamp) FROM stdin;
42a1a0bf-86a0-4a58-9b49-4bdc3ca840a5	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	3	1	1	15296.10	19.00	6	b550feab-b769-4743-b5ca-a91570f7e8f4	test2	1555409349	0		2791.67				6	0.00	Jignesh Vasoya	0.00	15296.10	0.00			1e3e5797-f00f-499d-98ba-5c03c9804ae8		0
5a07c485-f232-463d-9b12-3ea422bea820	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	2	1	1	21007.50	19.00	12	b550feab-b769-4743-b5ca-a91570f7e8f4	test3	1555409361	0		2083.34				12	0.00	Jignesh Vasoya	0.00	21007.50	0.00	1e3e5797-f00f-499d-98ba-5c03c9804ae8				0
efe87ac6-c604-422b-b64c-4667cc91636e	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	2	1	1	10501.70	19.00	3	b550feab-b769-4743-b5ca-a91570f7e8f4	test1	1555409320	0		3666.67				3	0.00	Jignesh Vasoya	0.00	10501.70	0.00	1e3e5797-f00f-499d-98ba-5c03c9804ae8				0
0445c99b-182e-49e9-9e5d-f5ccc4fcf89a	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	2	1	1	10000.00	39.71	4	b550feab-b769-4743-b5ca-a91570f7e8f4	testing status update	1555427917	0		2782.80				4	0.00	Jignesh Vasoya	0.00	10000.00	0.00	1e3e5797-f00f-499d-98ba-5c03c9804ae8				0
c6f04458-ade0-40b6-b2a2-7ca018370b6d	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	2	1	1	10000.00	39.71	4	b550feab-b769-4743-b5ca-a91570f7e8f4	This is for testing after api integration	1555487195	0		2782.80				4	0.00	Jignesh Vasoya	0.00	10000.00	0.00	1e3e5797-f00f-499d-98ba-5c03c9804ae8				0
9c3cfc88-dd52-42a2-bbbb-37f4aa9af055	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	2	1	1	10501.70	19.00	3	b550feab-b769-4743-b5ca-a91570f7e8f4	test loan status update check	1555490437	0		3666.67				3	0.00	Jignesh Vasoya	0.00	10501.70	0.00	1e3e5797-f00f-499d-98ba-5c03c9804ae8				0
b5b90150-311c-4045-8bb7-9892e40c06be	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	2	4	3	10000.00	39.71	4	b550feab-b769-4743-b5ca-a91570f7e8f4	test	1555409133	1555409181	sc1555408847	2782.80				0	11131.21	Jignesh Vasoya	2500.00	0.00	1131.24	1e3e5797-f00f-499d-98ba-5c03c9804ae8	85cf2543-d40b-4d8f-936e-8ed9ebfcfc50			1555409294
aebe5327-488c-416c-866f-5008b96b9e9e	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	2	1	1	10000.00	39.71	4	b550feab-b769-4743-b5ca-a91570f7e8f4	test2 route after status update 	1555494143	0		2782.80				4	0.00	Jignesh Vasoya	0.00	10000.00	0.00	1e3e5797-f00f-499d-98ba-5c03c9804ae8				0
e346c824-9adf-4edd-bd37-4f489b20b716	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	2	1	1	15296.10	19.00	6	b550feab-b769-4743-b5ca-a91570f7e8f4	test route after status update	1555494099	0		2791.67				6	0.00	Jignesh Vasoya	0.00	15296.10	0.00	1e3e5797-f00f-499d-98ba-5c03c9804ae8				0
e2227d3d-3c5e-413a-8d1a-72009f60c2d6	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	2	1	1	10000.00	39.71	4	b550feab-b769-4743-b5ca-a91570f7e8f4	test route	1555495471	0		2782.80				4	0.00	Jignesh Vasoya	0.00	10000.00	0.00	1e3e5797-f00f-499d-98ba-5c03c9804ae8				0
5ba70b9e-f516-43b4-bfed-df2878a4a6cb	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	2	1	1	15296.10	19.00	6	b550feab-b769-4743-b5ca-a91570f7e8f4	route status test	1555496736	0		2791.67				6	0.00	Jignesh Vasoya	0.00	15296.10	0.00	1e3e5797-f00f-499d-98ba-5c03c9804ae8				0
0f768cdb-beeb-49cc-b48c-1083ded82ad7	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	3	1	1	21007.50	19.00	12	b550feab-b769-4743-b5ca-a91570f7e8f4	test5	1555498907	0		2083.34				12	0.00	Jignesh Vasoya	0.00	21007.50	0.00			1e3e5797-f00f-499d-98ba-5c03c9804ae8		0
0eae8ebe-f159-4750-8e09-d295c2bcfc0f	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	3	1	1	15296.10	19.00	6	b550feab-b769-4743-b5ca-a91570f7e8f4	test	1555498880	0		2791.67				6	0.00	Jignesh Vasoya	0.00	15296.10	0.00			1e3e5797-f00f-499d-98ba-5c03c9804ae8		0
e5eb1772-1ae3-495b-8ae7-7bec600cd019	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	2	1	1	21007.50	19.00	12	b550feab-b769-4743-b5ca-a91570f7e8f4	test6	1555499685	0		2083.34				12	0.00	Jignesh Vasoya	0.00	21007.50	0.00	1e3e5797-f00f-499d-98ba-5c03c9804ae8				0
c0288f50-3de3-401f-93a1-aaf5061043dc	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	3	1	1	15296.10	19.00	6	b550feab-b769-4743-b5ca-a91570f7e8f4	test token expire route	1555523898	0		2791.67				6	0.00	Jignesh Vasoya	0.00	15296.10	0.00			1e3e5797-f00f-499d-98ba-5c03c9804ae8		0
f49aeb0f-0de6-43f8-b46b-73210136fb38	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	2	1	1	21007.50	19.00	12	b550feab-b769-4743-b5ca-a91570f7e8f4	test token expire route	1555524032	0		2083.34				12	0.00	Jignesh Vasoya	0.00	21007.50	0.00	1e3e5797-f00f-499d-98ba-5c03c9804ae8				0
223904f8-4fa2-4747-a3c0-10393646d369	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	2	4	2	15296.10	19.00	6	b550feab-b769-4743-b5ca-a91570f7e8f4	test background notify	1555539991	1556085609	sc1555408847	2791.67				6	0.00	Jignesh Vasoya	0.00	15296.10	0.00	1e3e5797-f00f-499d-98ba-5c03c9804ae8	85cf2543-d40b-4d8f-936e-8ed9ebfcfc50			0
4f3f7c98-d067-495a-bb4e-b7fbab2ef15a	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	2	1	1	10000.00	39.71	4	b550feab-b769-4743-b5ca-a91570f7e8f4	apk test	1555539364	0		2782.80				4	0.00	Jignesh Vasoya	0.00	10000.00	0.00	1e3e5797-f00f-499d-98ba-5c03c9804ae8				0
d3299359-712e-4943-9ae5-81f7dce08af0	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	2	1	1	10501.70	19.00	3	b550feab-b769-4743-b5ca-a91570f7e8f4	jignesh apk test 1	1556083315	0		3666.67				3	0.00	Jignesh Vasoya	0.00	10501.70	0.00	1e3e5797-f00f-499d-98ba-5c03c9804ae8				0
3690d1da-261a-4b88-9548-0c0f6209cc4c	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	3	1	1	10501.70	19.00	3	b550feab-b769-4743-b5ca-a91570f7e8f4	jignesh notif test1	1556813814	0		3666.67				3	0.00	Jignesh Vasoya	0.00	10501.70	0.00			1e3e5797-f00f-499d-98ba-5c03c9804ae8		0
e86bf684-e28f-41d7-8286-3405e1449372	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	3	1	1	15296.10	19.00	6	b550feab-b769-4743-b5ca-a91570f7e8f4	for testing the issues in sheet	1556520234	0		2791.67				6	0.00	Jignesh Vasoya	0.00	15296.10	0.00			1e3e5797-f00f-499d-98ba-5c03c9804ae8		0
16d1db10-779b-4fb7-ac33-f64fb8f77215	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	3	1	1	15296.10	19.00	6	b550feab-b769-4743-b5ca-a91570f7e8f4	Puvi notify-test-8	1556898290	0		2791.67				6	0.00	Jignesh Vasoya	0.00	15296.10	0.00			1e3e5797-f00f-499d-98ba-5c03c9804ae8		0
59c84310-a51c-4bd5-ac74-5c80e9facea9	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	3	1	1	21007.50	19.00	12	b550feab-b769-4743-b5ca-a91570f7e8f4	Darshan Testing. 	1557139090	0		2083.34				12	0.00	Jignesh Vasoya	0.00	21007.50	0.00			0b35a935-6cae-4c57-89be-cae59c6df429		0
c49e3c84-fdea-42f6-861d-707792c4063d	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	2	1	1	15296.10	19.00	6	b550feab-b769-4743-b5ca-a91570f7e8f4	puvi notify test-5	1556894966	0		2791.67				6	0.00	Jignesh Vasoya	0.00	15296.10	0.00	0b35a935-6cae-4c57-89be-cae59c6df429				0
cc64c030-4470-44e5-9e29-da8d894065af	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	3	1	1	10501.70	19.00	3	b550feab-b769-4743-b5ca-a91570f7e8f4	notif test2	1556814156	0		3666.67				3	0.00	Jignesh Vasoya	0.00	10501.70	0.00			1e3e5797-f00f-499d-98ba-5c03c9804ae8		0
afdf2930-0bfd-4f8a-bb54-f98b22239bfc	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	3	1	1	10000.00	39.71	4	b550feab-b769-4743-b5ca-a91570f7e8f4	test5	1556886250	0		2782.80				4	0.00	Jignesh Vasoya	0.00	10000.00	0.00			1e3e5797-f00f-499d-98ba-5c03c9804ae8		0
c33dbdb8-7c93-4c3a-beee-210af1dcef9a	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	3	1	1	10000.00	39.71	4	b550feab-b769-4743-b5ca-a91570f7e8f4	Puvi Notify test-1	1556889527	0		2782.80				4	0.00	Jignesh Vasoya	0.00	10000.00	0.00			1e3e5797-f00f-499d-98ba-5c03c9804ae8		0
69c37c4a-b81e-4f0a-a247-949453559d92	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	2	1	1	10000.00	39.71	4	b550feab-b769-4743-b5ca-a91570f7e8f4	Puvi - notify test-2	1556889734	0		2782.80				4	0.00	Jignesh Vasoya	0.00	10000.00	0.00	1e3e5797-f00f-499d-98ba-5c03c9804ae8				0
571a95d1-5eda-4c3c-80ff-699e8006e153	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	3	1	1	15296.10	19.00	6	b550feab-b769-4743-b5ca-a91570f7e8f4	Puvi Notify test-3	1556890687	0		2791.67				6	0.00	Jignesh Vasoya	0.00	15296.10	0.00			1e3e5797-f00f-499d-98ba-5c03c9804ae8		0
d3ce58bd-3b48-460a-ac18-214bffa316b4	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	2	1	1	15296.10	19.00	6	b550feab-b769-4743-b5ca-a91570f7e8f4	test notif1	1557472045	0		2791.67				6	0.00	Jignesh Vasoya	0.00	15296.10	0.00	1e3e5797-f00f-499d-98ba-5c03c9804ae8				0
7cc843ea-11d3-4697-b8b0-07370570506b	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	3	1	1	10501.70	19.00	3	b550feab-b769-4743-b5ca-a91570f7e8f4	test loan name	1557408274	0		3666.67				3	0.00	Jignesh Vasoya	0.00	10501.70	0.00			1e3e5797-f00f-499d-98ba-5c03c9804ae8		0
3a70e372-5251-4a8c-8541-9e2ef9fafb62	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	2	1	1	21007.50	19.00	12	b550feab-b769-4743-b5ca-a91570f7e8f4	puvi notify-test-15	1556899410	0		2083.34				12	0.00	Jignesh Vasoya	0.00	21007.50	0.00	1e3e5797-f00f-499d-98ba-5c03c9804ae8				0
5931ab0b-9868-4927-a45d-d7ec5128c529	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	3	1	1	21007.50	19.00	12	b550feab-b769-4743-b5ca-a91570f7e8f4	Puvi notify test-16	1557121054	0		2083.34				12	0.00	Jignesh Vasoya	0.00	21007.50	0.00			1e3e5797-f00f-499d-98ba-5c03c9804ae8		0
edcde7b5-7085-461b-bd72-4edec48a2fb7	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	3	1	1	10000.00	39.71	4	b550feab-b769-4743-b5ca-a91570f7e8f4	puvi notify test-12	1556898923	0		2782.80				4	0.00	Jignesh Vasoya	0.00	10000.00	0.00			1e3e5797-f00f-499d-98ba-5c03c9804ae8		0
4231fff6-71f2-475c-9bc9-98c7d3c7e164	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	3	1	1	10501.70	19.00	3	b550feab-b769-4743-b5ca-a91570f7e8f4	puvi notify test-13	1556899285	0		3666.67				3	0.00	Jignesh Vasoya	0.00	10501.70	0.00			1e3e5797-f00f-499d-98ba-5c03c9804ae8		0
bf745903-644f-4ead-9824-a146afe35705	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	2	1	1	10501.70	19.00	3	b550feab-b769-4743-b5ca-a91570f7e8f4	test121	1557408702	0		3666.67				3	0.00	Jignesh Vasoya	0.00	10501.70	0.00	1e3e5797-f00f-499d-98ba-5c03c9804ae8				0
608f6ae4-dabd-4d30-ab49-e0257e7d23f4	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	2	1	1	10501.70	19.00	3	b550feab-b769-4743-b5ca-a91570f7e8f4	name test1	1557420031	0		3666.67				3	0.00	Jignesh Vasoya	0.00	10501.70	0.00	1e3e5797-f00f-499d-98ba-5c03c9804ae8				0
9481a065-e825-4d57-9e66-2f2ecafe0ac1	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	2	1	1	21007.50	19.00	12	b550feab-b769-4743-b5ca-a91570f7e8f4	Puvi notify-test-10	1556898774	0		2083.34				12	0.00	Jignesh Vasoya	0.00	21007.50	0.00	1e3e5797-f00f-499d-98ba-5c03c9804ae8				0
35e3685c-51c7-4332-9550-fbad4e4e8842	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	2	1	1	10501.70	19.00	3	b550feab-b769-4743-b5ca-a91570f7e8f4	puvi notify test-11	1556898854	0		3666.67				3	0.00	Jignesh Vasoya	0.00	10501.70	0.00	1e3e5797-f00f-499d-98ba-5c03c9804ae8				0
a5590fc0-27ce-40a5-984a-cd608cbd2c85	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	3	1	1	21007.50	19.00	12	b550feab-b769-4743-b5ca-a91570f7e8f4	twst 2	1556874194	0		2083.34				12	0.00	Jignesh Vasoya	0.00	21007.50	0.00			1e3e5797-f00f-499d-98ba-5c03c9804ae8		0
1a9b62ff-88de-4164-adef-8d6c764a4da8	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	3	1	1	10000.00	39.71	4	b550feab-b769-4743-b5ca-a91570f7e8f4	Puvi notify test-4	1556893006	0		2782.80				4	0.00	Jignesh Vasoya	0.00	10000.00	0.00			1e3e5797-f00f-499d-98ba-5c03c9804ae8		0
a879d363-22f0-474a-9005-f143b567de9d	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	3	1	1	10501.70	19.00	3	b550feab-b769-4743-b5ca-a91570f7e8f4	Puvi notify-test-7	1556898077	0		3666.67				3	0.00	Jignesh Vasoya	0.00	10501.70	0.00			1e3e5797-f00f-499d-98ba-5c03c9804ae8		0
7910b300-2ed1-4811-b1d4-b071a12504bf	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	2	1	1	10000.00	39.71	4	b550feab-b769-4743-b5ca-a91570f7e8f4	Puvi notify-test-9	1556898386	0		2782.80				4	0.00	Jignesh Vasoya	0.00	10000.00	0.00	1e3e5797-f00f-499d-98ba-5c03c9804ae8				0
0f809ffa-a722-44c7-a144-012d254b3720	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	2	1	1	10000.00	39.71	4	b550feab-b769-4743-b5ca-a91570f7e8f4	test 6	1556886711	0		2782.80				4	0.00	Jignesh Vasoya	0.00	10000.00	0.00	1e3e5797-f00f-499d-98ba-5c03c9804ae8				0
64faf214-e9de-4a82-b657-4b144ab560ee	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	2	1	1	10000.00	39.71	4	b550feab-b769-4743-b5ca-a91570f7e8f4	4	1556874374	0		2782.80				4	0.00	Jignesh Vasoya	0.00	10000.00	0.00	1e3e5797-f00f-499d-98ba-5c03c9804ae8				0
fe900b91-6532-4a72-a71e-6f131d34ed52	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	3	1	1	15296.10	19.00	6	b550feab-b769-4743-b5ca-a91570f7e8f4	puvi notify test-14	1556899339	0		2791.67				6	0.00	Jignesh Vasoya	0.00	15296.10	0.00			1e3e5797-f00f-499d-98ba-5c03c9804ae8		0
73ea0093-cbf8-4385-b8f0-a99e564564f3	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	3	1	1	10000.00	39.71	4	b550feab-b769-4743-b5ca-a91570f7e8f4	Puvi Notify-test-6	1556897818	0		2782.80				4	0.00	Jignesh Vasoya	0.00	10000.00	0.00			1e3e5797-f00f-499d-98ba-5c03c9804ae8		0
e85fb835-79aa-4982-b7e4-782ff0daad62	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	2	1	1	10501.70	19.00	3	b550feab-b769-4743-b5ca-a91570f7e8f4	notif test 3	1556873871	0		3666.67				3	0.00	Jignesh Vasoya	0.00	10501.70	0.00	1e3e5797-f00f-499d-98ba-5c03c9804ae8				0
6729a418-0e15-4bff-b8e2-44c24a02b2b9	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	3	1	1	10501.70	19.00	3	b550feab-b769-4743-b5ca-a91570f7e8f4	notif test jignesh1	1557472494	0		3666.67				3	0.00	Jignesh Vasoya	0.00	10501.70	0.00			1e3e5797-f00f-499d-98ba-5c03c9804ae8		0
d3eada6b-c41b-4757-8b77-dd80dcf4bed6	fd7e1f97-adb0-477f-ad57-726797b9901b	1c4cda15-55f2-407a-bb41-08d6819fbf61	3	1	1	21007.50	19.00	12	b550feab-b769-4743-b5ca-a91570f7e8f4	notif test2	1557472555	0		2083.34				12	0.00	Jignesh Vasoya	0.00	21007.50	0.00			1e3e5797-f00f-499d-98ba-5c03c9804ae8		0
\.


--
-- Data for Name: sme_employee_loan_payment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sme_employee_loan_payment (id, transaction_id, date_of_payment, amount_paid, status, date_of_approval, sme_employee_loan_id, emi_month, principal_component, interest_component, approved_by_sme_user, approved_by_bank_user, flagged_by_sme_user) FROM stdin;
76ee510e-cbd2-4d88-b9eb-d39a386486bc	6264ad8bf1d1c310f2b99477a0cee1f7e2b8537e6a3d0cd435ef48213c81a9ae	1555409207	2782.80	2	1555409200	b5b90150-311c-4045-8bb7-9892e40c06be	20190422	2500.00	282.81	1e3e5797-f00f-499d-98ba-5c03c9804ae8	85cf2543-d40b-4d8f-936e-8ed9ebfcfc50	
b959d034-1df4-4f4a-8a50-2ff57f43bd94	7cc9eb3b75f9a8e77b00cdcb67db12bae11b781aeecbece83b0b8cd252e4ef15	1555409232	2782.80	2	1555409225	b5b90150-311c-4045-8bb7-9892e40c06be	20190522	2500.00	282.81	1e3e5797-f00f-499d-98ba-5c03c9804ae8	85cf2543-d40b-4d8f-936e-8ed9ebfcfc50	
5f95318f-fc6c-4604-ae65-c19b758fc7cb	aa9df5012efd16ee293101e1a3b4df34f496c6d58de9215b8871318a7b2f16b0	1555409247	2782.80	2	1555409241	b5b90150-311c-4045-8bb7-9892e40c06be	20190622	2500.00	282.81	1e3e5797-f00f-499d-98ba-5c03c9804ae8	85cf2543-d40b-4d8f-936e-8ed9ebfcfc50	
f40a677b-e415-4ea1-aa65-1701911393ec	88732d9d877e6bba11d79657645801cc5757c1ea027069f8dfc3c8fbb0f2a6de	1555409289	2782.80	2	1555409256	b5b90150-311c-4045-8bb7-9892e40c06be	20190722	2500.00	282.81	1e3e5797-f00f-499d-98ba-5c03c9804ae8	85cf2543-d40b-4d8f-936e-8ed9ebfcfc50	
a42900f5-e9a8-4221-9ae8-c0c47e8a3108		0	2791.67	0	0	223904f8-4fa2-4747-a3c0-10393646d369	20190522	0.00	0.00			
\.


--
-- Data for Name: sme_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sme_user (id, auth_user_id, sme_id, auth_group, employee_id, employee_dept, permanent_employee, designation, notification_token) FROM stdin;
8b9bb2ab-fc34-4564-9a8c-ed2eebee6b47	079fbc0d-f5df-400f-b190-95c2d9f3445f	1c4cda15-55f2-407a-bb41-08d6819fbf61	1	1234				
21205c33-8223-4862-b4bc-9f7d5267e8c3	8d8faa13-ceda-4ab1-9bac-dd2f53f5b9b5	1c4cda15-55f2-407a-bb41-08d6819fbf61	1	ABC11				
8d24f1eb-f58c-4b4d-89da-60c1ccc11ff4	e27ac109-da2f-41c3-bcb9-444d1487983a	2c0cce0f-e899-4889-b9bd-2f4034de4168	1	E115				
0fdfc786-e814-4955-a82d-c13cc6efdca6	9f3a1bfc-ebf5-46c7-89d4-397088a1abda	1c4cda15-55f2-407a-bb41-08d6819fbf61	1	1234				
c796f6ad-7b13-494f-b8c5-2f919557fe9f	5d514442-920c-4994-ae6c-236166f04e39	1c4cda15-55f2-407a-bb41-08d6819fbf61	1	123456				
ffa820d5-ab63-4a38-bb4e-9920157324d2	5a74f122-0ab7-493f-b4f5-01918c2ea606	1c4cda15-55f2-407a-bb41-08d6819fbf61	1	1234				
f9cd25f7-8f66-42c6-ae9f-343087aae3ce	c0cacb4a-ebc7-497a-b4c3-04d0693915a6	1c4cda15-55f2-407a-bb41-08d6819fbf61	1	A1	Technical Role	no	software	
d39850b5-520b-4134-bba5-119a242e0d7b	52c059d7-3fa6-4110-a46a-475eae719d33	1646e40c-8c73-44b4-b191-c953795f36fc	1	E6	Technical Role	yes		
3a70ff59-4370-455b-9c5d-014e563a6a93	6ed04610-067c-4096-8baf-b4594889debb	1646e40c-8c73-44b4-b191-c953795f36fc	1	E7				
34a77e7b-7d9f-47a4-9ea6-58428b0420f4	79693e18-e1d4-416a-8b02-4400cefe3746	1646e40c-8c73-44b4-b191-c953795f36fc	1	E7				
1e3e5797-f00f-499d-98ba-5c03c9804ae8	604ab4bb-1d86-4368-96b7-2fca3b875e19	1c4cda15-55f2-407a-bb41-08d6819fbf61	2	ABC321				dFgKo7j7Evc:APA91bF5bnOVsr714W9gxvnZERr9FGLwcKJjyrqiJ1EflfsrPhhkzhFT12z7C--us1RwldU6tsm97dOLSu2HK91mC7_bx0w0eAxeB2IhyvEz6yr3kGK8DE20WHKfnsiwYSZZXpS6LVvH
0b35a935-6cae-4c57-89be-cae59c6df429	45712504-b3e7-4eaa-800f-03a4aacaa03f	1c4cda15-55f2-407a-bb41-08d6819fbf61	2	123456				em8XCeKefPY:APA91bEbjFOK3fvOeVtDldE93ZIVx0OeoxmpVxqZe8Fxs8pSHhFCAPkblGGGqLzUBAGIMd-8nIVbiV0aLFBNiw0fKt_NyVbS_mk-3vSqXwqTYVyWDW6mEurAE7-ioINy0BtUwstjsDaz
fd7e1f97-adb0-477f-ad57-726797b9901b	257f2d5c-3359-4954-8388-16b890d8809f	1c4cda15-55f2-407a-bb41-08d6819fbf61	1	ABC123	Technical Role	yes	Software Developer	cNqsPf4V2qc:APA91bHMjutSYX_QA0gLw8s1T38ZVUBVNq-T9MP56culhYoz0pykCKlrHgDekzp0G6TjGnSKpThvI41aP1OUSz3RU7145yg-4WLJ2StsGIoIkhuLZw5GGM4YE1Jq5gt69S8iVLsE1eBK
\.


--
-- Data for Name: sme_user_documents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sme_user_documents (id, sme_user_id, document_type, document_name, is_verified, flagged_reason, flagged_by_sme_user, approved_by_sme_user, document_number) FROM stdin;
7b1b1f5f-d2b7-4c20-884d-e2ab0963ac82	fd7e1f97-adb0-477f-ad57-726797b9901b	photo_document_id	vidyoclient_on_electron.JPG	1				
9044fc61-83d6-48b3-8208-96709c5690a0	fd7e1f97-adb0-477f-ad57-726797b9901b	aadhar_document_id	vidyoclient_on_electron.JPG	2		1e3e5797-f00f-499d-98ba-5c03c9804ae8	1e3e5797-f00f-499d-98ba-5c03c9804ae8	123456789012
4642a042-4fde-4abc-8713-0b29ce02d6fe	f9cd25f7-8f66-42c6-ae9f-343087aae3ce	bank_statement_id	LPXXXXXXXXXXXX93.pdf	1				
f01815b1-27be-4a9c-92fa-240415b713e2	f9cd25f7-8f66-42c6-ae9f-343087aae3ce	bank_statement_id	HL_Whitepaper_IntroductiontoHyperledger.pdf	1				
ed4badae-05aa-480a-a55d-211ccbed7bb0	f9cd25f7-8f66-42c6-ae9f-343087aae3ce	salary_receipt_id	THAEJNB.pdf	1				
9adb16a7-be81-4059-98e9-bea7e1c890d9	f9cd25f7-8f66-42c6-ae9f-343087aae3ce	aadhar_document_id	Dates to remember & details of sale days.pdf	1				
e836bbd9-1ad5-4eef-8dc7-15cd9e77e2f6	f9cd25f7-8f66-42c6-ae9f-343087aae3ce	bank_statement_id	THAEJNB.pdf	1				
fd86bb9b-6912-4eb8-b42c-ea331bfd7d4a	f9cd25f7-8f66-42c6-ae9f-343087aae3ce	bank_statement_id	Credth_fabric_infra.docx	1				
f576270a-6c2e-441e-9d72-1d0f320c2697	f9cd25f7-8f66-42c6-ae9f-343087aae3ce	bank_statement_id	LPXXXXXXXXXXXX93-WC515795.pdf	1				
f092ca6f-8575-454e-af30-2d83640820da	f9cd25f7-8f66-42c6-ae9f-343087aae3ce	salary_receipt_id	LPXXXXXXXXXXXX93.pdf	1				
5ea45a3a-38e5-409c-ac25-ffb46063611b	f9cd25f7-8f66-42c6-ae9f-343087aae3ce	aadhar_document_id	LPXXXXXXXXXXXX93.pdf	1				
0cd71464-8d7f-4823-a58c-a7a974b83b12	f9cd25f7-8f66-42c6-ae9f-343087aae3ce	pan_card_id	LPXXXXXXXXXXXX93.pdf	1				
20d4b48a-845b-4d64-8731-43436970ebae	f9cd25f7-8f66-42c6-ae9f-343087aae3ce	salary_receipt_id	LPXXXXXXXXXXXX93.pdf	1				
b0220cce-6de4-4a67-bd56-682dd53c449c	fd7e1f97-adb0-477f-ad57-726797b9901b	salary_receipt_id	vidyoclient_on_electron.JPG	3		1e3e5797-f00f-499d-98ba-5c03c9804ae8	1e3e5797-f00f-499d-98ba-5c03c9804ae8	
ac8c3a96-745a-4b7d-92bf-eab48fe8b063	fd7e1f97-adb0-477f-ad57-726797b9901b	pan_card_id	vidyoclient_on_electron.JPG	2		1e3e5797-f00f-499d-98ba-5c03c9804ae8	1e3e5797-f00f-499d-98ba-5c03c9804ae8	ALLVP5566J
0b1ce55c-7eb6-4f67-b7ad-12b102f21d4a	f9cd25f7-8f66-42c6-ae9f-343087aae3ce	aadhar_document_id	LPXXXXXXXXXXXX93-WC515795 (1).pdf	2			1e3e5797-f00f-499d-98ba-5c03c9804ae8	1234123412341234
965ee800-aca3-4492-9761-5dd821e350a0	fd7e1f97-adb0-477f-ad57-726797b9901b	bank_statement_id	vidyoclient_on_electron.JPG	3		1e3e5797-f00f-499d-98ba-5c03c9804ae8	1e3e5797-f00f-499d-98ba-5c03c9804ae8	
e2af4895-b1bb-475c-9ea3-bc49f8988d9d	f9cd25f7-8f66-42c6-ae9f-343087aae3ce	bank_statement_id	LPXXXXXXXXXXXX93-WC515795.pdf	2			1e3e5797-f00f-499d-98ba-5c03c9804ae8	
\.


--
-- Data for Name: user_profile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_profile (id, name, gender, dob, age, curr_add_line1, curr_add_line2, curr_add_city, curr_add_state, curr_add_pincode, work_add_line1, work_add_line2, work_add_city, work_add_state, work_add_pincode, whatsapp_number, family_whatsapp_number, aadhar_document_id, pan_card_id, bank_name, name_as_in_bank, account_number, ifsc_code, marital_status, no_of_kids, kids_occupation, extended_family, house_ownership, vehicle_type, education_history, years_in_current_city, mobile_connection, native_city, native_state, working_years_current, working_years_total, statutory_deduction, field_of_employment, kids_school, spouse_employed, spouse_same_institution, no_of_past_job, salary, active_loan, active_loan_emi, bank_statement_id, salary_receipt_id, photo_document_id, debt_to_income_ratio, expense_to_income_ration, loan_required, emi_pay) FROM stdin;
9f3a1bfc-ebf5-46c7-89d4-397088a1abda	vinay kumar			0																										0				0	0							0.00		0.00				0.00	0.00	0.00	0.00
5d514442-920c-4994-ae6c-236166f04e39	vinay kumar			0																										0				0	0							0.00		0.00				0.00	0.00	0.00	0.00
079fbc0d-f5df-400f-b190-95c2d9f3445f	Raju Somala			0																										0				0	0							0.00		0.00				0.00	0.00	0.00	0.00
8d8faa13-ceda-4ab1-9bac-dd2f53f5b9b5	Jignesh Vasoya			0																										0				0	0							0.00		0.00				0.00	0.00	0.00	0.00
257f2d5c-3359-4954-8388-16b890d8809f	Jignesh Vasoya	Male	03/02/1992	27	402-Crish Comfort, 16th Main Cross,	behind SCT college, Vignan Nagar	Bangalore	Karnataka	560037	402-Crish Comfort, 16th Main Cross,	behind SCT college, Vignan Nagar	Bangalore	Karnataka	364001		9998666657	9044fc61-83d6-48b3-8208-96709c5690a0	ac8c3a96-745a-4b7d-92bf-eab48fe8b063	HDFC Bank	Vinay	1234567	HDFC0000076	Single	0		no	Rent	Two Wheeler	Graduation	5	Postpaid	Bhavnagar	Gujarat	3	5	yes	Developer	no	no	no	2	25000.00	None	0.00	965ee800-aca3-4492-9761-5dd821e350a0	b0220cce-6de4-4a67-bd56-682dd53c449c	7b1b1f5f-d2b7-4c20-884d-e2ab0963ac82	1.00	0.00	10000.00	3000.00
604ab4bb-1d86-4368-96b7-2fca3b875e19	Jignesh Admin			0																										0				0	0							7000.00		0.00				0.00	0.00	5000.00	0.00
e27ac109-da2f-41c3-bcb9-444d1487983a	Puvikaran Selvakulasingam			0																										0				0	0							0.00		0.00				0.00	0.00	0.00	0.00
45712504-b3e7-4eaa-800f-03a4aacaa03f	Darshan Shah			0																										0				0	0							0.00		0.00				0.00	0.00	0.00	0.00
5a74f122-0ab7-493f-b4f5-01918c2ea606	mani raju			0																										0				0	0							22000.00		0.00				0.00	0.00	9000.00	0.00
c0cacb4a-ebc7-497a-b4c3-04d0693915a6	manikanta raju	Male	01/01/1995	24			Banglore	Karnataka	560035	Banglore	Banglore	Banglore	Karnataka	560034		9538088668	0b1ce55c-7eb6-4f67-b7ad-12b102f21d4a		City Union Bank	raju	12341234	ICIC0002342	Single	5	Working	yes	Paying Guest	Two Wheeler	Graduation	0	Postpaid	banglore	Karnataka	0	0	no	Office	yes	no	no	17	50000.00	Active	10000.00	e2af4895-b1bb-475c-9ea3-bc49f8988d9d	20d4b48a-845b-4d64-8731-43436970ebae		0.00	0.00	5000.00	7000.00
52c059d7-3fa6-4110-a46a-475eae719d33	Jignesh Steel	Male	03/02/1992	27	402-Crish Comfort, 16th Main Cross,	behind SCT college, Vignan Nagar	Bangalore	Karnataka	560075	402-Crish Comfort, 16th Main Cross,	behind SCT college, Vignan Nagar	Bangalore	Karnataka	560075		8867613269				Jignesh Vasoya			Single			no	Rent	Two Wheeler	Post Graduation	2	Postpaid	Bangalore	Karnataka	0	0	yes					1	10000.00	None	0.00				0.00	0.00	5000.00	400.00
6ed04610-067c-4096-8baf-b4594889debb	Marimuthu  			0																										0				0	0							0.00		0.00				0.00	0.00	0.00	0.00
79693e18-e1d4-416a-8b02-4400cefe3746	Sandeep Sangli			0															Indian Bank			IDIB000T072								0				0	0							0.00		0.00				0.00	0.00	0.00	0.00
\.


--
-- Name: bank_transactions bank_transactions_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bank_transactions
    ADD CONSTRAINT bank_transactions_pk PRIMARY KEY (id);


--
-- Name: admin pk_admin; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT pk_admin PRIMARY KEY (username);


--
-- Name: auth_group pk_auth_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT pk_auth_group PRIMARY KEY (id);


--
-- Name: auth_user pk_auth_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT pk_auth_user PRIMARY KEY (id);


--
-- Name: auth_user_groups pk_auth_user_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT pk_auth_user_groups PRIMARY KEY (id);


--
-- Name: bank pk_bank; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bank
    ADD CONSTRAINT pk_bank PRIMARY KEY (id);


--
-- Name: bank_documents pk_bank_documents; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bank_documents
    ADD CONSTRAINT pk_bank_documents PRIMARY KEY (id);


--
-- Name: bank_fixed_loan_product pk_bank_fixed_loan_product; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bank_fixed_loan_product
    ADD CONSTRAINT pk_bank_fixed_loan_product PRIMARY KEY (id);


--
-- Name: bank_sme_partnership pk_bank_sme_partnership; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bank_sme_partnership
    ADD CONSTRAINT pk_bank_sme_partnership PRIMARY KEY (id);


--
-- Name: bank_user pk_bank_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bank_user
    ADD CONSTRAINT pk_bank_user PRIMARY KEY (id);


--
-- Name: document_types pk_document_types; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_types
    ADD CONSTRAINT pk_document_types PRIMARY KEY (id);


--
-- Name: network_config pk_network_config; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.network_config
    ADD CONSTRAINT pk_network_config PRIMARY KEY (id);


--
-- Name: otp_table pk_otp_table; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.otp_table
    ADD CONSTRAINT pk_otp_table PRIMARY KEY (phone_number);


--
-- Name: sme pk_sme; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sme
    ADD CONSTRAINT pk_sme PRIMARY KEY (id);


--
-- Name: sme_documents pk_sme_documents; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sme_documents
    ADD CONSTRAINT pk_sme_documents PRIMARY KEY (id);


--
-- Name: sme_user pk_sme_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sme_user
    ADD CONSTRAINT pk_sme_user PRIMARY KEY (id);


--
-- Name: sme_user_documents pk_sme_user_documents; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sme_user_documents
    ADD CONSTRAINT pk_sme_user_documents PRIMARY KEY (id);


--
-- Name: rule rule_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rule
    ADD CONSTRAINT rule_pk PRIMARY KEY (id);


--
-- Name: rule_type rule_type_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rule_type
    ADD CONSTRAINT rule_type_pk PRIMARY KEY (id);


--
-- Name: sme_custom_rules sme_custom_rules_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sme_custom_rules
    ADD CONSTRAINT sme_custom_rules_pk PRIMARY KEY (id);


--
-- Name: sme_employee_banks sme_employee_banks_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sme_employee_banks
    ADD CONSTRAINT sme_employee_banks_pk PRIMARY KEY (id);


--
-- Name: sme_employee_loan_payment sme_employee_loan_payment_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sme_employee_loan_payment
    ADD CONSTRAINT sme_employee_loan_payment_pk PRIMARY KEY (id);


--
-- Name: sme_employee_loan sme_employee_loan_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sme_employee_loan
    ADD CONSTRAINT sme_employee_loan_pk PRIMARY KEY (id);


--
-- Name: bank_sme_partnership uq_bank_sme_partnership; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bank_sme_partnership
    ADD CONSTRAINT uq_bank_sme_partnership UNIQUE (bank_id, sme_id);


--
-- Name: network_config uq_network_config; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.network_config
    ADD CONSTRAINT uq_network_config UNIQUE (org_id);


--
-- Name: user_profile user_profile_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_profile
    ADD CONSTRAINT user_profile_pk PRIMARY KEY (id);


--
-- Name: idx_auth_user_username; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_user_username ON public.auth_user USING btree (username);


--
-- Name: idx_document_types_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_document_types_name ON public.document_types USING btree (name);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: cloudsqlsuperuser
--

REVOKE ALL ON SCHEMA public FROM cloudsqladmin;
REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO cloudsqlsuperuser;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

