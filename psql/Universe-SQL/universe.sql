--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

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

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

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
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(20) NOT NULL,
    description text,
    is_spherical boolean,
    constellation character varying(20)
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(20) NOT NULL,
    satellite_of character varying(7),
    is_spherical boolean,
    planet_id integer
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(20) NOT NULL,
    description text,
    is_spherical boolean,
    star_id integer
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(20) NOT NULL,
    description text,
    is_spherical boolean,
    galaxy_id integer
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: supercluster; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.supercluster (
    supercluster_id integer NOT NULL,
    name character varying(20) NOT NULL,
    description text,
    size_in_lightyear integer,
    distance_in_gigaparsec numeric(10,1),
    approx_number_of_galaxies integer
);


ALTER TABLE public.supercluster OWNER TO freecodecamp;

--
-- Name: supercluster_supercluster_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.supercluster_supercluster_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.supercluster_supercluster_id_seq OWNER TO freecodecamp;

--
-- Name: supercluster_supercluster_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.supercluster_supercluster_id_seq OWNED BY public.supercluster.supercluster_id;


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Name: supercluster supercluster_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.supercluster ALTER COLUMN supercluster_id SET DEFAULT nextval('public.supercluster_supercluster_id_seq'::regclass);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Milky Way', 'Earth''s own galaxy.', false, 'Sagittarius');
INSERT INTO public.galaxy VALUES (2, 'Andromeda', 'Andromeda is the closest big galaxy to the Milky Way and is expected to collide with the Milky Way around 4.5 billion years from now. The two will eventually merge into a single new galaxy called Milkdromeda.', false, 'Andromeda');
INSERT INTO public.galaxy VALUES (3, 'Antennae', 'Appearance is similar to an insect''s antennae.', false, 'Corvus');
INSERT INTO public.galaxy VALUES (4, 'Backward Galaxy', 'It appears to rotate backwards, as the tips of the spiral arms point in the direction of rotation.', false, 'Centaurus');
INSERT INTO public.galaxy VALUES (5, 'Black Eye Galaxy', 'It has a spectacular dark band of absorbing dust in front of the galaxy''s bright nucleus, giving rise to its nicknames of the "Black Eye" or "Evil Eye" galaxy.', false, 'Coma Berenices');
INSERT INTO public.galaxy VALUES (6, 'Bode''s Galaxy', 'The galaxy''s large size and relatively high brightness also makes it a popular target for amateur astronomers.', false, 'Ursa Major');


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 'Moon', 'Earth', true, 3);
INSERT INTO public.moon VALUES (2, 'Phobos', 'Mars', true, 4);
INSERT INTO public.moon VALUES (3, 'Deimos', 'Mars', true, 4);
INSERT INTO public.moon VALUES (4, 'Io', 'Jupiter', true, 5);
INSERT INTO public.moon VALUES (5, 'Europa', 'Jupiter', true, 5);
INSERT INTO public.moon VALUES (6, 'Ganymede', 'Jupiter', true, 5);
INSERT INTO public.moon VALUES (7, 'Callisto', 'Jupiter', true, 5);
INSERT INTO public.moon VALUES (8, 'Titan', 'Saturn', true, 6);
INSERT INTO public.moon VALUES (9, 'Rhea', 'Saturn', true, 6);
INSERT INTO public.moon VALUES (10, 'Ipaetus', 'Saturn', true, 6);
INSERT INTO public.moon VALUES (11, 'Dione', 'Saturn', true, 6);
INSERT INTO public.moon VALUES (12, 'Tethys', 'Saturn', true, 6);
INSERT INTO public.moon VALUES (13, 'Enceladus', 'Saturn', true, 6);
INSERT INTO public.moon VALUES (14, 'Titania', 'Uranus', true, 7);
INSERT INTO public.moon VALUES (15, 'Oberon', 'Uranus', true, 7);
INSERT INTO public.moon VALUES (16, 'Umbriel', 'Uranus', true, 7);
INSERT INTO public.moon VALUES (17, 'Ariel', 'Uranus', true, 7);
INSERT INTO public.moon VALUES (18, 'Miranda', 'Uranus', true, 7);
INSERT INTO public.moon VALUES (19, 'Triton', 'Neptune', true, 8);
INSERT INTO public.moon VALUES (20, 'Nereid', 'Neptune', true, 8);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 'Mercury', 'Nearest planet to Sun.', true, 1);
INSERT INTO public.planet VALUES (2, 'Venus', 'Closest planet to Earth.', true, 1);
INSERT INTO public.planet VALUES (3, 'Earth', 'Our own planet.', true, 1);
INSERT INTO public.planet VALUES (4, 'Mars', 'Earth 2.0 but uninhabitable.', true, 1);
INSERT INTO public.planet VALUES (5, 'Jupiter', 'Biggest planet in Solar system.', true, 1);
INSERT INTO public.planet VALUES (6, 'Saturn', 'It wears belts made of asteroids.', true, 1);
INSERT INTO public.planet VALUES (7, 'Uranus', 'Has nothing special except it''s name. You know what I mean :D.', true, 1);
INSERT INTO public.planet VALUES (8, 'Neptune', 'Last planet of our solar system.', true, 1);
INSERT INTO public.planet VALUES (9, 'Proxima Centauri b', 'First planet of Proxima Centauri', true, 2);
INSERT INTO public.planet VALUES (10, 'Proxima Centauri d', 'Farthest planet of Proxima Centauri', true, 2);
INSERT INTO public.planet VALUES (11, 'Candidate 1', 'We know it exists, but is it habitable?', true, 3);
INSERT INTO public.planet VALUES (12, 'Toliman c', 'Unlucky planet of an unlucky star. Being only planet of it''s star, it''s existence is disputed.', true, 4);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 'Sun', 'Earth''s own star.', true, 1);
INSERT INTO public.star VALUES (2, 'Proxima Centauri', 'It''s a flare star with two confirmed planets (b, 2016, and d, 2020) and a third disputed planet (c, 2019)', true, 1);
INSERT INTO public.star VALUES (3, 'Rigil Kentaurus', 'It has one directly-imaged habitable-zone planet candidate (Candidate 1) (2021)', true, 1);
INSERT INTO public.star VALUES (4, 'Toliman', 'It has one suspected planet (c) (2013) (planet b refuted in 2015)', true, 1);
INSERT INTO public.star VALUES (5, 'Barnard''s Star', 'A flare star with largest-known proper motion and one disputed planet (b)', true, 1);
INSERT INTO public.star VALUES (6, 'Luhman 16', 'It has one refuted planet (Ab in 2017)', true, 1);


--
-- Data for Name: supercluster; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.supercluster VALUES (1, 'Saraswati superclus.', 'Biggest supercluster', 652000000, 1.2, 3016);
INSERT INTO public.supercluster VALUES (2, 'Laniakea', 'Earth''s supercluster', 520000000, 0.0, 100000);
INSERT INTO public.supercluster VALUES (3, 'Shapley', 'Second supercluster found', 34000000, 0.2, 8000);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 6, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 20, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 12, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 6, true);


--
-- Name: supercluster_supercluster_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.supercluster_supercluster_id_seq', 3, true);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: supercluster supercluster_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.supercluster
    ADD CONSTRAINT supercluster_name_key UNIQUE (name);


--
-- Name: supercluster supercluster_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.supercluster
    ADD CONSTRAINT supercluster_pkey PRIMARY KEY (supercluster_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--

