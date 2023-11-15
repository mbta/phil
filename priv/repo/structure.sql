--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3 (Debian 15.3-1.pgdg120+1)
-- Dumped by pg_dump version 15.4

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: charlie_cards; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.charlie_cards (
    id bigint NOT NULL,
    batch_number integer NOT NULL,
    batch_sequence_number integer NOT NULL,
    card_valid_from timestamp(0) without time zone NOT NULL,
    card_valid_until timestamp(0) without time zone NOT NULL,
    product character varying(255) NOT NULL,
    product_valid_from timestamp(0) without time zone NOT NULL,
    product_valid_until timestamp(0) without time zone NOT NULL,
    production_date timestamp(0) without time zone NOT NULL,
    sequence_number integer NOT NULL,
    status character varying(255) DEFAULT 'unknown'::character varying NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    serial_number character varying(255)
);


--
-- Name: charlie_cards_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.charlie_cards_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: charlie_cards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.charlie_cards_id_seq OWNED BY public.charlie_cards.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


--
-- Name: charlie_cards id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.charlie_cards ALTER COLUMN id SET DEFAULT nextval('public.charlie_cards_id_seq'::regclass);


--
-- Name: charlie_cards charlie_cards_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.charlie_cards
    ADD CONSTRAINT charlie_cards_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: charlie_cards_serial_number_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX charlie_cards_serial_number_index ON public.charlie_cards USING btree (serial_number);


--
-- PostgreSQL database dump complete
--

INSERT INTO public."schema_migrations" (version) VALUES (20231113160043);
INSERT INTO public."schema_migrations" (version) VALUES (20231115170528);
