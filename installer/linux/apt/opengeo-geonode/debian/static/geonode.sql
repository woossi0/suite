--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- Create geonode user account
--

CREATE ROLE geonode WITH LOGIN PASSWORD 'geonode' SUPERUSER INHERIT;

--
-- Make geonode user owner of geonode db
--
ALTER DATABASE geonode OWNER TO geonode;
