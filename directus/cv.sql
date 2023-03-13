--
-- PostgreSQL database dump
--

-- Dumped from database version 13.8 (Debian 13.8-1.pgdg110+1)
-- Dumped by pg_dump version 13.8 (Debian 13.8-1.pgdg110+1)

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
-- Name: tiger; Type: SCHEMA; Schema: -; Owner: cv
--

CREATE SCHEMA tiger;


ALTER SCHEMA tiger OWNER TO cv;

--
-- Name: tiger_data; Type: SCHEMA; Schema: -; Owner: cv
--

CREATE SCHEMA tiger_data;


ALTER SCHEMA tiger_data OWNER TO cv;

--
-- Name: topology; Type: SCHEMA; Schema: -; Owner: cv
--

CREATE SCHEMA topology;


ALTER SCHEMA topology OWNER TO cv;

--
-- Name: SCHEMA topology; Type: COMMENT; Schema: -; Owner: cv
--

COMMENT ON SCHEMA topology IS 'PostGIS Topology schema';


--
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


--
-- Name: postgis_tiger_geocoder; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder WITH SCHEMA tiger;


--
-- Name: EXTENSION postgis_tiger_geocoder; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_tiger_geocoder IS 'PostGIS tiger geocoder and reverse geocoder';


--
-- Name: postgis_topology; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis_topology WITH SCHEMA topology;


--
-- Name: EXTENSION postgis_topology; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_topology IS 'PostGIS topology spatial types and functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: articles; Type: TABLE; Schema: public; Owner: cv
--

CREATE TABLE public.articles (
    id integer NOT NULL,
    date_updated timestamp with time zone,
    tags json
);


ALTER TABLE public.articles OWNER TO cv;

--
-- Name: articles_categories; Type: TABLE; Schema: public; Owner: cv
--

CREATE TABLE public.articles_categories (
    id integer NOT NULL,
    articles_id integer,
    categories_id integer
);


ALTER TABLE public.articles_categories OWNER TO cv;

--
-- Name: articles_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: cv
--

CREATE SEQUENCE public.articles_categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.articles_categories_id_seq OWNER TO cv;

--
-- Name: articles_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cv
--

ALTER SEQUENCE public.articles_categories_id_seq OWNED BY public.articles_categories.id;


--
-- Name: articles_id_seq; Type: SEQUENCE; Schema: public; Owner: cv
--

CREATE SEQUENCE public.articles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.articles_id_seq OWNER TO cv;

--
-- Name: articles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cv
--

ALTER SEQUENCE public.articles_id_seq OWNED BY public.articles.id;


--
-- Name: articles_translations; Type: TABLE; Schema: public; Owner: cv
--

CREATE TABLE public.articles_translations (
    id integer NOT NULL,
    articles_id integer,
    lang_code character varying(255),
    title character varying(255),
    body text
);


ALTER TABLE public.articles_translations OWNER TO cv;

--
-- Name: articles_translations_id_seq; Type: SEQUENCE; Schema: public; Owner: cv
--

CREATE SEQUENCE public.articles_translations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.articles_translations_id_seq OWNER TO cv;

--
-- Name: articles_translations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cv
--

ALTER SEQUENCE public.articles_translations_id_seq OWNED BY public.articles_translations.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: cv
--

CREATE TABLE public.categories (
    id integer NOT NULL
);


ALTER TABLE public.categories OWNER TO cv;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: cv
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO cv;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cv
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: categories_translations; Type: TABLE; Schema: public; Owner: cv
--

CREATE TABLE public.categories_translations (
    id integer NOT NULL,
    categories_id integer,
    lang_code character varying(255),
    title character varying(255)
);


ALTER TABLE public.categories_translations OWNER TO cv;

--
-- Name: categories_translations_id_seq; Type: SEQUENCE; Schema: public; Owner: cv
--

CREATE SEQUENCE public.categories_translations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_translations_id_seq OWNER TO cv;

--
-- Name: categories_translations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cv
--

ALTER SEQUENCE public.categories_translations_id_seq OWNED BY public.categories_translations.id;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: cv
--

CREATE TABLE public.comments (
    id integer NOT NULL,
    created_at timestamp with time zone,
    name character varying(255) DEFAULT 'Anonymous'::character varying,
    body text
);


ALTER TABLE public.comments OWNER TO cv;

--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: cv
--

CREATE SEQUENCE public.comments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comments_id_seq OWNER TO cv;

--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cv
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- Name: directus_activity; Type: TABLE; Schema: public; Owner: cv
--

CREATE TABLE public.directus_activity (
    id integer NOT NULL,
    action character varying(45) NOT NULL,
    "user" uuid,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    ip character varying(50),
    user_agent character varying(255),
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    comment text,
    origin character varying(255)
);


ALTER TABLE public.directus_activity OWNER TO cv;

--
-- Name: directus_activity_id_seq; Type: SEQUENCE; Schema: public; Owner: cv
--

CREATE SEQUENCE public.directus_activity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_activity_id_seq OWNER TO cv;

--
-- Name: directus_activity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cv
--

ALTER SEQUENCE public.directus_activity_id_seq OWNED BY public.directus_activity.id;


--
-- Name: directus_collections; Type: TABLE; Schema: public; Owner: cv
--

CREATE TABLE public.directus_collections (
    collection character varying(64) NOT NULL,
    icon character varying(30),
    note text,
    display_template character varying(255),
    hidden boolean DEFAULT false NOT NULL,
    singleton boolean DEFAULT false NOT NULL,
    translations json,
    archive_field character varying(64),
    archive_app_filter boolean DEFAULT true NOT NULL,
    archive_value character varying(255),
    unarchive_value character varying(255),
    sort_field character varying(64),
    accountability character varying(255) DEFAULT 'all'::character varying,
    color character varying(255),
    item_duplication_fields json,
    sort integer,
    "group" character varying(64),
    collapse character varying(255) DEFAULT 'open'::character varying NOT NULL
);


ALTER TABLE public.directus_collections OWNER TO cv;

--
-- Name: directus_dashboards; Type: TABLE; Schema: public; Owner: cv
--

CREATE TABLE public.directus_dashboards (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    icon character varying(30) DEFAULT 'dashboard'::character varying NOT NULL,
    note text,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    color character varying(255)
);


ALTER TABLE public.directus_dashboards OWNER TO cv;

--
-- Name: directus_fields; Type: TABLE; Schema: public; Owner: cv
--

CREATE TABLE public.directus_fields (
    id integer NOT NULL,
    collection character varying(64) NOT NULL,
    field character varying(64) NOT NULL,
    special character varying(64),
    interface character varying(64),
    options json,
    display character varying(64),
    display_options json,
    readonly boolean DEFAULT false NOT NULL,
    hidden boolean DEFAULT false NOT NULL,
    sort integer,
    width character varying(30) DEFAULT 'full'::character varying,
    translations json,
    note text,
    conditions json,
    required boolean DEFAULT false,
    "group" character varying(64),
    validation json,
    validation_message text
);


ALTER TABLE public.directus_fields OWNER TO cv;

--
-- Name: directus_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: cv
--

CREATE SEQUENCE public.directus_fields_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_fields_id_seq OWNER TO cv;

--
-- Name: directus_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cv
--

ALTER SEQUENCE public.directus_fields_id_seq OWNED BY public.directus_fields.id;


--
-- Name: directus_files; Type: TABLE; Schema: public; Owner: cv
--

CREATE TABLE public.directus_files (
    id uuid NOT NULL,
    storage character varying(255) NOT NULL,
    filename_disk character varying(255),
    filename_download character varying(255) NOT NULL,
    title character varying(255),
    type character varying(255),
    folder uuid,
    uploaded_by uuid,
    uploaded_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modified_by uuid,
    modified_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    charset character varying(50),
    filesize bigint,
    width integer,
    height integer,
    duration integer,
    embed character varying(200),
    description text,
    location text,
    tags text,
    metadata json
);


ALTER TABLE public.directus_files OWNER TO cv;

--
-- Name: directus_flows; Type: TABLE; Schema: public; Owner: cv
--

CREATE TABLE public.directus_flows (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    icon character varying(30),
    color character varying(255),
    description text,
    status character varying(255) DEFAULT 'active'::character varying NOT NULL,
    trigger character varying(255),
    accountability character varying(255) DEFAULT 'all'::character varying,
    options json,
    operation uuid,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_flows OWNER TO cv;

--
-- Name: directus_folders; Type: TABLE; Schema: public; Owner: cv
--

CREATE TABLE public.directus_folders (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    parent uuid
);


ALTER TABLE public.directus_folders OWNER TO cv;

--
-- Name: directus_migrations; Type: TABLE; Schema: public; Owner: cv
--

CREATE TABLE public.directus_migrations (
    version character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.directus_migrations OWNER TO cv;

--
-- Name: directus_notifications; Type: TABLE; Schema: public; Owner: cv
--

CREATE TABLE public.directus_notifications (
    id integer NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    status character varying(255) DEFAULT 'inbox'::character varying,
    recipient uuid NOT NULL,
    sender uuid,
    subject character varying(255) NOT NULL,
    message text,
    collection character varying(64),
    item character varying(255)
);


ALTER TABLE public.directus_notifications OWNER TO cv;

--
-- Name: directus_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: cv
--

CREATE SEQUENCE public.directus_notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_notifications_id_seq OWNER TO cv;

--
-- Name: directus_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cv
--

ALTER SEQUENCE public.directus_notifications_id_seq OWNED BY public.directus_notifications.id;


--
-- Name: directus_operations; Type: TABLE; Schema: public; Owner: cv
--

CREATE TABLE public.directus_operations (
    id uuid NOT NULL,
    name character varying(255),
    key character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    position_x integer NOT NULL,
    position_y integer NOT NULL,
    options json,
    resolve uuid,
    reject uuid,
    flow uuid NOT NULL,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_operations OWNER TO cv;

--
-- Name: directus_panels; Type: TABLE; Schema: public; Owner: cv
--

CREATE TABLE public.directus_panels (
    id uuid NOT NULL,
    dashboard uuid NOT NULL,
    name character varying(255),
    icon character varying(30) DEFAULT NULL::character varying,
    color character varying(10),
    show_header boolean DEFAULT false NOT NULL,
    note text,
    type character varying(255) NOT NULL,
    position_x integer NOT NULL,
    position_y integer NOT NULL,
    width integer NOT NULL,
    height integer NOT NULL,
    options json,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_panels OWNER TO cv;

--
-- Name: directus_permissions; Type: TABLE; Schema: public; Owner: cv
--

CREATE TABLE public.directus_permissions (
    id integer NOT NULL,
    role uuid,
    collection character varying(64) NOT NULL,
    action character varying(10) NOT NULL,
    permissions json,
    validation json,
    presets json,
    fields text
);


ALTER TABLE public.directus_permissions OWNER TO cv;

--
-- Name: directus_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: cv
--

CREATE SEQUENCE public.directus_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_permissions_id_seq OWNER TO cv;

--
-- Name: directus_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cv
--

ALTER SEQUENCE public.directus_permissions_id_seq OWNED BY public.directus_permissions.id;


--
-- Name: directus_presets; Type: TABLE; Schema: public; Owner: cv
--

CREATE TABLE public.directus_presets (
    id integer NOT NULL,
    bookmark character varying(255),
    "user" uuid,
    role uuid,
    collection character varying(64),
    search character varying(100),
    layout character varying(100) DEFAULT 'tabular'::character varying,
    layout_query json,
    layout_options json,
    refresh_interval integer,
    filter json,
    icon character varying(30) DEFAULT 'bookmark_outline'::character varying NOT NULL,
    color character varying(255)
);


ALTER TABLE public.directus_presets OWNER TO cv;

--
-- Name: directus_presets_id_seq; Type: SEQUENCE; Schema: public; Owner: cv
--

CREATE SEQUENCE public.directus_presets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_presets_id_seq OWNER TO cv;

--
-- Name: directus_presets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cv
--

ALTER SEQUENCE public.directus_presets_id_seq OWNED BY public.directus_presets.id;


--
-- Name: directus_relations; Type: TABLE; Schema: public; Owner: cv
--

CREATE TABLE public.directus_relations (
    id integer NOT NULL,
    many_collection character varying(64) NOT NULL,
    many_field character varying(64) NOT NULL,
    one_collection character varying(64),
    one_field character varying(64),
    one_collection_field character varying(64),
    one_allowed_collections text,
    junction_field character varying(64),
    sort_field character varying(64),
    one_deselect_action character varying(255) DEFAULT 'nullify'::character varying NOT NULL
);


ALTER TABLE public.directus_relations OWNER TO cv;

--
-- Name: directus_relations_id_seq; Type: SEQUENCE; Schema: public; Owner: cv
--

CREATE SEQUENCE public.directus_relations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_relations_id_seq OWNER TO cv;

--
-- Name: directus_relations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cv
--

ALTER SEQUENCE public.directus_relations_id_seq OWNED BY public.directus_relations.id;


--
-- Name: directus_revisions; Type: TABLE; Schema: public; Owner: cv
--

CREATE TABLE public.directus_revisions (
    id integer NOT NULL,
    activity integer NOT NULL,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    data json,
    delta json,
    parent integer
);


ALTER TABLE public.directus_revisions OWNER TO cv;

--
-- Name: directus_revisions_id_seq; Type: SEQUENCE; Schema: public; Owner: cv
--

CREATE SEQUENCE public.directus_revisions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_revisions_id_seq OWNER TO cv;

--
-- Name: directus_revisions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cv
--

ALTER SEQUENCE public.directus_revisions_id_seq OWNED BY public.directus_revisions.id;


--
-- Name: directus_roles; Type: TABLE; Schema: public; Owner: cv
--

CREATE TABLE public.directus_roles (
    id uuid NOT NULL,
    name character varying(100) NOT NULL,
    icon character varying(30) DEFAULT 'supervised_user_circle'::character varying NOT NULL,
    description text,
    ip_access text,
    enforce_tfa boolean DEFAULT false NOT NULL,
    admin_access boolean DEFAULT false NOT NULL,
    app_access boolean DEFAULT true NOT NULL
);


ALTER TABLE public.directus_roles OWNER TO cv;

--
-- Name: directus_sessions; Type: TABLE; Schema: public; Owner: cv
--

CREATE TABLE public.directus_sessions (
    token character varying(64) NOT NULL,
    "user" uuid,
    expires timestamp with time zone NOT NULL,
    ip character varying(255),
    user_agent character varying(255),
    share uuid,
    origin character varying(255)
);


ALTER TABLE public.directus_sessions OWNER TO cv;

--
-- Name: directus_settings; Type: TABLE; Schema: public; Owner: cv
--

CREATE TABLE public.directus_settings (
    id integer NOT NULL,
    project_name character varying(100) DEFAULT 'Directus'::character varying NOT NULL,
    project_url character varying(255),
    project_color character varying(50) DEFAULT NULL::character varying,
    project_logo uuid,
    public_foreground uuid,
    public_background uuid,
    public_note text,
    auth_login_attempts integer DEFAULT 25,
    auth_password_policy character varying(100),
    storage_asset_transform character varying(7) DEFAULT 'all'::character varying,
    storage_asset_presets json,
    custom_css text,
    storage_default_folder uuid,
    basemaps json,
    mapbox_key character varying(255),
    module_bar json,
    project_descriptor character varying(100),
    translation_strings json,
    default_language character varying(255) DEFAULT 'en-US'::character varying NOT NULL,
    custom_aspect_ratios json
);


ALTER TABLE public.directus_settings OWNER TO cv;

--
-- Name: directus_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: cv
--

CREATE SEQUENCE public.directus_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_settings_id_seq OWNER TO cv;

--
-- Name: directus_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cv
--

ALTER SEQUENCE public.directus_settings_id_seq OWNED BY public.directus_settings.id;


--
-- Name: directus_shares; Type: TABLE; Schema: public; Owner: cv
--

CREATE TABLE public.directus_shares (
    id uuid NOT NULL,
    name character varying(255),
    collection character varying(64),
    item character varying(255),
    role uuid,
    password character varying(255),
    user_created uuid,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_start timestamp with time zone,
    date_end timestamp with time zone,
    times_used integer DEFAULT 0,
    max_uses integer
);


ALTER TABLE public.directus_shares OWNER TO cv;

--
-- Name: directus_users; Type: TABLE; Schema: public; Owner: cv
--

CREATE TABLE public.directus_users (
    id uuid NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    email character varying(128),
    password character varying(255),
    location character varying(255),
    title character varying(50),
    description text,
    tags json,
    avatar uuid,
    language character varying(255) DEFAULT NULL::character varying,
    theme character varying(20) DEFAULT 'auto'::character varying,
    tfa_secret character varying(255),
    status character varying(16) DEFAULT 'active'::character varying NOT NULL,
    role uuid,
    token character varying(255),
    last_access timestamp with time zone,
    last_page character varying(255),
    provider character varying(128) DEFAULT 'default'::character varying NOT NULL,
    external_identifier character varying(255),
    auth_data json,
    email_notifications boolean DEFAULT true
);


ALTER TABLE public.directus_users OWNER TO cv;

--
-- Name: directus_webhooks; Type: TABLE; Schema: public; Owner: cv
--

CREATE TABLE public.directus_webhooks (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    method character varying(10) DEFAULT 'POST'::character varying NOT NULL,
    url character varying(255) NOT NULL,
    status character varying(10) DEFAULT 'active'::character varying NOT NULL,
    data boolean DEFAULT true NOT NULL,
    actions character varying(100) NOT NULL,
    collections character varying(255) NOT NULL,
    headers json
);


ALTER TABLE public.directus_webhooks OWNER TO cv;

--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE; Schema: public; Owner: cv
--

CREATE SEQUENCE public.directus_webhooks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_webhooks_id_seq OWNER TO cv;

--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cv
--

ALTER SEQUENCE public.directus_webhooks_id_seq OWNED BY public.directus_webhooks.id;


--
-- Name: formations; Type: TABLE; Schema: public; Owner: cv
--

CREATE TABLE public.formations (
    id integer NOT NULL,
    start timestamp without time zone,
    "end" timestamp without time zone,
    current boolean,
    image uuid,
    type integer DEFAULT 1
);


ALTER TABLE public.formations OWNER TO cv;

--
-- Name: formations_id_seq; Type: SEQUENCE; Schema: public; Owner: cv
--

CREATE SEQUENCE public.formations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.formations_id_seq OWNER TO cv;

--
-- Name: formations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cv
--

ALTER SEQUENCE public.formations_id_seq OWNED BY public.formations.id;


--
-- Name: formations_translations; Type: TABLE; Schema: public; Owner: cv
--

CREATE TABLE public.formations_translations (
    id integer NOT NULL,
    formations_id integer,
    lang_code character varying(255),
    institution character varying(255),
    skills json,
    name character varying(255)
);


ALTER TABLE public.formations_translations OWNER TO cv;

--
-- Name: formations_translations_id_seq; Type: SEQUENCE; Schema: public; Owner: cv
--

CREATE SEQUENCE public.formations_translations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.formations_translations_id_seq OWNER TO cv;

--
-- Name: formations_translations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cv
--

ALTER SEQUENCE public.formations_translations_id_seq OWNED BY public.formations_translations.id;


--
-- Name: lang; Type: TABLE; Schema: public; Owner: cv
--

CREATE TABLE public.lang (
    code character varying(255) NOT NULL,
    name character varying(255)
);


ALTER TABLE public.lang OWNER TO cv;

--
-- Name: languages; Type: TABLE; Schema: public; Owner: cv
--

CREATE TABLE public.languages (
    id integer NOT NULL,
    name character varying(255),
    logo uuid,
    link character varying(255)
);


ALTER TABLE public.languages OWNER TO cv;

--
-- Name: languages_id_seq; Type: SEQUENCE; Schema: public; Owner: cv
--

CREATE SEQUENCE public.languages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.languages_id_seq OWNER TO cv;

--
-- Name: languages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cv
--

ALTER SEQUENCE public.languages_id_seq OWNED BY public.languages.id;


--
-- Name: links; Type: TABLE; Schema: public; Owner: cv
--

CREATE TABLE public.links (
    id integer NOT NULL,
    link character varying(255),
    name character varying(255)
);


ALTER TABLE public.links OWNER TO cv;

--
-- Name: links_id_seq; Type: SEQUENCE; Schema: public; Owner: cv
--

CREATE SEQUENCE public.links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.links_id_seq OWNER TO cv;

--
-- Name: links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cv
--

ALTER SEQUENCE public.links_id_seq OWNED BY public.links.id;


--
-- Name: profile; Type: TABLE; Schema: public; Owner: cv
--

CREATE TABLE public.profile (
    id integer NOT NULL,
    logo uuid,
    linkedin character varying(255),
    email character varying(255) DEFAULT 'loys.caucheteux@gmail.com'::character varying,
    github character varying(255) DEFAULT 'https://github.com/gummyWalrus'::character varying,
    stackoverflow character varying(255) DEFAULT 'https://stackoverflow.com/users/15122221/loys-caucheteux'::character varying,
    phone character varying(255) DEFAULT '+33 7 68 85 35 64'::character varying,
    name character varying(255) DEFAULT 'Loys Caucheteux'::character varying
);


ALTER TABLE public.profile OWNER TO cv;

--
-- Name: profile_id_seq; Type: SEQUENCE; Schema: public; Owner: cv
--

CREATE SEQUENCE public.profile_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.profile_id_seq OWNER TO cv;

--
-- Name: profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cv
--

ALTER SEQUENCE public.profile_id_seq OWNED BY public.profile.id;


--
-- Name: profile_section; Type: TABLE; Schema: public; Owner: cv
--

CREATE TABLE public.profile_section (
    id integer NOT NULL,
    date_created timestamp with time zone,
    date_updated timestamp with time zone,
    profile integer,
    title character varying(255)
);


ALTER TABLE public.profile_section OWNER TO cv;

--
-- Name: profile_section_id_seq; Type: SEQUENCE; Schema: public; Owner: cv
--

CREATE SEQUENCE public.profile_section_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.profile_section_id_seq OWNER TO cv;

--
-- Name: profile_section_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cv
--

ALTER SEQUENCE public.profile_section_id_seq OWNED BY public.profile_section.id;


--
-- Name: profile_section_item; Type: TABLE; Schema: public; Owner: cv
--

CREATE TABLE public.profile_section_item (
    id integer NOT NULL,
    date_created timestamp with time zone,
    date_updated timestamp with time zone,
    image uuid,
    section integer
);


ALTER TABLE public.profile_section_item OWNER TO cv;

--
-- Name: profile_section_item_id_seq; Type: SEQUENCE; Schema: public; Owner: cv
--

CREATE SEQUENCE public.profile_section_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.profile_section_item_id_seq OWNER TO cv;

--
-- Name: profile_section_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cv
--

ALTER SEQUENCE public.profile_section_item_id_seq OWNED BY public.profile_section_item.id;


--
-- Name: profile_section_item_translations; Type: TABLE; Schema: public; Owner: cv
--

CREATE TABLE public.profile_section_item_translations (
    id integer NOT NULL,
    profile_section_item_id integer,
    lang_code character varying(255),
    title character varying(255),
    subtitle character varying(255)
);


ALTER TABLE public.profile_section_item_translations OWNER TO cv;

--
-- Name: profile_section_item_translations_id_seq; Type: SEQUENCE; Schema: public; Owner: cv
--

CREATE SEQUENCE public.profile_section_item_translations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.profile_section_item_translations_id_seq OWNER TO cv;

--
-- Name: profile_section_item_translations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cv
--

ALTER SEQUENCE public.profile_section_item_translations_id_seq OWNED BY public.profile_section_item_translations.id;


--
-- Name: profile_section_translations; Type: TABLE; Schema: public; Owner: cv
--

CREATE TABLE public.profile_section_translations (
    id integer NOT NULL,
    profile_section_id integer,
    lang_code character varying(255),
    section_title character varying(255)
);


ALTER TABLE public.profile_section_translations OWNER TO cv;

--
-- Name: profile_section_translations_id_seq; Type: SEQUENCE; Schema: public; Owner: cv
--

CREATE SEQUENCE public.profile_section_translations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.profile_section_translations_id_seq OWNER TO cv;

--
-- Name: profile_section_translations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cv
--

ALTER SEQUENCE public.profile_section_translations_id_seq OWNED BY public.profile_section_translations.id;


--
-- Name: profile_translations; Type: TABLE; Schema: public; Owner: cv
--

CREATE TABLE public.profile_translations (
    id integer NOT NULL,
    profile_id integer,
    lang_code character varying(255),
    poste character varying(255),
    description text
);


ALTER TABLE public.profile_translations OWNER TO cv;

--
-- Name: profile_translations_id_seq; Type: SEQUENCE; Schema: public; Owner: cv
--

CREATE SEQUENCE public.profile_translations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.profile_translations_id_seq OWNER TO cv;

--
-- Name: profile_translations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cv
--

ALTER SEQUENCE public.profile_translations_id_seq OWNED BY public.profile_translations.id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: cv
--

CREATE TABLE public.projects (
    id integer NOT NULL,
    name character varying(255),
    github character varying(255),
    tags character varying(4096),
    background uuid
);


ALTER TABLE public.projects OWNER TO cv;

--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: cv
--

CREATE SEQUENCE public.projects_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.projects_id_seq OWNER TO cv;

--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cv
--

ALTER SEQUENCE public.projects_id_seq OWNED BY public.projects.id;


--
-- Name: projects_languages; Type: TABLE; Schema: public; Owner: cv
--

CREATE TABLE public.projects_languages (
    id integer NOT NULL,
    projects_id integer,
    languages_id integer
);


ALTER TABLE public.projects_languages OWNER TO cv;

--
-- Name: projects_languages_id_seq; Type: SEQUENCE; Schema: public; Owner: cv
--

CREATE SEQUENCE public.projects_languages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.projects_languages_id_seq OWNER TO cv;

--
-- Name: projects_languages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cv
--

ALTER SEQUENCE public.projects_languages_id_seq OWNED BY public.projects_languages.id;


--
-- Name: projects_links; Type: TABLE; Schema: public; Owner: cv
--

CREATE TABLE public.projects_links (
    id integer NOT NULL,
    projects_id integer,
    links_id integer
);


ALTER TABLE public.projects_links OWNER TO cv;

--
-- Name: projects_links_id_seq; Type: SEQUENCE; Schema: public; Owner: cv
--

CREATE SEQUENCE public.projects_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.projects_links_id_seq OWNER TO cv;

--
-- Name: projects_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cv
--

ALTER SEQUENCE public.projects_links_id_seq OWNED BY public.projects_links.id;


--
-- Name: projects_translations; Type: TABLE; Schema: public; Owner: cv
--

CREATE TABLE public.projects_translations (
    id integer NOT NULL,
    projects_id integer,
    lang_code character varying(255),
    title character varying(255),
    body character varying(255)
);


ALTER TABLE public.projects_translations OWNER TO cv;

--
-- Name: projects_translations_id_seq; Type: SEQUENCE; Schema: public; Owner: cv
--

CREATE SEQUENCE public.projects_translations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.projects_translations_id_seq OWNER TO cv;

--
-- Name: projects_translations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cv
--

ALTER SEQUENCE public.projects_translations_id_seq OWNED BY public.projects_translations.id;


--
-- Name: articles id; Type: DEFAULT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.articles ALTER COLUMN id SET DEFAULT nextval('public.articles_id_seq'::regclass);


--
-- Name: articles_categories id; Type: DEFAULT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.articles_categories ALTER COLUMN id SET DEFAULT nextval('public.articles_categories_id_seq'::regclass);


--
-- Name: articles_translations id; Type: DEFAULT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.articles_translations ALTER COLUMN id SET DEFAULT nextval('public.articles_translations_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: categories_translations id; Type: DEFAULT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.categories_translations ALTER COLUMN id SET DEFAULT nextval('public.categories_translations_id_seq'::regclass);


--
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- Name: directus_activity id; Type: DEFAULT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_activity ALTER COLUMN id SET DEFAULT nextval('public.directus_activity_id_seq'::regclass);


--
-- Name: directus_fields id; Type: DEFAULT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_fields ALTER COLUMN id SET DEFAULT nextval('public.directus_fields_id_seq'::regclass);


--
-- Name: directus_notifications id; Type: DEFAULT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_notifications ALTER COLUMN id SET DEFAULT nextval('public.directus_notifications_id_seq'::regclass);


--
-- Name: directus_permissions id; Type: DEFAULT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_permissions ALTER COLUMN id SET DEFAULT nextval('public.directus_permissions_id_seq'::regclass);


--
-- Name: directus_presets id; Type: DEFAULT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_presets ALTER COLUMN id SET DEFAULT nextval('public.directus_presets_id_seq'::regclass);


--
-- Name: directus_relations id; Type: DEFAULT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_relations ALTER COLUMN id SET DEFAULT nextval('public.directus_relations_id_seq'::regclass);


--
-- Name: directus_revisions id; Type: DEFAULT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_revisions ALTER COLUMN id SET DEFAULT nextval('public.directus_revisions_id_seq'::regclass);


--
-- Name: directus_settings id; Type: DEFAULT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_settings ALTER COLUMN id SET DEFAULT nextval('public.directus_settings_id_seq'::regclass);


--
-- Name: directus_webhooks id; Type: DEFAULT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_webhooks ALTER COLUMN id SET DEFAULT nextval('public.directus_webhooks_id_seq'::regclass);


--
-- Name: formations id; Type: DEFAULT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.formations ALTER COLUMN id SET DEFAULT nextval('public.formations_id_seq'::regclass);


--
-- Name: formations_translations id; Type: DEFAULT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.formations_translations ALTER COLUMN id SET DEFAULT nextval('public.formations_translations_id_seq'::regclass);


--
-- Name: languages id; Type: DEFAULT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.languages ALTER COLUMN id SET DEFAULT nextval('public.languages_id_seq'::regclass);


--
-- Name: links id; Type: DEFAULT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.links ALTER COLUMN id SET DEFAULT nextval('public.links_id_seq'::regclass);


--
-- Name: profile id; Type: DEFAULT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.profile ALTER COLUMN id SET DEFAULT nextval('public.profile_id_seq'::regclass);


--
-- Name: profile_section id; Type: DEFAULT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.profile_section ALTER COLUMN id SET DEFAULT nextval('public.profile_section_id_seq'::regclass);


--
-- Name: profile_section_item id; Type: DEFAULT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.profile_section_item ALTER COLUMN id SET DEFAULT nextval('public.profile_section_item_id_seq'::regclass);


--
-- Name: profile_section_item_translations id; Type: DEFAULT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.profile_section_item_translations ALTER COLUMN id SET DEFAULT nextval('public.profile_section_item_translations_id_seq'::regclass);


--
-- Name: profile_section_translations id; Type: DEFAULT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.profile_section_translations ALTER COLUMN id SET DEFAULT nextval('public.profile_section_translations_id_seq'::regclass);


--
-- Name: profile_translations id; Type: DEFAULT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.profile_translations ALTER COLUMN id SET DEFAULT nextval('public.profile_translations_id_seq'::regclass);


--
-- Name: projects id; Type: DEFAULT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.projects ALTER COLUMN id SET DEFAULT nextval('public.projects_id_seq'::regclass);


--
-- Name: projects_languages id; Type: DEFAULT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.projects_languages ALTER COLUMN id SET DEFAULT nextval('public.projects_languages_id_seq'::regclass);


--
-- Name: projects_links id; Type: DEFAULT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.projects_links ALTER COLUMN id SET DEFAULT nextval('public.projects_links_id_seq'::regclass);


--
-- Name: projects_translations id; Type: DEFAULT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.projects_translations ALTER COLUMN id SET DEFAULT nextval('public.projects_translations_id_seq'::regclass);


--
-- Data for Name: articles; Type: TABLE DATA; Schema: public; Owner: cv
--

COPY public.articles (id, date_updated, tags) FROM stdin;
1	2023-02-28 04:06:57.304+00	["devops"]
\.


--
-- Data for Name: articles_categories; Type: TABLE DATA; Schema: public; Owner: cv
--

COPY public.articles_categories (id, articles_id, categories_id) FROM stdin;
1	1	1
\.


--
-- Data for Name: articles_translations; Type: TABLE DATA; Schema: public; Owner: cv
--

COPY public.articles_translations (id, articles_id, lang_code, title, body) FROM stdin;
1	1	en	Kubernetes	## Kubectl is love
2	1	fr	Kubernetes	# kubernetes c bien
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: cv
--

COPY public.categories (id) FROM stdin;
1
2
\.


--
-- Data for Name: categories_translations; Type: TABLE DATA; Schema: public; Owner: cv
--

COPY public.categories_translations (id, categories_id, lang_code, title) FROM stdin;
1	1	en	DevOps
2	1	fr	DevOps
3	2	en	C++
4	2	fr	C++
\.


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: cv
--

COPY public.comments (id, created_at, name, body) FROM stdin;
1	2022-11-29 02:23:26.246+00	Loys	**Oui**
2	2022-11-29 02:24:07.193+00	Anonymous	NON
3	2022-11-29 02:25:06.427+00	Anonymous	dsdsdsdsdsd
\.


--
-- Data for Name: directus_activity; Type: TABLE DATA; Schema: public; Owner: cv
--

COPY public.directus_activity (id, action, "user", "timestamp", ip, user_agent, collection, item, comment, origin) FROM stdin;
1	login	a5813e40-3394-40b1-8143-74e680638c71	2022-11-28 19:15:46.204+00	172.18.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_users	a5813e40-3394-40b1-8143-74e680638c71	\N	http://localhost:8055
2	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-28 19:19:31.989+00	172.18.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_fields	1	\N	http://localhost:8055
3	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-28 19:19:32+00	172.18.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_collections	Commentaire	\N	http://localhost:8055
4	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-28 19:22:19.504+00	172.18.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_fields	2	\N	http://localhost:8055
5	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-28 19:24:15.092+00	172.18.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_fields	3	\N	http://localhost:8055
6	update	a5813e40-3394-40b1-8143-74e680638c71	2022-11-28 19:26:07.336+00	172.18.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_collections	Commentaire	\N	http://localhost:8055
7	update	a5813e40-3394-40b1-8143-74e680638c71	2022-11-28 19:26:30.07+00	172.18.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_collections	Commentaire	\N	http://localhost:8055
9	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 00:52:06.686+00	172.18.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_permissions	1	\N	http://localhost:8055
10	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 00:56:57.013+00	172.18.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_permissions	2	\N	http://localhost:8055
12	update	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 01:04:54.495+00	172.18.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_collections	Commentaire	\N	http://localhost:8055
13	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 01:05:06.019+00	172.18.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_permissions	4	\N	http://localhost:8055
14	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 01:05:06.02+00	172.18.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_permissions	5	\N	http://localhost:8055
15	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 01:05:06.021+00	172.18.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_permissions	3	\N	http://localhost:8055
16	update	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 01:05:06.028+00	172.18.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_permissions	2	\N	http://localhost:8055
17	update	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 01:05:06.03+00	172.18.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_permissions	1	\N	http://localhost:8055
18	delete	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 01:05:07.415+00	172.18.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_permissions	1	\N	http://localhost:8055
19	delete	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 01:05:07.417+00	172.18.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_permissions	2	\N	http://localhost:8055
20	delete	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 01:05:07.419+00	172.18.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_permissions	3	\N	http://localhost:8055
21	delete	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 01:05:07.421+00	172.18.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_permissions	4	\N	http://localhost:8055
22	delete	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 01:05:07.423+00	172.18.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_permissions	5	\N	http://localhost:8055
23	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 01:05:10.815+00	172.18.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_permissions	6	\N	http://localhost:8055
24	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 02:19:25.598+00	172.23.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_fields	4	\N	http://localhost:8055
26	delete	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 02:20:40.807+00	172.23.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_collections	Commentaire	\N	http://localhost:8055
27	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 02:21:07.651+00	172.23.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_fields	5	\N	http://localhost:8055
28	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 02:21:07.659+00	172.23.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_fields	6	\N	http://localhost:8055
29	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 02:21:07.668+00	172.23.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_collections	comments	\N	http://localhost:8055
30	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 02:22:00.29+00	172.23.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_fields	7	\N	http://localhost:8055
31	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 02:22:42.949+00	172.23.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_fields	8	\N	http://localhost:8055
32	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 02:23:00.094+00	172.23.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_permissions	7	\N	http://localhost:8055
33	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 02:23:26.247+00	172.23.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	comments	1	\N	http://localhost:8055
34	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 02:24:07.196+00	172.23.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	comments	2	\N	http://localhost:8055
35	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 02:25:06.429+00	172.23.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	comments	3	\N	http://localhost:8055
36	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 03:02:38.795+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_fields	9	\N	http://localhost:8055
37	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 03:02:38.808+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_collections	description	\N	http://localhost:8055
38	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 03:02:59.557+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_fields	10	\N	http://localhost:8055
39	update	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 03:03:16.191+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_collections	description	\N	http://localhost:8055
41	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 03:04:17.134+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_fields	11	\N	http://localhost:8055
43	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 03:09:48.477+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_permissions	8	\N	http://localhost:8055
44	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 04:20:28.472+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_fields	12	\N	http://localhost:8055
45	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 04:20:28.481+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_collections	projects	\N	http://localhost:8055
46	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 04:20:40.361+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_fields	13	\N	http://localhost:8055
47	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 04:20:57.994+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_fields	14	\N	http://localhost:8055
48	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 04:21:57.207+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_fields	15	\N	http://localhost:8055
49	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 04:22:40.852+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_fields	16	\N	http://localhost:8055
50	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 04:25:05.998+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_fields	17	\N	http://localhost:8055
51	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 04:27:17.73+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	projects	1	\N	http://localhost:8055
52	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 04:29:01.965+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_permissions	9	\N	http://localhost:8055
53	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 04:34:46.772+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_fields	18	\N	http://localhost:8055
54	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 04:34:46.782+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_collections	languages	\N	http://localhost:8055
55	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 04:34:57.199+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_fields	19	\N	http://localhost:8055
56	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 04:35:10.87+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_fields	20	\N	http://localhost:8055
57	update	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 04:36:19.985+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_fields	15	\N	http://localhost:8055
58	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 04:38:56.725+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_fields	21	\N	http://localhost:8055
59	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 04:41:26.962+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	languages	1	\N	http://localhost:8055
60	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 04:44:27.312+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_permissions	10	\N	http://localhost:8055
61	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 15:52:18.898+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_fields	22	\N	http://localhost:8055
62	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 15:52:19.014+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_fields	23	\N	http://localhost:8055
63	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 15:52:19.023+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_collections	projects_languages	\N	http://localhost:8055
64	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 15:52:19.253+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_fields	24	\N	http://localhost:8055
65	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 15:52:19.369+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_fields	25	\N	http://localhost:8055
66	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 15:52:45.642+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	projects_languages	1	\N	http://localhost:8055
67	update	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 15:52:45.65+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	projects	1	\N	http://localhost:8055
68	update	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 15:53:03.956+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_collections	languages	\N	http://localhost:8055
69	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 16:09:31.562+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_permissions	11	\N	http://localhost:8055
70	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 16:19:37.29+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_fields	26	\N	http://localhost:8055
71	update	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 16:20:29.324+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	projects	1	\N	http://localhost:8055
72	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 16:48:12.24+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_fields	27	\N	http://localhost:8055
73	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 16:48:12.264+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_collections	links	\N	http://localhost:8055
74	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 16:48:23.278+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_fields	28	\N	http://localhost:8055
75	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 16:48:30.735+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_fields	29	\N	http://localhost:8055
76	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 16:48:53.493+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_fields	30	\N	http://localhost:8055
77	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 22:31:51.12+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_fields	31	\N	http://localhost:8055
78	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 22:32:23.639+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_fields	32	\N	http://localhost:8055
79	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 23:31:35.711+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_fields	33	\N	http://localhost:8055
80	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 23:31:35.843+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_fields	34	\N	http://localhost:8055
81	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 23:31:35.852+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_collections	projects_links	\N	http://localhost:8055
82	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 23:31:35.938+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_fields	35	\N	http://localhost:8055
84	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 23:35:57.18+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	links	1	\N	http://localhost:8055
85	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 23:35:57.186+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	projects_links	1	\N	http://localhost:8055
86	update	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 23:35:57.193+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	projects	1	\N	http://localhost:8055
83	create	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 23:31:36.061+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_fields	36	\N	http://localhost:8055
87	update	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 23:36:18.958+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_collections	links	\N	http://localhost:8055
88	update	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 23:40:00.946+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_collections	links	\N	http://localhost:8055
89	update	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 23:40:35.672+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_collections	links	\N	http://localhost:8055
90	update	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 23:52:51.787+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	projects	1	\N	http://localhost:8055
91	update	a5813e40-3394-40b1-8143-74e680638c71	2022-11-29 23:53:35.62+00	172.24.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	projects	1	\N	http://localhost:8055
92	login	a5813e40-3394-40b1-8143-74e680638c71	2022-12-07 22:11:20.591+00	172.25.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0	directus_users	a5813e40-3394-40b1-8143-74e680638c71	\N	http://localhost:8055
93	login	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 15:27:37.791+00	172.25.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_users	a5813e40-3394-40b1-8143-74e680638c71	\N	http://localhost:8055
94	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 15:29:55.32+00	172.25.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	37	\N	http://localhost:8055
95	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 15:29:55.336+00	172.25.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_collections	Profile	\N	http://localhost:8055
96	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 15:30:46.481+00	172.25.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	38	\N	http://localhost:8055
97	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 15:31:20.385+00	172.25.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	39	\N	http://localhost:8055
98	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 15:31:44.137+00	172.25.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	40	\N	http://localhost:8055
99	delete	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 15:38:16.994+00	172.25.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_collections	Profile	\N	http://localhost:8055
100	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 15:38:25.212+00	172.25.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	41	\N	http://localhost:8055
101	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 15:38:25.228+00	172.25.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_collections	profile	\N	http://localhost:8055
102	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 15:38:39.127+00	172.25.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	42	\N	http://localhost:8055
103	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 15:38:54.535+00	172.25.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	43	\N	http://localhost:8055
104	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 15:39:09.893+00	172.25.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	44	\N	http://localhost:8055
105	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 15:58:57.907+00	172.25.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	profile	1	\N	http://localhost:8055
106	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 16:04:04.26+00	172.25.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	45	\N	http://localhost:8055
107	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 16:05:35.546+00	172.25.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_files	a59de36c-0cd7-4c6f-8b12-6457cc407f27	\N	http://localhost:8055
108	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 16:05:44.812+00	172.25.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_files	d3eee8d9-f8c7-44aa-b274-5cf418101d70	\N	http://localhost:8055
109	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 16:08:08.33+00	172.25.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_files	78f2ccc0-3c21-4f0b-9dda-7a315f52a893	\N	http://localhost:8055
110	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 16:08:16.779+00	172.25.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_files	63466c88-2422-4b43-93f9-13eada1bcf45	\N	http://localhost:8055
111	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 16:12:02.106+00	172.25.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_files	044828b5-84c8-4380-9f37-e303f429d35d	\N	http://localhost:8055
112	update	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 16:16:50.006+00	172.25.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	profile	1	\N	http://localhost:8055
113	delete	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 16:17:35.023+00	172.25.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_files	63466c88-2422-4b43-93f9-13eada1bcf45	\N	http://localhost:8055
114	delete	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 16:17:35.025+00	172.25.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_files	78f2ccc0-3c21-4f0b-9dda-7a315f52a893	\N	http://localhost:8055
115	delete	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 16:17:35.027+00	172.25.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_files	d3eee8d9-f8c7-44aa-b274-5cf418101d70	\N	http://localhost:8055
116	delete	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 16:17:35.028+00	172.25.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_files	a59de36c-0cd7-4c6f-8b12-6457cc407f27	\N	http://localhost:8055
117	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 16:18:01.558+00	172.25.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_permissions	12	\N	http://localhost:8055
118	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 16:56:37.221+00	172.25.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_permissions	13	\N	http://localhost:8055
119	login	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 16:59:59.816+00	172.25.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_users	a5813e40-3394-40b1-8143-74e680638c71	\N	http://localhost:8055
120	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 17:03:49.498+00	172.25.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_permissions	14	\N	http://localhost:8055
121	delete	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 17:04:51.676+00	172.25.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_permissions	14	\N	http://localhost:8055
122	delete	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 17:06:06.211+00	172.25.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_permissions	13	\N	http://localhost:8055
123	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 17:06:16.819+00	172.25.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_permissions	15	\N	http://localhost:8055
124	delete	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 17:08:05.894+00	172.25.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_permissions	15	\N	http://localhost:8055
125	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 17:10:45.136+00	172.25.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_permissions	16	\N	http://localhost:8055
126	delete	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 17:10:51.388+00	172.25.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_permissions	16	\N	http://localhost:8055
127	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 17:10:58.164+00	172.25.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_permissions	17	\N	http://localhost:8055
128	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 17:11:02.603+00	172.25.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_permissions	18	\N	http://localhost:8055
129	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 17:11:02.655+00	172.25.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_permissions	19	\N	http://localhost:8055
130	update	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 17:11:02.663+00	172.25.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_permissions	17	\N	http://localhost:8055
131	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 17:11:02.674+00	172.25.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_permissions	20	\N	http://localhost:8055
132	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 17:11:02.68+00	172.25.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_permissions	21	\N	http://localhost:8055
133	delete	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 17:11:03.937+00	172.25.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_permissions	17	\N	http://localhost:8055
134	delete	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 17:11:03.939+00	172.25.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_permissions	18	\N	http://localhost:8055
135	delete	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 17:11:03.94+00	172.25.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_permissions	19	\N	http://localhost:8055
136	delete	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 17:11:03.941+00	172.25.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_permissions	20	\N	http://localhost:8055
137	delete	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 17:11:03.943+00	172.25.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_permissions	21	\N	http://localhost:8055
138	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 17:11:05.996+00	172.25.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_permissions	22	\N	http://localhost:8055
139	login	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 17:14:12.651+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_users	a5813e40-3394-40b1-8143-74e680638c71	\N	http://localhost:8055
140	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 17:14:31.038+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_permissions	23	\N	http://localhost:8055
141	update	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 17:14:31.064+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_permissions	22	\N	http://localhost:8055
142	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 17:14:31.065+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_permissions	24	\N	http://localhost:8055
143	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 17:14:31.072+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_permissions	25	\N	http://localhost:8055
144	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 17:14:31.087+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_permissions	26	\N	http://localhost:8055
145	delete	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 17:14:47.393+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_permissions	25	\N	http://localhost:8055
146	delete	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 17:14:49.084+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_permissions	24	\N	http://localhost:8055
147	delete	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 17:14:50.699+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_permissions	23	\N	http://localhost:8055
148	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 17:16:38.733+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_files	03c8d29d-fc5a-429b-9299-60eb7fcb8a51	\N	http://localhost:8055
149	update	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 17:16:41.682+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	profile	1	\N	http://localhost:8055
150	update	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 18:39:30.196+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	profile	1	\N	http://localhost:8055
151	update	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 18:40:09.991+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	44	\N	http://localhost:8055
152	update	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 18:50:23.962+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	profile	1	\N	http://localhost:8055
153	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 19:06:14.605+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	46	\N	http://localhost:8055
154	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 19:06:53.125+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_files	2f3e0031-ff85-4ad1-911c-fe3a2b9a65b1	\N	http://localhost:8055
155	update	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 19:06:54.72+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	languages	1	\N	http://localhost:8055
156	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 19:30:04.493+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	47	\N	http://localhost:8055
157	update	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 19:33:22.885+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	projects	1	\N	http://localhost:8055
158	update	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 20:04:15.417+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	projects	1	\N	http://localhost:8055
159	update	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 20:05:27.639+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	projects	1	\N	http://localhost:8055
160	update	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 20:40:58.157+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	projects	1	\N	http://localhost:8055
161	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 20:47:34.364+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	48	\N	http://localhost:8055
162	update	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 20:49:09.13+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	languages	1	\N	http://localhost:8055
163	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 20:51:33.348+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	49	\N	http://localhost:8055
164	update	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 20:52:00.081+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	projects	1	\N	http://localhost:8055
165	update	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 20:53:01.645+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	projects	1	\N	http://localhost:8055
166	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 20:56:31.453+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_files	ab83e718-aa4a-4c88-bc19-f7514c32eef9	\N	http://localhost:8055
167	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 20:56:46.664+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	languages	2	\N	http://localhost:8055
168	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 20:57:45.252+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_files	7b39f430-ce41-40a9-aec8-ffe5d849b0bb	\N	http://localhost:8055
169	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 20:57:53.121+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	languages	3	\N	http://localhost:8055
170	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 20:58:17.399+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_files	85670c85-30d0-4ba7-a19e-8cbde6b11d09	\N	http://localhost:8055
171	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 20:58:30.233+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	languages	4	\N	http://localhost:8055
172	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 20:58:53.876+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	projects_languages	2	\N	http://localhost:8055
173	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 20:58:53.882+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	projects_languages	3	\N	http://localhost:8055
174	update	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 20:58:53.891+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	projects	1	\N	http://localhost:8055
175	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 21:02:40.807+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	projects	2	\N	http://localhost:8055
176	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 21:09:57.982+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	projects_languages	4	\N	http://localhost:8055
177	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 21:09:57.988+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	projects_languages	5	\N	http://localhost:8055
178	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 21:09:57.995+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	projects_languages	6	\N	http://localhost:8055
179	update	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 21:09:58+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	projects	2	\N	http://localhost:8055
180	update	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 21:14:01.78+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	projects	1	\N	http://localhost:8055
181	update	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 21:14:16.353+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	projects	1	\N	http://localhost:8055
182	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 21:18:02.273+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	projects_languages	7	\N	http://localhost:8055
183	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 21:18:02.282+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	projects_languages	8	\N	http://localhost:8055
184	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 21:18:02.288+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	projects_languages	9	\N	http://localhost:8055
185	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 21:18:02.292+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	projects	3	\N	http://localhost:8055
186	update	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 21:20:19.562+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	projects	3	\N	http://localhost:8055
187	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 21:47:08.051+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	50	\N	http://localhost:8055
188	update	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 21:47:52.169+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	profile	1	\N	http://localhost:8055
189	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 21:57:38.532+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	51	\N	http://localhost:8055
190	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 21:57:58.059+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	52	\N	http://localhost:8055
191	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 22:01:45.973+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	53	\N	http://localhost:8055
192	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 22:08:19.301+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	54	\N	http://localhost:8055
193	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 22:45:48.263+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	55	\N	http://localhost:8055
194	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 22:45:48.27+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_collections	lang	\N	http://localhost:8055
195	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 22:46:12.847+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	56	\N	http://localhost:8055
196	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 22:46:27.613+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	lang	en	\N	http://localhost:8055
197	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 22:46:35.358+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	lang	fr	\N	http://localhost:8055
198	delete	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 22:47:41.759+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_collections	description	\N	http://localhost:8055
199	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 22:48:22.078+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	57	\N	http://localhost:8055
200	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 22:48:22.084+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_collections	profile_translation	\N	http://localhost:8055
201	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 22:49:24.475+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	58	\N	http://localhost:8055
202	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 22:49:53.742+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	59	\N	http://localhost:8055
203	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 22:50:17.887+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	60	\N	http://localhost:8055
208	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 22:51:48.918+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	64	\N	http://localhost:8055
210	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 22:53:03.106+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	66	\N	http://localhost:8055
211	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 22:53:03.115+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_collections	profile_translation_translations_1	\N	http://localhost:8055
212	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 22:53:03.192+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	67	\N	http://localhost:8055
204	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 22:51:48.538+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	61	\N	http://localhost:8055
205	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 22:51:48.679+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	62	\N	http://localhost:8055
206	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 22:51:48.687+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_collections	profile_translation_translations	\N	http://localhost:8055
207	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 22:51:48.767+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	63	\N	http://localhost:8055
209	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 22:53:02.988+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	65	\N	http://localhost:8055
213	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 22:53:03.285+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	68	\N	http://localhost:8055
214	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 22:57:23.592+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	69	\N	http://localhost:8055
215	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 22:57:23.762+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	70	\N	http://localhost:8055
216	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 22:57:23.773+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_collections	profile_translations	\N	http://localhost:8055
217	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 22:57:23.932+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	71	\N	http://localhost:8055
218	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 22:57:24.038+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	72	\N	http://localhost:8055
219	update	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 23:11:05.759+00	172.22.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_collections	profile	\N	http://localhost:8055
223	update	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 23:16:14.497+00	172.22.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_collections	profile	\N	http://localhost:8055
224	update	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 23:22:00.535+00	172.22.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_collections	profile	\N	http://localhost:8055
225	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 23:25:34.73+00	172.22.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	73	\N	http://localhost:8055
226	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 23:25:34.879+00	172.22.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	74	\N	http://localhost:8055
227	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 23:25:34.885+00	172.22.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_collections	profile_translations_1	\N	http://localhost:8055
228	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 23:25:34.966+00	172.22.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	75	\N	http://localhost:8055
229	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 23:25:35.09+00	172.22.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	76	\N	http://localhost:8055
230	delete	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 23:46:32.178+00	172.22.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_collections	profile_translation	\N	http://localhost:8055
231	delete	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 23:46:37.241+00	172.22.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_collections	profile_translation_translations	\N	http://localhost:8055
232	delete	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 23:46:40.691+00	172.22.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_collections	profile_translation_translations_1	\N	http://localhost:8055
233	delete	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 23:46:44.3+00	172.22.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_collections	profile_translations	\N	http://localhost:8055
234	delete	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 23:46:47.43+00	172.22.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_collections	profile_translations_1	\N	http://localhost:8055
235	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 23:48:22.528+00	172.22.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	77	\N	http://localhost:8055
236	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 23:48:22.673+00	172.22.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	78	\N	http://localhost:8055
237	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 23:48:22.682+00	172.22.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_collections	profile_translations	\N	http://localhost:8055
238	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 23:48:22.789+00	172.22.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	79	\N	http://localhost:8055
239	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 23:48:22.9+00	172.22.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	80	\N	http://localhost:8055
240	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 23:49:11.232+00	172.22.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	81	\N	http://localhost:8055
241	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 23:50:59.344+00	172.22.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	82	\N	http://localhost:8055
242	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 23:51:07.808+00	172.22.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	83	\N	http://localhost:8055
243	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 23:52:15.894+00	172.22.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	84	\N	http://localhost:8055
244	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 23:53:31.456+00	172.22.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_fields	85	\N	http://localhost:8055
245	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 23:53:36.739+00	172.22.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	profile_translations	1	\N	http://localhost:8055
246	update	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 23:53:36.745+00	172.22.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	profile	1	\N	http://localhost:8055
247	update	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 23:53:55.652+00	172.22.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	profile_translations	1	\N	http://localhost:8055
248	update	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 23:53:55.659+00	172.22.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	profile	1	\N	http://localhost:8055
249	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 23:54:38.718+00	172.22.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	profile_translations	2	\N	http://localhost:8055
250	update	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 23:54:38.727+00	172.22.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	profile	1	\N	http://localhost:8055
251	update	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 23:56:48.742+00	172.22.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_collections	profile_translations	\N	http://localhost:8055
252	update	a5813e40-3394-40b1-8143-74e680638c71	2023-01-10 00:01:04.43+00	172.22.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_collections	profile	\N	http://localhost:8055
253	create	a5813e40-3394-40b1-8143-74e680638c71	2023-01-10 00:16:11.738+00	172.22.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0	directus_permissions	27	\N	http://localhost:8055
254	login	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 17:15:29.3+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_users	a5813e40-3394-40b1-8143-74e680638c71	\N	http://localhost:8055
255	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 17:47:05.55+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	86	\N	http://localhost:8055
256	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 17:47:05.561+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	87	\N	http://localhost:8055
257	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 17:47:05.568+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	88	\N	http://localhost:8055
258	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 17:47:05.579+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_section	\N	http://localhost:8055
259	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 17:47:50.73+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	89	\N	http://localhost:8055
260	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 17:48:09.839+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	90	\N	http://localhost:8055
261	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 17:48:09.851+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	91	\N	http://localhost:8055
262	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 17:48:09.863+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	92	\N	http://localhost:8055
263	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 17:48:09.873+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_section_item	\N	http://localhost:8055
264	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 17:48:58.705+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	93	\N	http://localhost:8055
265	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 17:50:14.695+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	94	\N	http://localhost:8055
266	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 17:50:25.383+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	95	\N	http://localhost:8055
267	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 17:50:35.894+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	96	\N	http://localhost:8055
268	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 17:52:50.218+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	97	\N	http://localhost:8055
269	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 17:52:50.373+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	98	\N	http://localhost:8055
270	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 17:52:50.38+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_translations	\N	http://localhost:8055
271	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 17:52:50.469+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	99	\N	http://localhost:8055
272	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 17:52:50.568+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	100	\N	http://localhost:8055
273	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 17:54:07.686+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	97	\N	http://localhost:8055
274	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 17:56:29.871+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	101	\N	http://localhost:8055
275	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 17:56:29.879+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_translation	\N	http://localhost:8055
276	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 17:57:40.31+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	102	\N	http://localhost:8055
277	delete	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 17:58:02.828+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_translation	\N	http://localhost:8055
278	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:01:39.923+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	103	\N	http://localhost:8055
279	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:01:40.096+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	104	\N	http://localhost:8055
280	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:01:40.104+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_translations_1	\N	http://localhost:8055
281	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:01:40.201+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	105	\N	http://localhost:8055
282	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:01:40.34+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	106	\N	http://localhost:8055
283	delete	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:01:56.074+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_translations_1	\N	http://localhost:8055
284	delete	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:02:02.332+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_translations	\N	http://localhost:8055
285	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:02:32.949+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	107	\N	http://localhost:8055
286	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:02:33.07+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	108	\N	http://localhost:8055
287	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:02:33.077+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_translations	\N	http://localhost:8055
288	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:02:33.162+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	109	\N	http://localhost:8055
290	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:02:48.816+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_translations	\N	http://localhost:8055
291	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:02:53.509+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	comments	\N	http://localhost:8055
292	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:02:53.517+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	lang	\N	http://localhost:8055
293	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:02:53.525+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	languages	\N	http://localhost:8055
294	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:02:53.531+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	links	\N	http://localhost:8055
295	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:02:53.54+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile	\N	http://localhost:8055
296	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:02:53.548+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_section	\N	http://localhost:8055
297	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:02:53.557+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_section_item	\N	http://localhost:8055
298	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:02:53.566+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_translations	\N	http://localhost:8055
299	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:02:53.575+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_languages	\N	http://localhost:8055
300	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:02:53.586+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_links	\N	http://localhost:8055
301	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:02:53.594+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_translations	\N	http://localhost:8055
302	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:02:53.602+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects	\N	http://localhost:8055
304	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:00.283+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	comments	\N	http://localhost:8055
305	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:00.296+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	lang	\N	http://localhost:8055
306	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:00.305+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	languages	\N	http://localhost:8055
307	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:00.315+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	links	\N	http://localhost:8055
308	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:00.329+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile	\N	http://localhost:8055
309	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:00.341+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_section	\N	http://localhost:8055
310	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:00.361+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_section_item	\N	http://localhost:8055
311	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:00.369+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_languages	\N	http://localhost:8055
312	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:00.38+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_links	\N	http://localhost:8055
313	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:00.387+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_translations	\N	http://localhost:8055
314	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:00.396+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects	\N	http://localhost:8055
289	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:02:33.368+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	110	\N	http://localhost:8055
303	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:00.283+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_translations	\N	http://localhost:8055
315	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:03.022+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	comments	\N	http://localhost:8055
316	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:03.03+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	lang	\N	http://localhost:8055
317	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:03.036+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	languages	\N	http://localhost:8055
318	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:03.044+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	links	\N	http://localhost:8055
319	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:03.054+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_translations	\N	http://localhost:8055
320	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:03.062+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile	\N	http://localhost:8055
321	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:03.071+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_section	\N	http://localhost:8055
322	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:03.083+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_section_item	\N	http://localhost:8055
323	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:03.094+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_languages	\N	http://localhost:8055
324	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:03.1+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_links	\N	http://localhost:8055
325	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:03.11+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_translations	\N	http://localhost:8055
326	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:03.116+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects	\N	http://localhost:8055
327	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:06.738+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	comments	\N	http://localhost:8055
328	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:06.753+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	lang	\N	http://localhost:8055
329	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:06.774+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	languages	\N	http://localhost:8055
330	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:06.809+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	links	\N	http://localhost:8055
331	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:06.86+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile	\N	http://localhost:8055
332	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:06.874+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_translations	\N	http://localhost:8055
333	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:06.885+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_section	\N	http://localhost:8055
334	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:06.896+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_section_item	\N	http://localhost:8055
335	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:06.907+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_languages	\N	http://localhost:8055
336	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:06.921+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_links	\N	http://localhost:8055
337	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:06.932+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_translations	\N	http://localhost:8055
338	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:06.945+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects	\N	http://localhost:8055
339	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:15.214+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_translations	\N	http://localhost:8055
340	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:15.216+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	comments	\N	http://localhost:8055
341	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:15.241+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	lang	\N	http://localhost:8055
342	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:15.279+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	languages	\N	http://localhost:8055
343	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:15.318+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	links	\N	http://localhost:8055
344	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:15.326+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile	\N	http://localhost:8055
345	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:15.334+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_section	\N	http://localhost:8055
346	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:15.341+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_section_item	\N	http://localhost:8055
347	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:15.353+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_languages	\N	http://localhost:8055
348	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:15.362+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_links	\N	http://localhost:8055
349	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:15.374+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_translations	\N	http://localhost:8055
350	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:15.389+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects	\N	http://localhost:8055
352	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:18.669+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	comments	\N	http://localhost:8055
353	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:18.681+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	lang	\N	http://localhost:8055
354	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:18.69+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	languages	\N	http://localhost:8055
355	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:18.7+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	links	\N	http://localhost:8055
356	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:18.773+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile	\N	http://localhost:8055
357	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:18.788+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_section_item	\N	http://localhost:8055
358	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:18.797+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_languages	\N	http://localhost:8055
359	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:18.804+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_links	\N	http://localhost:8055
360	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:18.815+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_translations	\N	http://localhost:8055
361	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:18.823+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects	\N	http://localhost:8055
363	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:23.207+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	comments	\N	http://localhost:8055
364	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:23.217+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	lang	\N	http://localhost:8055
366	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:23.231+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	languages	\N	http://localhost:8055
367	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:23.243+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	links	\N	http://localhost:8055
368	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:23.253+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile	\N	http://localhost:8055
369	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:23.266+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_languages	\N	http://localhost:8055
370	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:23.292+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_links	\N	http://localhost:8055
371	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:23.307+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_translations	\N	http://localhost:8055
372	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:23.335+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects	\N	http://localhost:8055
423	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:25.345+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	comments	\N	http://localhost:8055
424	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:25.352+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	lang	\N	http://localhost:8055
425	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:25.36+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	languages	\N	http://localhost:8055
426	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:25.367+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	links	\N	http://localhost:8055
427	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:25.376+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile	\N	http://localhost:8055
428	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:25.383+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_translations	\N	http://localhost:8055
429	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:25.391+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_languages	\N	http://localhost:8055
430	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:25.41+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_links	\N	http://localhost:8055
431	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:25.439+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects	\N	http://localhost:8055
442	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:32.557+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	comments	\N	http://localhost:8055
443	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:32.567+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	lang	\N	http://localhost:8055
444	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:32.574+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	languages	\N	http://localhost:8055
445	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:32.583+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	links	\N	http://localhost:8055
446	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:32.591+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile	\N	http://localhost:8055
447	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:32.609+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects	\N	http://localhost:8055
448	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:32.653+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_languages	\N	http://localhost:8055
449	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:32.667+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_links	\N	http://localhost:8055
351	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:18.668+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_section	\N	http://localhost:8055
362	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:23.206+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_section_item	\N	http://localhost:8055
365	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:23.218+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_translations	\N	http://localhost:8055
373	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:27.007+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	comments	\N	http://localhost:8055
374	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:27.014+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	lang	\N	http://localhost:8055
375	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:27.025+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	languages	\N	http://localhost:8055
376	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:27.033+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	links	\N	http://localhost:8055
377	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:27.042+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_section	\N	http://localhost:8055
378	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:27.051+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile	\N	http://localhost:8055
379	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:27.058+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_languages	\N	http://localhost:8055
380	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:27.065+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_links	\N	http://localhost:8055
381	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:27.073+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_translations	\N	http://localhost:8055
382	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:27.08+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects	\N	http://localhost:8055
383	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:43.017+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	comments	\N	http://localhost:8055
384	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:43.018+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_translations	\N	http://localhost:8055
385	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:43.026+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	lang	\N	http://localhost:8055
386	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:43.035+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	languages	\N	http://localhost:8055
387	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:43.049+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	links	\N	http://localhost:8055
388	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:43.062+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_section_item	\N	http://localhost:8055
389	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:43.094+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_section	\N	http://localhost:8055
390	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:43.104+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile	\N	http://localhost:8055
391	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:43.112+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_languages	\N	http://localhost:8055
392	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:43.121+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_links	\N	http://localhost:8055
393	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:43.129+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_translations	\N	http://localhost:8055
394	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:43.137+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects	\N	http://localhost:8055
395	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:52.575+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_section	\N	http://localhost:8055
396	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:52.579+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	comments	\N	http://localhost:8055
397	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:52.594+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_translations	\N	http://localhost:8055
398	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:52.595+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	lang	\N	http://localhost:8055
399	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:52.607+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	languages	\N	http://localhost:8055
400	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:52.62+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	links	\N	http://localhost:8055
401	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:52.636+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_section_item	\N	http://localhost:8055
402	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:52.659+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile	\N	http://localhost:8055
403	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:52.668+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_languages	\N	http://localhost:8055
404	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:52.676+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_links	\N	http://localhost:8055
405	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:52.685+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_translations	\N	http://localhost:8055
406	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:52.694+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects	\N	http://localhost:8055
407	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:59.956+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_section_item	\N	http://localhost:8055
421	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:18.972+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_translations	\N	http://localhost:8055
422	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:18.984+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_section	\N	http://localhost:8055
432	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:29.151+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	comments	\N	http://localhost:8055
433	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:29.162+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	lang	\N	http://localhost:8055
434	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:29.173+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	languages	\N	http://localhost:8055
435	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:29.185+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	links	\N	http://localhost:8055
436	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:29.213+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile	\N	http://localhost:8055
437	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:29.232+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects	\N	http://localhost:8055
438	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:29.25+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_translations	\N	http://localhost:8055
439	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:29.277+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_languages	\N	http://localhost:8055
440	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:29.284+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_links	\N	http://localhost:8055
408	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:59.956+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	comments	\N	http://localhost:8055
409	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:59.969+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	lang	\N	http://localhost:8055
410	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:59.976+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	languages	\N	http://localhost:8055
411	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:59.985+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	links	\N	http://localhost:8055
412	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:03:59.993+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile	\N	http://localhost:8055
413	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:00.02+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_languages	\N	http://localhost:8055
414	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:00.028+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_links	\N	http://localhost:8055
415	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:00.037+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_translations	\N	http://localhost:8055
416	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:00.044+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects	\N	http://localhost:8055
417	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:03.627+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile	\N	http://localhost:8055
418	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:05.088+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile	\N	http://localhost:8055
419	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:08.112+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile	\N	http://localhost:8055
420	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:09.736+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile	\N	http://localhost:8055
441	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:32.556+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_translations	\N	http://localhost:8055
450	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:34.683+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_languages	\N	http://localhost:8055
452	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:34.693+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_translations	\N	http://localhost:8055
459	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:39.802+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_links	\N	http://localhost:8055
461	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:39.813+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_languages	\N	http://localhost:8055
464	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:39.828+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_translations	\N	http://localhost:8055
451	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:34.683+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	comments	\N	http://localhost:8055
453	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:34.693+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	lang	\N	http://localhost:8055
454	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:34.702+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	languages	\N	http://localhost:8055
455	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:34.711+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	links	\N	http://localhost:8055
456	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:34.723+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile	\N	http://localhost:8055
457	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:34.732+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects	\N	http://localhost:8055
458	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:34.751+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_links	\N	http://localhost:8055
460	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:39.804+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	comments	\N	http://localhost:8055
462	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:39.814+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	lang	\N	http://localhost:8055
463	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:39.827+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	languages	\N	http://localhost:8055
465	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:39.837+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	links	\N	http://localhost:8055
466	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:39.846+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile	\N	http://localhost:8055
467	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:04:39.855+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects	\N	http://localhost:8055
468	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:06:35.828+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	111	\N	http://localhost:8055
469	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:07:07.241+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	112	\N	http://localhost:8055
470	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:07:44.134+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	projects_translations	1	\N	http://localhost:8055
471	delete	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:09:53.621+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	projects_translations	1	\N	http://localhost:8055
472	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:10:20.465+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	projects_translations	2	\N	http://localhost:8055
473	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:10:20.471+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	projects	1	\N	http://localhost:8055
474	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:11:26.205+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	projects_translations	3	\N	http://localhost:8055
475	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 18:11:26.21+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	projects	1	\N	http://localhost:8055
476	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 21:31:05.564+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	projects_translations	4	\N	http://localhost:8055
477	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 21:31:05.57+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	projects_translations	5	\N	http://localhost:8055
478	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 21:31:05.576+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	projects	2	\N	http://localhost:8055
479	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 21:32:13.639+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	projects_translations	6	\N	http://localhost:8055
480	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 21:32:13.646+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	projects_translations	7	\N	http://localhost:8055
481	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 21:32:13.652+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	projects	3	\N	http://localhost:8055
482	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 21:37:55.205+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_permissions	28	\N	http://localhost:8055
483	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 21:52:27.121+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	113	\N	http://localhost:8055
484	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 21:55:14.669+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	114	\N	http://localhost:8055
485	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 21:55:43.941+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	115	\N	http://localhost:8055
486	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 21:55:52.923+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	115	\N	http://localhost:8055
487	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 21:57:17.726+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	116	\N	http://localhost:8055
488	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 21:58:23.687+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	117	\N	http://localhost:8055
489	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 22:01:45.602+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	118	\N	http://localhost:8055
490	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 22:02:35.667+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	119	\N	http://localhost:8055
491	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 22:04:09.064+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	120	\N	http://localhost:8055
492	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 22:04:45.185+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	121	\N	http://localhost:8055
493	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-20 22:04:57.259+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_section	\N	http://localhost:8055
494	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:00:32.084+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_files	dc446a36-ac14-4e6c-a463-71added7d9a2	\N	http://localhost:8055
495	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:04:36.217+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_files	0855e668-4b07-4373-8c76-ff744057f860	\N	http://localhost:8055
496	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:05:45.5+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_files	4acac7d6-e615-4e74-8a16-859a83a1f1fc	\N	http://localhost:8055
497	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:11:08.014+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_files	15794a77-6d4b-436f-8626-a40a24d36da1	\N	http://localhost:8055
498	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:12:14.79+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_files	90f06a4a-caff-4d70-a59e-64f5b61cee7e	\N	http://localhost:8055
499	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:19:50.33+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	profile_section_item	1	\N	http://localhost:8055
500	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:19:50.339+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	profile_section_item	2	\N	http://localhost:8055
501	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:19:50.343+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	profile_section_item	3	\N	http://localhost:8055
502	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:19:50.351+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	profile_section_item	4	\N	http://localhost:8055
503	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:19:50.355+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	profile_section	1	\N	http://localhost:8055
504	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:24:36.275+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	122	\N	http://localhost:8055
505	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:24:36.475+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	123	\N	http://localhost:8055
506	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:24:36.484+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_section_item_translations	\N	http://localhost:8055
507	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:24:36.596+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	124	\N	http://localhost:8055
508	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:24:36.732+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	125	\N	http://localhost:8055
509	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:25:01.297+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_section_item_translations	\N	http://localhost:8055
510	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:25:08.954+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_permissions	29	\N	http://localhost:8055
511	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:25:18.467+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_section_item	\N	http://localhost:8055
512	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:25:18.469+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	comments	\N	http://localhost:8055
513	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:25:18.485+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_section_item_translations	\N	http://localhost:8055
514	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:25:18.486+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	lang	\N	http://localhost:8055
515	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:25:18.497+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	languages	\N	http://localhost:8055
516	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:25:18.508+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	links	\N	http://localhost:8055
517	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:25:18.518+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile	\N	http://localhost:8055
518	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:25:18.558+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects	\N	http://localhost:8055
519	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:26:20.354+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	126	\N	http://localhost:8055
520	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:26:30.759+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	127	\N	http://localhost:8055
521	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:28:37.162+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	profile_section_item_translations	1	\N	http://localhost:8055
522	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:28:37.167+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	profile_section_item	1	\N	http://localhost:8055
523	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:31:07.275+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	profile_section_item_translations	2	\N	http://localhost:8055
524	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:31:07.294+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	profile_section_item_translations	3	\N	http://localhost:8055
525	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:31:07.309+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	profile_section_item	2	\N	http://localhost:8055
526	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:32:18.394+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	profile_section_item_translations	4	\N	http://localhost:8055
527	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:32:18.398+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	profile_section_item	3	\N	http://localhost:8055
528	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:33:13.052+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	profile_section_item_translations	5	\N	http://localhost:8055
529	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:33:13.065+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	profile_section_item	3	\N	http://localhost:8055
530	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:33:38.519+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	profile_section_item_translations	6	\N	http://localhost:8055
531	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:33:38.53+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	profile_section_item	4	\N	http://localhost:8055
532	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:34:43.181+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_permissions	30	\N	http://localhost:8055
533	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:34:44.8+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_permissions	31	\N	http://localhost:8055
537	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:46:13.971+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	128	\N	http://localhost:8055
541	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:46:14.381+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	131	\N	http://localhost:8055
534	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:44:22.059+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_permissions	32	\N	http://localhost:8055
535	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:44:24.449+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_permissions	33	\N	http://localhost:8055
536	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:44:28.254+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_permissions	34	\N	http://localhost:8055
538	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:46:14.142+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	129	\N	http://localhost:8055
539	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:46:14.153+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_section_translations	\N	http://localhost:8055
540	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:46:14.257+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	130	\N	http://localhost:8055
542	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:46:34.353+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_section_translations	\N	http://localhost:8055
543	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:46:42.767+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_section_translations	\N	http://localhost:8055
544	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:46:42.771+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	comments	\N	http://localhost:8055
545	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:46:42.787+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	lang	\N	http://localhost:8055
546	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:46:42.788+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_section_item	\N	http://localhost:8055
547	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:46:42.804+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	languages	\N	http://localhost:8055
548	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:46:42.806+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_section_item_translations	\N	http://localhost:8055
549	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:46:42.822+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	links	\N	http://localhost:8055
550	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:46:42.843+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile	\N	http://localhost:8055
551	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:46:42.862+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects	\N	http://localhost:8055
552	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:47:11.123+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	132	\N	http://localhost:8055
555	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:47:54.017+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	profile_section	1	\N	http://localhost:8055
556	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 01:01:42.222+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_section	\N	http://localhost:8055
557	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 01:02:33.947+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_section_item	\N	http://localhost:8055
558	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 01:02:55.688+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_section_item_translations	\N	http://localhost:8055
559	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 01:03:17.177+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_translations	\N	http://localhost:8055
560	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 01:03:52.942+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_section_translations	\N	http://localhost:8055
561	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 01:04:10.505+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_translations	\N	http://localhost:8055
562	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 01:05:41.326+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	profile_section_item	1	\N	http://localhost:8055
563	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 01:05:41.333+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	profile_section	1	\N	http://localhost:8055
564	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 01:19:00.212+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_section	\N	http://localhost:8055
565	delete	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 01:19:20.67+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_section_translations	\N	http://localhost:8055
566	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 01:19:33.577+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	133	\N	http://localhost:8055
567	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 01:19:33.732+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	134	\N	http://localhost:8055
568	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 01:19:33.739+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_section_translations	\N	http://localhost:8055
569	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 01:19:33.82+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	135	\N	http://localhost:8055
570	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 01:19:33.915+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	136	\N	http://localhost:8055
571	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 01:20:02.272+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	137	\N	http://localhost:8055
572	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 01:20:27.025+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	profile_section_translations	1	\N	http://localhost:8055
573	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 01:20:27.032+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	profile_section_translations	2	\N	http://localhost:8055
574	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 01:20:27.036+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	profile_section	1	\N	http://localhost:8055
575	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 01:21:41.235+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	138	\N	http://localhost:8055
576	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 01:21:52.632+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	profile_section	1	\N	http://localhost:8055
577	login	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 00:32:24.723+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_users	a5813e40-3394-40b1-8143-74e680638c71	\N	http://localhost:8055
578	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 01:20:45.135+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_files	b8117a85-157b-49a7-b67b-63a5276e0d42	\N	http://localhost:8055
579	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 01:21:08.244+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_files	c8a18cac-14da-47e3-81aa-686640d35ae7	\N	http://localhost:8055
580	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 01:22:51.077+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	profile_section_item_translations	7	\N	http://localhost:8055
581	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 01:22:51.085+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	profile_section_item_translations	8	\N	http://localhost:8055
582	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 01:22:51.092+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	profile_section_item	5	\N	http://localhost:8055
583	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 01:22:51.105+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	profile_section_item_translations	9	\N	http://localhost:8055
584	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 01:22:51.111+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	profile_section_item	6	\N	http://localhost:8055
585	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 01:22:51.121+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	profile_section	2	\N	http://localhost:8055
586	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 01:51:16.278+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	139	\N	http://localhost:8055
587	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 01:51:16.289+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	formations	\N	http://localhost:8055
588	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 01:51:49.558+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	140	\N	http://localhost:8055
589	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 01:51:58.575+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	141	\N	http://localhost:8055
590	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 01:52:21.413+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	142	\N	http://localhost:8055
591	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 01:52:52.095+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	143	\N	http://localhost:8055
592	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 01:54:34.443+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	144	\N	http://localhost:8055
593	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 10:25:14.305+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	145	\N	http://localhost:8055
594	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 10:27:17.127+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	146	\N	http://localhost:8055
595	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 10:27:17.296+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	147	\N	http://localhost:8055
596	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 10:27:17.303+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	formations_translations	\N	http://localhost:8055
597	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 10:27:17.379+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	148	\N	http://localhost:8055
598	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 10:27:17.483+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	149	\N	http://localhost:8055
599	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 10:27:53.307+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	150	\N	http://localhost:8055
600	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 10:28:18.69+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	151	\N	http://localhost:8055
601	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 10:31:04.097+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	152	\N	http://localhost:8055
602	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 10:49:44.658+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_permissions	35	\N	http://localhost:8055
603	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 10:49:52.429+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_permissions	36	\N	http://localhost:8055
604	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 10:49:53.914+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_permissions	37	\N	http://localhost:8055
605	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 10:55:03.003+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_files	40e0ea72-9b8c-47ff-a0fb-2e8faf7dc221	\N	http://localhost:8055
606	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 10:58:50.205+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	formations_translations	1	\N	http://localhost:8055
607	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 10:58:50.21+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	formations	1	\N	http://localhost:8055
608	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 11:03:12.135+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	formations_translations	2	\N	http://localhost:8055
609	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 11:03:12.143+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	formations_translations	1	\N	http://localhost:8055
610	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 11:03:12.151+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	formations	1	\N	http://localhost:8055
611	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 19:21:03.497+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	153	\N	http://localhost:8055
612	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 19:21:46.122+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	formations	\N	http://localhost:8055
613	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 20:15:37.659+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_files	16f1ae3e-53ad-4451-8e74-63aee1edf1f1	\N	http://localhost:8055
614	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 21:18:38.757+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	formations_translations	3	\N	http://localhost:8055
615	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 21:18:38.763+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	formations	2	\N	http://localhost:8055
616	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 21:19:19.945+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	formations	2	\N	http://localhost:8055
617	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 21:40:56.891+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_files	2f8f12a0-255f-471e-99c6-8c70a7ea01d8	\N	http://localhost:8055
618	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 21:40:58.245+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	formations	2	\N	http://localhost:8055
619	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 23:45:32.455+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	154	\N	http://localhost:8055
620	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 23:46:18.803+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_files	9e3206c7-b230-4953-98fe-dad086f421df	\N	http://localhost:8055
621	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 23:46:21.076+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	projects	1	\N	http://localhost:8055
622	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 23:47:07.672+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_files	8f110ef2-feb3-4e55-ae2e-47fbb949dfd5	\N	http://localhost:8055
623	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 23:47:08.799+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	projects	2	\N	http://localhost:8055
624	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 23:47:43.174+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_files	242b35e1-524f-4227-9b6a-7f338b75c0ba	\N	http://localhost:8055
625	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 23:47:44.558+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	projects	3	\N	http://localhost:8055
626	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:40:55.863+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	155	\N	http://localhost:8055
627	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:40:55.876+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	156	\N	http://localhost:8055
628	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:40:55.904+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	articles	\N	http://localhost:8055
629	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:41:43.477+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	157	\N	http://localhost:8055
630	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:42:06.56+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	158	\N	http://localhost:8055
631	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:42:06.569+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	categories	\N	http://localhost:8055
632	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:42:31.796+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	159	\N	http://localhost:8055
633	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:42:31.973+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	160	\N	http://localhost:8055
634	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:42:31.985+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	categories_translations	\N	http://localhost:8055
635	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:42:32.105+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	161	\N	http://localhost:8055
636	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:42:32.215+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	162	\N	http://localhost:8055
637	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:42:52.189+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	163	\N	http://localhost:8055
638	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:42:52.344+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	164	\N	http://localhost:8055
639	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:42:52.352+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	articles_translations	\N	http://localhost:8055
640	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:42:52.478+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	165	\N	http://localhost:8055
641	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:42:52.58+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	166	\N	http://localhost:8055
642	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:03.418+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	articles_translations	\N	http://localhost:8055
643	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:03.42+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	comments	\N	http://localhost:8055
644	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:03.434+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	lang	\N	http://localhost:8055
645	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:03.448+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	languages	\N	http://localhost:8055
646	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:03.463+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	links	\N	http://localhost:8055
647	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:03.491+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile	\N	http://localhost:8055
648	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:03.501+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects	\N	http://localhost:8055
649	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:03.513+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	articles	\N	http://localhost:8055
650	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:03.52+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	categories	\N	http://localhost:8055
651	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:03.533+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	categories_translations	\N	http://localhost:8055
652	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:03.546+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	formations	\N	http://localhost:8055
653	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:03.558+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	formations_translations	\N	http://localhost:8055
654	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:03.569+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_section_translations	\N	http://localhost:8055
656	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:14.018+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	categories_translations	\N	http://localhost:8055
668	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:16.711+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	formations_translations	\N	http://localhost:8055
679	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:25.86+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_section_translations	\N	http://localhost:8055
682	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:25.879+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_section_item	\N	http://localhost:8055
683	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:25.898+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_section_item_translations	\N	http://localhost:8055
692	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:30.79+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_section_translations	\N	http://localhost:8055
693	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:30.816+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_section_item	\N	http://localhost:8055
655	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:11.428+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	articles_translations	\N	http://localhost:8055
657	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:14.018+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	comments	\N	http://localhost:8055
658	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:14.036+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	lang	\N	http://localhost:8055
659	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:14.051+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	languages	\N	http://localhost:8055
660	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:14.075+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	links	\N	http://localhost:8055
661	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:14.12+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile	\N	http://localhost:8055
662	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:14.136+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects	\N	http://localhost:8055
663	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:14.15+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	articles	\N	http://localhost:8055
664	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:14.164+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	categories	\N	http://localhost:8055
665	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:14.175+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	formations	\N	http://localhost:8055
666	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:14.185+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	formations_translations	\N	http://localhost:8055
667	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:14.197+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_section_translations	\N	http://localhost:8055
669	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:16.712+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	comments	\N	http://localhost:8055
670	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:16.729+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	lang	\N	http://localhost:8055
671	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:16.742+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	languages	\N	http://localhost:8055
672	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:16.761+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	links	\N	http://localhost:8055
673	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:16.796+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile	\N	http://localhost:8055
674	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:16.804+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects	\N	http://localhost:8055
675	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:16.815+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	articles	\N	http://localhost:8055
676	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:16.825+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	categories	\N	http://localhost:8055
677	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:16.833+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	formations	\N	http://localhost:8055
678	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:16.846+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_section_translations	\N	http://localhost:8055
680	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:25.861+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	comments	\N	http://localhost:8055
681	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:25.879+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	lang	\N	http://localhost:8055
684	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:25.899+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	languages	\N	http://localhost:8055
685	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:25.922+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	links	\N	http://localhost:8055
686	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:25.937+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile	\N	http://localhost:8055
687	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:25.952+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects	\N	http://localhost:8055
688	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:25.99+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	articles	\N	http://localhost:8055
689	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:26.001+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	categories	\N	http://localhost:8055
690	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:26.013+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	formations	\N	http://localhost:8055
691	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:30.769+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_section_item_translations	\N	http://localhost:8055
694	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:43:56.701+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	167	\N	http://localhost:8055
695	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:44:08.993+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	168	\N	http://localhost:8055
696	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:44:55.481+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	169	\N	http://localhost:8055
697	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:44:55.658+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	170	\N	http://localhost:8055
698	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:44:55.669+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	articles_categories	\N	http://localhost:8055
699	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:44:55.763+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	171	\N	http://localhost:8055
700	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:44:55.871+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	172	\N	http://localhost:8055
701	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:45:40.171+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_section_item_translations	\N	http://localhost:8055
702	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:45:43.159+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	profile_translations	\N	http://localhost:8055
703	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:45:47.336+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	projects_translations	\N	http://localhost:8055
704	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:46:13.947+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_fields	173	\N	http://localhost:8055
705	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:46:34.749+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	categories_translations	1	\N	http://localhost:8055
706	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:46:34.755+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	categories_translations	2	\N	http://localhost:8055
707	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:46:34.761+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	categories	1	\N	http://localhost:8055
708	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:53:53.766+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_permissions	38	\N	http://localhost:8055
709	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:53:54.952+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_permissions	39	\N	http://localhost:8055
710	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:53:56.336+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_permissions	40	\N	http://localhost:8055
711	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:53:57.791+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_permissions	41	\N	http://localhost:8055
712	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 02:53:59.312+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_permissions	42	\N	http://localhost:8055
713	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 04:04:47.775+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	categories	\N	http://localhost:8055
714	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 04:05:22.257+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	articles_categories	1	\N	http://localhost:8055
715	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 04:05:22.266+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	articles_translations	1	\N	http://localhost:8055
716	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 04:05:22.273+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	articles	1	\N	http://localhost:8055
717	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 04:05:53.191+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	categories_translations	3	\N	http://localhost:8055
718	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 04:05:53.199+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	categories_translations	4	\N	http://localhost:8055
719	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 04:05:53.205+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	categories	2	\N	http://localhost:8055
720	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 04:06:15.092+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_collections	categories	\N	http://localhost:8055
721	create	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 04:06:57.311+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	articles_translations	2	\N	http://localhost:8055
722	update	a5813e40-3394-40b1-8143-74e680638c71	2023-02-28 04:06:57.319+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	articles	1	\N	http://localhost:8055
723	login	a5813e40-3394-40b1-8143-74e680638c71	2023-03-02 21:57:31.609+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_users	a5813e40-3394-40b1-8143-74e680638c71	\N	http://localhost:8055
724	login	a5813e40-3394-40b1-8143-74e680638c71	2023-03-10 02:48:29.087+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	directus_users	a5813e40-3394-40b1-8143-74e680638c71	\N	http://localhost:8055
\.


--
-- Data for Name: directus_collections; Type: TABLE DATA; Schema: public; Owner: cv
--

COPY public.directus_collections (collection, icon, note, display_template, hidden, singleton, translations, archive_field, archive_app_filter, archive_value, unarchive_value, sort_field, accountability, color, item_duplication_fields, sort, "group", collapse) FROM stdin;
comments	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	1	\N	open
lang	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	2	\N	open
languages	\N	\N	{{name}}	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	3	\N	open
links	\N	\N	{{name}}{{link}}	f	f	\N	\N	t	\N	\N	\N	all	\N	[]	4	\N	open
profile	\N	\N	{{email}}{{translations}}	f	f	\N	\N	t	\N	\N	\N	all	\N	[]	5	\N	closed
projects	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	6	\N	open
articles	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	7	\N	open
formations	\N	\N	{{translations.institution}}{{translations.name}}	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	9	\N	open
profile_section_translations	import_export	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	1	profile_section	open
profile_section_item	\N	\N	{{translations.title}}	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	2	profile_section	open
articles_categories	import_export	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open
profile_section_item_translations	import_export	\N	{{lang_code.code}}	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	1	profile_section_item	open
profile_translations	import_export	\N	{{lang_code.code}}	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	1	profile	open
projects_translations	import_export	\N	{{lang_code.code}}	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	3	projects	open
profile_section	\N	\N	{{id}}	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	2	profile	open
categories	\N	\N	{{translations.title}} {{id}}	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	8	\N	open
projects_links	import_export	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	1	projects	open
projects_languages	import_export	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	2	projects	open
articles_translations	import_export	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	1	articles	open
categories_translations	import_export	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	1	categories	open
formations_translations	import_export	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	1	formations	open
\.


--
-- Data for Name: directus_dashboards; Type: TABLE DATA; Schema: public; Owner: cv
--

COPY public.directus_dashboards (id, name, icon, note, date_created, user_created, color) FROM stdin;
\.


--
-- Data for Name: directus_fields; Type: TABLE DATA; Schema: public; Owner: cv
--

COPY public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, translations, note, conditions, required, "group", validation, validation_message) FROM stdin;
111	projects_translations	title	\N	input	{"iconLeft":null}	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
112	projects_translations	body	\N	input	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
5	comments	id	\N	input	\N	\N	\N	t	t	\N	full	\N	\N	\N	f	\N	\N	\N
6	comments	created_at	date-created	datetime	\N	datetime	{"relative":true}	t	t	\N	half	\N	\N	\N	f	\N	\N	\N
7	comments	name	\N	input	{"placeholder":"Anonymous"}	\N	\N	f	f	\N	full	\N	\N	\N	t	\N	\N	\N
8	comments	body	\N	input-rich-text-md	{"placeholder":"Votre commentaire..."}	\N	\N	f	f	\N	full	\N	\N	\N	t	\N	\N	\N
12	projects	id	\N	input	\N	\N	\N	t	t	\N	full	\N	\N	\N	f	\N	\N	\N
13	projects	name	\N	input	\N	\N	\N	f	f	\N	full	\N	\N	\N	t	\N	\N	\N
16	projects	github	\N	input	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
18	languages	id	\N	input	\N	\N	\N	t	t	\N	full	\N	\N	\N	f	\N	\N	\N
19	languages	name	\N	input	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
118	profile_section_item	section	m2o	select-dropdown-m2o	{"template":"{{title}}"}	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
86	profile_section	id	\N	input	\N	\N	\N	t	t	\N	full	\N	\N	\N	f	\N	\N	\N
119	profile_section	profile	m2o	select-dropdown-m2o	{"template":"{{email}}"}	\N	\N	f	f	\N	full	\N	\N	\N	t	\N	\N	\N
22	projects	languages	m2m	list-m2m	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
23	projects_languages	id	\N	\N	\N	\N	\N	f	t	\N	full	\N	\N	\N	f	\N	\N	\N
24	projects_languages	projects_id	\N	\N	\N	\N	\N	f	t	\N	full	\N	\N	\N	f	\N	\N	\N
25	projects_languages	languages_id	\N	\N	\N	\N	\N	f	t	\N	full	\N	\N	\N	f	\N	\N	\N
120	profile	sections	o2m	list-o2m	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
27	links	id	\N	input	\N	\N	\N	t	t	\N	full	\N	\N	\N	f	\N	\N	\N
121	profile_section	items	o2m	list-o2m	{"template":"{{title}}"}	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
29	links	link	\N	input	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
30	links	name	\N	input	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
122	profile_section_item	translations	translations	translations	{"languageField":"code","languageDirectionField":"name","defaultLanguage":"en"}	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
123	profile_section_item_translations	id	\N	\N	\N	\N	\N	f	t	\N	full	\N	\N	\N	f	\N	\N	\N
124	profile_section_item_translations	profile_section_item_id	\N	\N	\N	\N	\N	f	t	\N	full	\N	\N	\N	f	\N	\N	\N
34	projects_links	id	\N	\N	\N	\N	\N	f	t	\N	full	\N	\N	\N	f	\N	\N	\N
35	projects_links	projects_id	\N	\N	\N	\N	\N	f	t	\N	full	\N	\N	\N	f	\N	\N	\N
36	projects_links	links_id	\N	\N	\N	\N	\N	f	t	\N	full	\N	\N	\N	f	\N	\N	\N
125	profile_section_item_translations	lang_code	\N	\N	\N	\N	\N	f	t	\N	full	\N	\N	\N	f	\N	\N	\N
126	profile_section_item_translations	title	\N	input	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
127	profile_section_item_translations	subtitle	\N	input	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
41	profile	id	\N	input	\N	\N	\N	t	t	\N	full	\N	\N	\N	f	\N	\N	\N
45	profile	logo	file	file-image	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
87	profile_section	date_created	date-created	datetime	\N	datetime	{"relative":true}	t	t	\N	half	\N	\N	\N	f	\N	\N	\N
46	languages	logo	file	file	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
48	languages	link	\N	input	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
49	projects	tags	\N	input-code	{"language":"JSON"}	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
50	profile	linkedin	\N	input	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
134	profile_section_translations	id	\N	\N	\N	\N	\N	f	t	\N	full	\N	\N	\N	f	\N	\N	\N
52	profile	email	\N	input	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
53	profile	github	\N	input	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
54	profile	stackoverflow	\N	input	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
55	lang	code	\N	input	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
56	lang	name	\N	input	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
135	profile_section_translations	profile_section_id	\N	\N	\N	\N	\N	f	t	\N	full	\N	\N	\N	f	\N	\N	\N
136	profile_section_translations	lang_code	\N	\N	\N	\N	\N	f	t	\N	full	\N	\N	\N	f	\N	\N	\N
137	profile_section_translations	section_title	\N	input	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
138	profile_section	title	\N	input	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
139	formations	id	\N	input	\N	\N	\N	t	t	\N	full	\N	\N	\N	f	\N	\N	\N
140	formations	start	\N	datetime	\N	\N	\N	f	f	\N	full	\N	\N	\N	t	\N	\N	\N
141	formations	end	\N	datetime	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
142	formations	current	cast-boolean	boolean	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
144	formations	image	file	file-image	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
146	formations	translations	translations	translations	{"languageField":"code","languageDirectionField":"name","defaultLanguage":"en"}	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
147	formations_translations	id	\N	\N	\N	\N	\N	f	t	\N	full	\N	\N	\N	f	\N	\N	\N
148	formations_translations	formations_id	\N	\N	\N	\N	\N	f	t	\N	full	\N	\N	\N	f	\N	\N	\N
149	formations_translations	lang_code	\N	\N	\N	\N	\N	f	t	\N	full	\N	\N	\N	f	\N	\N	\N
150	formations_translations	institution	\N	input	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
151	formations_translations	skills	cast-json	list	{"fields":[{"field":"description","name":"description","meta":{"field":"description"}}]}	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
152	formations_translations	name	\N	input	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
153	formations	type	\N	input	{"min":1,"max":100}	\N	\N	f	f	\N	full	\N	\N	\N	t	\N	\N	\N
154	projects	background	file	file-image	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
77	profile	translations	translations	translations	{"languageField":"code","languageDirectionField":"name","defaultLanguage":"en"}	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
78	profile_translations	id	\N	\N	\N	\N	\N	f	t	\N	full	\N	\N	\N	f	\N	\N	\N
79	profile_translations	profile_id	\N	\N	\N	\N	\N	f	t	\N	full	\N	\N	\N	f	\N	\N	\N
80	profile_translations	lang_code	\N	\N	\N	\N	\N	f	t	\N	full	\N	\N	\N	f	\N	\N	\N
81	profile	phone	\N	input	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
82	profile_translations	poste	\N	input	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
155	articles	id	\N	input	\N	\N	\N	t	t	\N	full	\N	\N	\N	f	\N	\N	\N
84	profile	name	\N	input	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
85	profile_translations	description	\N	input-rich-text-md	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
88	profile_section	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	\N	half	\N	\N	\N	f	\N	\N	\N
90	profile_section_item	id	\N	input	\N	\N	\N	t	t	\N	full	\N	\N	\N	f	\N	\N	\N
91	profile_section_item	date_created	date-created	datetime	\N	datetime	{"relative":true}	t	t	\N	half	\N	\N	\N	f	\N	\N	\N
92	profile_section_item	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	\N	half	\N	\N	\N	f	\N	\N	\N
96	profile_section_item	image	file	file-image	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
156	articles	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	\N	half	\N	\N	\N	f	\N	\N	\N
157	articles	tags	cast-json	tags	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
158	categories	id	\N	input	\N	\N	\N	t	t	\N	full	\N	\N	\N	f	\N	\N	\N
159	categories	translations	translations	translations	{"languageField":"code","languageDirectionField":"name","defaultLanguage":"en"}	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
160	categories_translations	id	\N	\N	\N	\N	\N	f	t	\N	full	\N	\N	\N	f	\N	\N	\N
107	projects	translations	translations	translations	{"languageField":"code","languageDirectionField":"name","defaultLanguage":"en"}	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
108	projects_translations	id	\N	\N	\N	\N	\N	f	t	\N	full	\N	\N	\N	f	\N	\N	\N
109	projects_translations	projects_id	\N	\N	\N	\N	\N	f	t	\N	full	\N	\N	\N	f	\N	\N	\N
110	projects_translations	lang_code	\N	\N	\N	\N	\N	f	t	\N	full	\N	\N	\N	f	\N	\N	\N
161	categories_translations	categories_id	\N	\N	\N	\N	\N	f	t	\N	full	\N	\N	\N	f	\N	\N	\N
162	categories_translations	lang_code	\N	\N	\N	\N	\N	f	t	\N	full	\N	\N	\N	f	\N	\N	\N
163	articles	translations	translations	translations	{"languageField":"code","languageDirectionField":"name","defaultLanguage":"en"}	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
164	articles_translations	id	\N	\N	\N	\N	\N	f	t	\N	full	\N	\N	\N	f	\N	\N	\N
165	articles_translations	articles_id	\N	\N	\N	\N	\N	f	t	\N	full	\N	\N	\N	f	\N	\N	\N
166	articles_translations	lang_code	\N	\N	\N	\N	\N	f	t	\N	full	\N	\N	\N	f	\N	\N	\N
167	articles_translations	title	\N	input	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
168	articles_translations	body	\N	input-rich-text-md	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
169	articles	categories	m2m	list-m2m	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
170	articles_categories	id	\N	\N	\N	\N	\N	f	t	\N	full	\N	\N	\N	f	\N	\N	\N
171	articles_categories	articles_id	\N	\N	\N	\N	\N	f	t	\N	full	\N	\N	\N	f	\N	\N	\N
172	articles_categories	categories_id	\N	\N	\N	\N	\N	f	t	\N	full	\N	\N	\N	f	\N	\N	\N
173	categories_translations	title	\N	input	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
\.


--
-- Data for Name: directus_files; Type: TABLE DATA; Schema: public; Owner: cv
--

COPY public.directus_files (id, storage, filename_disk, filename_download, title, type, folder, uploaded_by, uploaded_on, modified_by, modified_on, charset, filesize, width, height, duration, embed, description, location, tags, metadata) FROM stdin;
044828b5-84c8-4380-9f37-e303f429d35d	local	044828b5-84c8-4380-9f37-e303f429d35d.png	lc.png	Lc	image/png	\N	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 16:12:02.099383+00	\N	2023-01-09 16:12:02.13+00	\N	302	83	83	\N	\N	\N	\N	\N	{}
03c8d29d-fc5a-429b-9299-60eb7fcb8a51	local	03c8d29d-fc5a-429b-9299-60eb7fcb8a51.jpeg	profile.jpeg	Profile	image/jpeg	\N	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 17:16:38.728924+00	\N	2023-01-09 17:16:38.769+00	\N	86892	720	720	\N	\N	\N	\N	\N	{}
2f3e0031-ff85-4ad1-911c-fe3a2b9a65b1	local	2f3e0031-ff85-4ad1-911c-fe3a2b9a65b1.png	Python-logo-notext.svg.png	Python Logo Notext.svg	image/png	\N	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 19:06:53.118509+00	\N	2023-01-09 19:06:53.176+00	\N	179111	1869	2048	\N	\N	\N	\N	\N	{}
ab83e718-aa4a-4c88-bc19-f7514c32eef9	local	ab83e718-aa4a-4c88-bc19-f7514c32eef9.png	Unofficial_JavaScript_logo_2.svg.png	Unofficial Java Script Logo 2.svg	image/png	\N	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 20:56:31.448154+00	\N	2023-01-09 20:56:31.535+00	\N	27610	1200	1200	\N	\N	\N	\N	\N	{}
7b39f430-ce41-40a9-aec8-ffe5d849b0bb	local	7b39f430-ce41-40a9-aec8-ffe5d849b0bb.png	174854.png	174854	image/png	\N	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 20:57:45.248895+00	\N	2023-01-09 20:57:45.265+00	\N	5776	512	512	\N	\N	\N	\N	\N	{}
85670c85-30d0-4ba7-a19e-8cbde6b11d09	local	85670c85-30d0-4ba7-a19e-8cbde6b11d09.png	CSS3_logo.svg.png	Cs S3 Logo.svg	image/png	\N	a5813e40-3394-40b1-8143-74e680638c71	2023-01-09 20:58:17.395091+00	\N	2023-01-09 20:58:17.413+00	\N	23432	800	800	\N	\N	\N	\N	\N	{}
dc446a36-ac14-4e6c-a463-71added7d9a2	local	dc446a36-ac14-4e6c-a463-71added7d9a2.png	png-clipart-javascript-open-logo-number-js-angle-text.png	Png Clipart Javascript Open Logo Number JS Angle Text.png	image/png	\N	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:00:32.074648+00	\N	2023-02-22 00:00:32.143+00	\N	8539	900	1020	\N	\N	\N	\N	\N	{}
0855e668-4b07-4373-8c76-ff744057f860	local	0855e668-4b07-4373-8c76-ff744057f860.png	cpp.png	Cpp	image/png	\N	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:04:36.2131+00	\N	2023-02-22 00:04:36.234+00	\N	175813	1822	2048	\N	\N	\N	\N	\N	{}
4acac7d6-e615-4e74-8a16-859a83a1f1fc	local	4acac7d6-e615-4e74-8a16-859a83a1f1fc.png	1869px-Python-logo-notext.svg.png	1869px Python Logo Notext.svg.png	image/png	\N	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:05:45.497147+00	\N	2023-02-22 00:05:45.52+00	\N	179111	1869	2048	\N	\N	\N	\N	\N	{}
15794a77-6d4b-436f-8626-a40a24d36da1	local	15794a77-6d4b-436f-8626-a40a24d36da1.png	web.png	Web	image/png	\N	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:11:08.001844+00	\N	2023-02-22 00:11:08.026+00	\N	56076	225	225	\N	\N	\N	\N	\N	{}
90f06a4a-caff-4d70-a59e-64f5b61cee7e	local	90f06a4a-caff-4d70-a59e-64f5b61cee7e.png	800px-Java_Logo.svg.png	800px Java Logo.svg.png	image/png	\N	a5813e40-3394-40b1-8143-74e680638c71	2023-02-22 00:12:14.785738+00	\N	2023-02-22 00:12:14.808+00	\N	77151	800	1489	\N	\N	\N	\N	\N	{}
b8117a85-157b-49a7-b67b-63a5276e0d42	local	b8117a85-157b-49a7-b67b-63a5276e0d42.png	docker.png	Docker.png	image/png	\N	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 01:20:45.109876+00	\N	2023-02-27 01:20:45.16+00	\N	68487	1354	1208	\N	\N	\N	\N	\N	{}
c8a18cac-14da-47e3-81aa-686640d35ae7	local	c8a18cac-14da-47e3-81aa-686640d35ae7.png	traefik.png	Traefik.png	image/png	\N	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 01:21:08.239328+00	\N	2023-02-27 01:21:08.258+00	\N	35056	600	600	\N	\N	\N	\N	\N	{}
40e0ea72-9b8c-47ff-a0fb-2e8faf7dc221	local	40e0ea72-9b8c-47ff-a0fb-2e8faf7dc221.ico	epitech.ico	Epitech.ico	image/x-icon	\N	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 10:55:02.998637+00	\N	2023-02-27 10:55:03.076+00	\N	238718	\N	\N	\N	\N	\N	\N	\N	\N
16f1ae3e-53ad-4451-8e74-63aee1edf1f1	local	16f1ae3e-53ad-4451-8e74-63aee1edf1f1.svg	indigen.svg	Indigen	image/svg+xml	\N	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 20:15:37.651145+00	\N	2023-02-27 20:15:37.694+00	\N	478	\N	\N	\N	\N	\N	\N	\N	\N
2f8f12a0-255f-471e-99c6-8c70a7ea01d8	local	2f8f12a0-255f-471e-99c6-8c70a7ea01d8.jpg	i ndigen.jpg	I Ndigen	image/jpeg	\N	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 21:40:56.883963+00	\N	2023-02-27 21:40:56.972+00	\N	6465	200	200	\N	\N	\N	\N	\N	{}
9e3206c7-b230-4953-98fe-dad086f421df	local	9e3206c7-b230-4953-98fe-dad086f421df.jpg	bg.jpg	Bg	image/jpeg	\N	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 23:46:18.796635+00	\N	2023-02-27 23:46:18.836+00	\N	423398	1920	1080	\N	\N	\N	\N	\N	{}
8f110ef2-feb3-4e55-ae2e-47fbb949dfd5	local	8f110ef2-feb3-4e55-ae2e-47fbb949dfd5.jpg	mrobot.jpg	Mrobot	image/jpeg	\N	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 23:47:07.668607+00	\N	2023-02-27 23:47:07.708+00	\N	1158621	3840	2400	\N	\N	\N	\N	\N	{}
242b35e1-524f-4227-9b6a-7f338b75c0ba	local	242b35e1-524f-4227-9b6a-7f338b75c0ba.jpg	a44cf90b4f761c179058a0547da19683.jpg	A44cf90b4f761c179058a0547da19683.jpg	image/jpeg	\N	a5813e40-3394-40b1-8143-74e680638c71	2023-02-27 23:47:43.169949+00	\N	2023-02-27 23:47:43.203+00	\N	64336	1920	1080	\N	\N	\N	\N	\N	{}
\.


--
-- Data for Name: directus_flows; Type: TABLE DATA; Schema: public; Owner: cv
--

COPY public.directus_flows (id, name, icon, color, description, status, trigger, accountability, options, operation, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_folders; Type: TABLE DATA; Schema: public; Owner: cv
--

COPY public.directus_folders (id, name, parent) FROM stdin;
\.


--
-- Data for Name: directus_migrations; Type: TABLE DATA; Schema: public; Owner: cv
--

COPY public.directus_migrations (version, name, "timestamp") FROM stdin;
20201028A	Remove Collection Foreign Keys	2022-11-28 19:13:01.669351+00
20201029A	Remove System Relations	2022-11-28 19:13:01.675571+00
20201029B	Remove System Collections	2022-11-28 19:13:01.680603+00
20201029C	Remove System Fields	2022-11-28 19:13:01.692704+00
20201105A	Add Cascade System Relations	2022-11-28 19:13:01.82006+00
20201105B	Change Webhook URL Type	2022-11-28 19:13:01.835689+00
20210225A	Add Relations Sort Field	2022-11-28 19:13:01.844985+00
20210304A	Remove Locked Fields	2022-11-28 19:13:01.853962+00
20210312A	Webhooks Collections Text	2022-11-28 19:13:01.869948+00
20210331A	Add Refresh Interval	2022-11-28 19:13:01.877876+00
20210415A	Make Filesize Nullable	2022-11-28 19:13:01.897033+00
20210416A	Add Collections Accountability	2022-11-28 19:13:01.907556+00
20210422A	Remove Files Interface	2022-11-28 19:13:01.912938+00
20210506A	Rename Interfaces	2022-11-28 19:13:01.947553+00
20210510A	Restructure Relations	2022-11-28 19:13:01.997909+00
20210518A	Add Foreign Key Constraints	2022-11-28 19:13:02.007203+00
20210519A	Add System Fk Triggers	2022-11-28 19:13:02.082298+00
20210521A	Add Collections Icon Color	2022-11-28 19:13:02.090252+00
20210525A	Add Insights	2022-11-28 19:13:02.130545+00
20210608A	Add Deep Clone Config	2022-11-28 19:13:02.138914+00
20210626A	Change Filesize Bigint	2022-11-28 19:13:02.165727+00
20210716A	Add Conditions to Fields	2022-11-28 19:13:02.174048+00
20210721A	Add Default Folder	2022-11-28 19:13:02.188078+00
20210802A	Replace Groups	2022-11-28 19:13:02.193748+00
20210803A	Add Required to Fields	2022-11-28 19:13:02.202164+00
20210805A	Update Groups	2022-11-28 19:13:02.207253+00
20210805B	Change Image Metadata Structure	2022-11-28 19:13:02.21357+00
20210811A	Add Geometry Config	2022-11-28 19:13:02.221964+00
20210831A	Remove Limit Column	2022-11-28 19:13:02.229878+00
20210903A	Add Auth Provider	2022-11-28 19:13:02.271546+00
20210907A	Webhooks Collections Not Null	2022-11-28 19:13:02.289648+00
20210910A	Move Module Setup	2022-11-28 19:13:02.302128+00
20210920A	Webhooks URL Not Null	2022-11-28 19:13:02.321616+00
20210924A	Add Collection Organization	2022-11-28 19:13:02.333946+00
20210927A	Replace Fields Group	2022-11-28 19:13:02.351185+00
20210927B	Replace M2M Interface	2022-11-28 19:13:02.356511+00
20210929A	Rename Login Action	2022-11-28 19:13:02.361561+00
20211007A	Update Presets	2022-11-28 19:13:02.374734+00
20211009A	Add Auth Data	2022-11-28 19:13:02.382762+00
20211016A	Add Webhook Headers	2022-11-28 19:13:02.392929+00
20211103A	Set Unique to User Token	2022-11-28 19:13:02.403935+00
20211103B	Update Special Geometry	2022-11-28 19:13:02.408986+00
20211104A	Remove Collections Listing	2022-11-28 19:13:02.418098+00
20211118A	Add Notifications	2022-11-28 19:13:02.448799+00
20211211A	Add Shares	2022-11-28 19:13:02.492515+00
20211230A	Add Project Descriptor	2022-11-28 19:13:02.502808+00
20220303A	Remove Default Project Color	2022-11-28 19:13:02.522939+00
20220308A	Add Bookmark Icon and Color	2022-11-28 19:13:02.531468+00
20220314A	Add Translation Strings	2022-11-28 19:13:02.539361+00
20220322A	Rename Field Typecast Flags	2022-11-28 19:13:02.544947+00
20220323A	Add Field Validation	2022-11-28 19:13:02.553459+00
20220325A	Fix Typecast Flags	2022-11-28 19:13:02.558891+00
20220325B	Add Default Language	2022-11-28 19:13:02.58215+00
20220402A	Remove Default Value Panel Icon	2022-11-28 19:13:02.600137+00
20220429A	Add Flows	2022-11-28 19:13:02.674081+00
20220429B	Add Color to Insights Icon	2022-11-28 19:13:02.682872+00
20220429C	Drop Non Null From IP of Activity	2022-11-28 19:13:02.69075+00
20220429D	Drop Non Null From Sender of Notifications	2022-11-28 19:13:02.698081+00
20220614A	Rename Hook Trigger to Event	2022-11-28 19:13:02.703663+00
20220801A	Update Notifications Timestamp Column	2022-11-28 19:13:02.723928+00
20220802A	Add Custom Aspect Ratios	2022-11-28 19:13:02.731838+00
20220826A	Add Origin to Accountability	2022-11-28 19:13:02.744+00
\.


--
-- Data for Name: directus_notifications; Type: TABLE DATA; Schema: public; Owner: cv
--

COPY public.directus_notifications (id, "timestamp", status, recipient, sender, subject, message, collection, item) FROM stdin;
\.


--
-- Data for Name: directus_operations; Type: TABLE DATA; Schema: public; Owner: cv
--

COPY public.directus_operations (id, name, key, type, position_x, position_y, options, resolve, reject, flow, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_panels; Type: TABLE DATA; Schema: public; Owner: cv
--

COPY public.directus_panels (id, dashboard, name, icon, color, show_header, note, type, position_x, position_y, width, height, options, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_permissions; Type: TABLE DATA; Schema: public; Owner: cv
--

COPY public.directus_permissions (id, role, collection, action, permissions, validation, presets, fields) FROM stdin;
7	\N	comments	read	{}	{}	\N	*
9	\N	projects	read	{}	{}	\N	*
10	\N	languages	read	{}	{}	\N	*
11	\N	projects_languages	read	{}	{}	\N	*
12	\N	profile	read	{}	{}	\N	*
22	\N	directus_files	read	{}	{}	\N	*
26	\N	directus_files	share	{}	{}	\N	*
27	\N	profile_translations	read	{}	{}	\N	*
28	\N	projects_translations	read	{}	{}	\N	*
29	\N	profile_section_item_translations	read	{}	{}	\N	*
30	\N	profile_section	read	{}	{}	\N	*
31	\N	profile_section_item	read	{}	{}	\N	*
32	\N	links	read	{}	{}	\N	*
33	\N	lang	read	{}	{}	\N	*
34	\N	projects_links	read	{}	{}	\N	*
35	\N	profile_section_translations	read	{}	{}	\N	*
36	\N	formations	read	{}	{}	\N	*
37	\N	formations_translations	read	{}	{}	\N	*
38	\N	categories_translations	read	{}	{}	\N	*
39	\N	categories	read	{}	{}	\N	*
40	\N	articles_translations	read	{}	{}	\N	*
41	\N	articles_categories	read	{}	{}	\N	*
42	\N	articles	read	{}	{}	\N	*
\.


--
-- Data for Name: directus_presets; Type: TABLE DATA; Schema: public; Owner: cv
--

COPY public.directus_presets (id, bookmark, "user", role, collection, search, layout, layout_query, layout_options, refresh_interval, filter, icon, color) FROM stdin;
1	\N	a5813e40-3394-40b1-8143-74e680638c71	\N	directus_activity	\N	tabular	{"tabular":{"sort":["-timestamp"],"fields":["action","collection","timestamp","user"],"page":1}}	{"tabular":{"widths":{"action":100,"collection":210,"timestamp":240,"user":240}}}	\N	\N	bookmark_outline	\N
2	\N	a5813e40-3394-40b1-8143-74e680638c71	\N	directus_users	\N	cards	{"cards":{"sort":["email"],"page":1}}	{"cards":{"icon":"account_circle","title":"{{ first_name }} {{ last_name }}","subtitle":"{{ email }}","size":4}}	\N	\N	bookmark_outline	\N
4	\N	a5813e40-3394-40b1-8143-74e680638c71	\N	directus_files	\N	cards	{"cards":{"sort":["-uploaded_on"],"page":1}}	{"cards":{"icon":"insert_drive_file","title":"{{ title }}","subtitle":"{{ type }} • {{ filesize }}","size":4,"imageFit":"crop"}}	\N	\N	bookmark_outline	\N
7	\N	a5813e40-3394-40b1-8143-74e680638c71	\N	profile_translation	\N	\N	{"tabular":{"page":1}}	\N	\N	\N	bookmark_outline	\N
8	\N	a5813e40-3394-40b1-8143-74e680638c71	\N	links	\N	\N	{"tabular":{"page":1}}	\N	\N	\N	bookmark_outline	\N
9	\N	a5813e40-3394-40b1-8143-74e680638c71	\N	comments	\N	\N	{"tabular":{"page":1}}	\N	\N	\N	bookmark_outline	\N
6	\N	a5813e40-3394-40b1-8143-74e680638c71	\N	profile	\N	\N	{"tabular":{"fields":["email","github","linkedin","logo"],"page":1}}	{"tabular":{"widths":{"email":160}}}	\N	\N	bookmark_outline	\N
3	\N	a5813e40-3394-40b1-8143-74e680638c71	\N	projects	\N	\N	{"tabular":{"fields":["name","github","languages","tags"]}}	{"tabular":{"widths":{}}}	\N	\N	bookmark_outline	\N
10	\N	a5813e40-3394-40b1-8143-74e680638c71	\N	languages	\N	\N	{"tabular":{"page":1}}	\N	\N	\N	bookmark_outline	\N
5	\N	a5813e40-3394-40b1-8143-74e680638c71	\N	lang	\N	\N	{"tabular":{"page":1}}	\N	\N	\N	bookmark_outline	\N
\.


--
-- Data for Name: directus_relations; Type: TABLE DATA; Schema: public; Owner: cv
--

COPY public.directus_relations (id, many_collection, many_field, one_collection, one_field, one_collection_field, one_allowed_collections, junction_field, sort_field, one_deselect_action) FROM stdin;
1	projects_languages	languages_id	languages	\N	\N	\N	projects_id	\N	nullify
2	projects_languages	projects_id	projects	languages	\N	\N	languages_id	\N	nullify
3	projects_links	links_id	links	\N	\N	\N	projects_id	\N	nullify
4	projects_links	projects_id	projects	\N	\N	\N	links_id	\N	nullify
5	profile	logo	directus_files	\N	\N	\N	\N	\N	nullify
6	languages	logo	directus_files	\N	\N	\N	\N	\N	nullify
13	profile_translations	lang_code	lang	\N	\N	\N	profile_id	\N	nullify
14	profile_translations	profile_id	profile	translations	\N	\N	lang_code	\N	nullify
15	profile_section_item	image	directus_files	\N	\N	\N	\N	\N	nullify
21	projects_translations	lang_code	lang	\N	\N	\N	projects_id	\N	nullify
22	projects_translations	projects_id	projects	translations	\N	\N	lang_code	\N	nullify
25	profile_section	profile	profile	sections	\N	\N	\N	\N	nullify
24	profile_section_item	section	profile_section	items	\N	\N	\N	\N	nullify
26	profile_section_item_translations	lang_code	lang	\N	\N	\N	profile_section_item_id	\N	nullify
27	profile_section_item_translations	profile_section_item_id	profile_section_item	translations	\N	\N	lang_code	\N	nullify
30	profile_section_translations	lang_code	lang	\N	\N	\N	profile_section_id	\N	nullify
31	profile_section_translations	profile_section_id	profile_section	\N	\N	\N	lang_code	\N	nullify
32	formations	image	directus_files	\N	\N	\N	\N	\N	nullify
33	formations_translations	lang_code	lang	\N	\N	\N	formations_id	\N	nullify
34	formations_translations	formations_id	formations	translations	\N	\N	lang_code	\N	nullify
35	projects	background	directus_files	\N	\N	\N	\N	\N	nullify
36	categories_translations	lang_code	lang	\N	\N	\N	categories_id	\N	nullify
37	categories_translations	categories_id	categories	translations	\N	\N	lang_code	\N	nullify
38	articles_translations	lang_code	lang	\N	\N	\N	articles_id	\N	nullify
39	articles_translations	articles_id	articles	translations	\N	\N	lang_code	\N	nullify
40	articles_categories	categories_id	categories	\N	\N	\N	articles_id	\N	nullify
41	articles_categories	articles_id	articles	categories	\N	\N	categories_id	\N	nullify
\.


--
-- Data for Name: directus_revisions; Type: TABLE DATA; Schema: public; Owner: cv
--

COPY public.directus_revisions (id, activity, collection, item, data, delta, parent) FROM stdin;
1	2	directus_fields	1	{"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"Commentaire"}	{"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"Commentaire"}	\N
2	3	directus_collections	Commentaire	{"singleton":false,"collection":"Commentaire"}	{"singleton":false,"collection":"Commentaire"}	\N
3	4	directus_fields	2	{"interface":"input","special":null,"required":true,"options":{"placeholder":"Anonyme","iconLeft":"accessibility_new"},"collection":"Commentaire","field":"Name"}	{"interface":"input","special":null,"required":true,"options":{"placeholder":"Anonyme","iconLeft":"accessibility_new"},"collection":"Commentaire","field":"Name"}	\N
4	5	directus_fields	3	{"interface":"input-multiline","special":null,"required":true,"options":{"placeholder":"Commentaire...","softLength":420},"collection":"Commentaire","field":"Body"}	{"interface":"input-multiline","special":null,"required":true,"options":{"placeholder":"Commentaire...","softLength":420},"collection":"Commentaire","field":"Body"}	\N
5	6	directus_collections	Commentaire	{"collection":"Commentaire","icon":"description","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"fr-FR","translation":"Commentaire","singular":"Commentaire","plural":"Commentaires"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open"}	{"icon":"description","translations":[{"language":"fr-FR","translation":"Commentaire","singular":"Commentaire","plural":"Commentaires"}]}	\N
6	7	directus_collections	Commentaire	{"collection":"Commentaire","icon":"description","note":null,"display_template":"{{Name}}{{Body}}","hidden":false,"singleton":false,"translations":[{"language":"fr-FR","translation":"Commentaire","singular":"Commentaire","plural":"Commentaires"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open"}	{"display_template":"{{Name}}{{Body}}"}	\N
8	9	directus_permissions	1	{"role":null,"collection":"Commentaire","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"Commentaire","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
9	10	directus_permissions	2	{"role":null,"collection":"Commentaire","action":"share","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"Commentaire","action":"share","fields":["*"],"permissions":{},"validation":{}}	\N
11	12	directus_collections	Commentaire	{"collection":"Commentaire","icon":"description","note":null,"display_template":"Commentaire de {{Name}}","hidden":false,"singleton":false,"translations":[{"language":"fr-FR","translation":"Commentaire","singular":"Commentaire","plural":"Commentaires"},{"language":"en-US","translation":"Comment","singular":"Comment","plural":"Comments"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open"}	{"display_template":"Commentaire de {{Name}}","translations":[{"language":"fr-FR","translation":"Commentaire","singular":"Commentaire","plural":"Commentaires"},{"language":"en-US","translation":"Comment","singular":"Comment","plural":"Comments"}]}	\N
12	13	directus_permissions	4	{"role":null,"collection":"Commentaire","action":"delete","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"Commentaire","action":"delete","fields":["*"],"permissions":{},"validation":{}}	\N
13	14	directus_permissions	5	{"role":null,"collection":"Commentaire","action":"update","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"Commentaire","action":"update","fields":["*"],"permissions":{},"validation":{}}	\N
14	15	directus_permissions	3	{"role":null,"collection":"Commentaire","action":"create","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"Commentaire","action":"create","fields":["*"],"permissions":{},"validation":{}}	\N
15	16	directus_permissions	2	{"id":2,"role":null,"collection":"Commentaire","action":"share","permissions":{},"validation":{},"presets":null,"fields":["*"]}	{"permissions":{},"validation":{},"fields":["*"]}	\N
16	17	directus_permissions	1	{"id":1,"role":null,"collection":"Commentaire","action":"read","permissions":{},"validation":{},"presets":null,"fields":["*"]}	{"permissions":{},"validation":{},"fields":["*"]}	\N
17	23	directus_permissions	6	{"role":null,"collection":"Commentaire","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"Commentaire","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
18	24	directus_fields	4	{"interface":"datetime","special":["date-created"],"required":true,"collection":"Commentaire","field":"created_at"}	{"interface":"datetime","special":["date-created"],"required":true,"collection":"Commentaire","field":"created_at"}	\N
20	27	directus_fields	5	{"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"comments"}	{"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"comments"}	\N
21	28	directus_fields	6	{"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"created_at","collection":"comments"}	{"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"created_at","collection":"comments"}	\N
22	29	directus_collections	comments	{"singleton":false,"collection":"comments"}	{"singleton":false,"collection":"comments"}	\N
23	30	directus_fields	7	{"interface":"input","special":null,"required":true,"options":{"placeholder":"Anonymous"},"collection":"comments","field":"name"}	{"interface":"input","special":null,"required":true,"options":{"placeholder":"Anonymous"},"collection":"comments","field":"name"}	\N
24	31	directus_fields	8	{"interface":"input-rich-text-md","special":null,"required":true,"options":{"placeholder":"Votre commentaire..."},"collection":"comments","field":"body"}	{"interface":"input-rich-text-md","special":null,"required":true,"options":{"placeholder":"Votre commentaire..."},"collection":"comments","field":"body"}	\N
25	32	directus_permissions	7	{"role":null,"collection":"comments","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"comments","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
26	33	comments	1	{"name":"Loys","body":"**Oui**"}	{"name":"Loys","body":"**Oui**"}	\N
27	34	comments	2	{"body":"NON"}	{"body":"NON"}	\N
28	35	comments	3	{"body":"dsdsdsdsdsd"}	{"body":"dsdsdsdsdsd"}	\N
29	36	directus_fields	9	{"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"description"}	{"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"description"}	\N
30	37	directus_collections	description	{"singleton":true,"collection":"description"}	{"singleton":true,"collection":"description"}	\N
31	38	directus_fields	10	{"interface":"input-multiline","special":null,"required":false,"collection":"description","field":"body"}	{"interface":"input-multiline","special":null,"required":false,"collection":"description","field":"body"}	\N
32	39	directus_collections	description	{"collection":"description","icon":null,"note":null,"display_template":"{{id}}","hidden":false,"singleton":true,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open"}	{"display_template":"{{id}}"}	\N
34	41	directus_fields	11	{"interface":"input-multiline","special":null,"collection":"description","field":"body_fr"}	{"interface":"input-multiline","special":null,"collection":"description","field":"body_fr"}	\N
36	43	directus_permissions	8	{"role":null,"collection":"description","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"description","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
37	44	directus_fields	12	{"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"projects"}	{"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"projects"}	\N
38	45	directus_collections	projects	{"singleton":false,"collection":"projects"}	{"singleton":false,"collection":"projects"}	\N
39	46	directus_fields	13	{"interface":"input","special":null,"required":true,"collection":"projects","field":"name"}	{"interface":"input","special":null,"required":true,"collection":"projects","field":"name"}	\N
40	47	directus_fields	14	{"interface":"input","special":null,"collection":"projects","field":"title"}	{"interface":"input","special":null,"collection":"projects","field":"title"}	\N
41	48	directus_fields	15	{"interface":"tags","special":["cast-json"],"collection":"projects","field":"languages"}	{"interface":"tags","special":["cast-json"],"collection":"projects","field":"languages"}	\N
42	49	directus_fields	16	{"interface":"input","special":null,"collection":"projects","field":"github"}	{"interface":"input","special":null,"collection":"projects","field":"github"}	\N
43	50	directus_fields	17	{"interface":"input","special":null,"collection":"projects","field":"body"}	{"interface":"input","special":null,"collection":"projects","field":"body"}	\N
44	51	projects	1	{"name":"Plannify","title":"A shores planner web app","languages":["Django","Stripe API","Docker"],"body":"       Created and deployed a Django web app on Heroku and using Docker on a VPS. The app includes a premium version wich adds a permission system. "}	{"name":"Plannify","title":"A shores planner web app","languages":["Django","Stripe API","Docker"],"body":"       Created and deployed a Django web app on Heroku and using Docker on a VPS. The app includes a premium version wich adds a permission system. "}	\N
45	52	directus_permissions	9	{"role":null,"collection":"projects","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"projects","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
46	53	directus_fields	18	{"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"languages"}	{"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"languages"}	\N
47	54	directus_collections	languages	{"singleton":false,"collection":"languages"}	{"singleton":false,"collection":"languages"}	\N
48	55	directus_fields	19	{"interface":"input","special":null,"collection":"languages","field":"name"}	{"interface":"input","special":null,"collection":"languages","field":"name"}	\N
49	56	directus_fields	20	{"interface":"input","special":null,"collection":"languages","field":"logo"}	{"interface":"input","special":null,"collection":"languages","field":"logo"}	\N
50	57	directus_fields	15	{"id":15,"collection":"projects","field":"languages","special":["cast-json"],"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"projects","field":"languages","special":["cast-json"],"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	\N
51	58	directus_fields	21	{"interface":"list-o2m","special":["o2m"],"collection":"projects","field":"languages"}	{"interface":"list-o2m","special":["o2m"],"collection":"projects","field":"languages"}	\N
52	59	languages	1	{"name":"Python","logo":"http://localhost:5173/img/lang/python.png"}	{"name":"Python","logo":"http://localhost:5173/img/lang/python.png"}	\N
53	60	directus_permissions	10	{"role":null,"collection":"languages","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"languages","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
54	61	directus_fields	22	{"interface":"list-m2m","special":["m2m"],"collection":"projects","field":"languages"}	{"interface":"list-m2m","special":["m2m"],"collection":"projects","field":"languages"}	\N
55	62	directus_fields	23	{"hidden":true,"field":"id","collection":"projects_languages"}	{"hidden":true,"field":"id","collection":"projects_languages"}	\N
56	63	directus_collections	projects_languages	{"hidden":true,"icon":"import_export","collection":"projects_languages"}	{"hidden":true,"icon":"import_export","collection":"projects_languages"}	\N
57	64	directus_fields	24	{"hidden":true,"collection":"projects_languages","field":"projects_id"}	{"hidden":true,"collection":"projects_languages","field":"projects_id"}	\N
58	65	directus_fields	25	{"hidden":true,"collection":"projects_languages","field":"languages_id"}	{"hidden":true,"collection":"projects_languages","field":"languages_id"}	\N
60	67	projects	1	{"id":1,"name":"Plannify","title":"A shores planner web app","github":null,"body":"Created and deployed a Django web app on Heroku and using Docker on a VPS. The app includes a premium version wich adds a permission system. ","languages":[1]}	{"body":"Created and deployed a Django web app on Heroku and using Docker on a VPS. The app includes a premium version wich adds a permission system. "}	\N
59	66	projects_languages	1	{"projects_id":"1","languages_id":{"id":1}}	{"projects_id":"1","languages_id":{"id":1}}	60
61	68	directus_collections	languages	{"collection":"languages","icon":null,"note":null,"display_template":"{{name}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open"}	{"display_template":"{{name}}"}	\N
62	69	directus_permissions	11	{"role":null,"collection":"projects_languages","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"projects_languages","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
63	70	directus_fields	26	{"interface":"tags","special":["cast-json"],"collection":"projects","field":"tags"}	{"interface":"tags","special":["cast-json"],"collection":"projects","field":"tags"}	\N
64	71	projects	1	{"id":1,"name":"Plannify","title":"A shores planner web app","github":null,"body":"Created and deployed a Django web app on Heroku and using Docker on a VPS. The app includes a premium version wich adds a permission system. ","tags":["Stripe API","Django","Postgres"],"languages":[1]}	{"tags":["Stripe API","Django","Postgres"]}	\N
65	72	directus_fields	27	{"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"links"}	{"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"links"}	\N
66	73	directus_collections	links	{"singleton":false,"collection":"links"}	{"singleton":false,"collection":"links"}	\N
67	74	directus_fields	28	{"interface":"input","special":null,"collection":"links","field":"Name"}	{"interface":"input","special":null,"collection":"links","field":"Name"}	\N
68	75	directus_fields	29	{"interface":"input","special":null,"collection":"links","field":"link"}	{"interface":"input","special":null,"collection":"links","field":"link"}	\N
69	76	directus_fields	30	{"interface":"input","special":null,"collection":"links","field":"name"}	{"interface":"input","special":null,"collection":"links","field":"name"}	\N
70	77	directus_fields	31	{"interface":"input","special":null,"collection":"links","field":"parent_id"}	{"interface":"input","special":null,"collection":"links","field":"parent_id"}	\N
71	78	directus_fields	32	{"interface":"list-o2m","special":["o2m"],"collection":"projects","field":"links"}	{"interface":"list-o2m","special":["o2m"],"collection":"projects","field":"links"}	\N
72	79	directus_fields	33	{"interface":"list-m2m","special":["m2m"],"collection":"projects","field":"links"}	{"interface":"list-m2m","special":["m2m"],"collection":"projects","field":"links"}	\N
73	80	directus_fields	34	{"hidden":true,"field":"id","collection":"projects_links"}	{"hidden":true,"field":"id","collection":"projects_links"}	\N
74	81	directus_collections	projects_links	{"hidden":true,"icon":"import_export","collection":"projects_links"}	{"hidden":true,"icon":"import_export","collection":"projects_links"}	\N
75	82	directus_fields	35	{"hidden":true,"collection":"projects_links","field":"projects_id"}	{"hidden":true,"collection":"projects_links","field":"projects_id"}	\N
76	83	directus_fields	36	{"hidden":true,"collection":"projects_links","field":"links_id"}	{"hidden":true,"collection":"projects_links","field":"links_id"}	\N
78	85	projects_links	1	{"links_id":{"link":"https://github.com/gummyWalrus/Plannifii","name":"Github"},"projects_id":"1"}	{"links_id":{"link":"https://github.com/gummyWalrus/Plannifii","name":"Github"},"projects_id":"1"}	\N
77	84	links	1	{"link":"https://github.com/gummyWalrus/Plannifii","name":"Github"}	{"link":"https://github.com/gummyWalrus/Plannifii","name":"Github"}	78
79	87	directus_collections	links	{"collection":"links","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":null,"group":null,"collapse":"open"}	{"item_duplication_fields":[]}	\N
80	88	directus_collections	links	{"collection":"links","icon":null,"note":null,"display_template":"{{name}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":null,"group":null,"collapse":"open"}	{"display_template":"{{name}}"}	\N
81	89	directus_collections	links	{"collection":"links","icon":null,"note":null,"display_template":"{{name}}{{link}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":null,"group":null,"collapse":"open"}	{"display_template":"{{name}}{{link}}"}	\N
82	90	projects	1	{"id":1,"name":"Plannify","title":"A shores planner web app","github":"https://github.com/gummyWalrus/Plannifii","body":"Created and deployed a Django web app on Heroku and using Docker on a VPS. The app includes a premium version wich adds a permission system. ","tags":["Stripe API","Django","Postgres"],"languages":[1]}	{"github":"https://github.com/gummyWalrus/Plannifii"}	\N
166	196	lang	en	{"code":"en","name":"English"}	{"code":"en","name":"English"}	\N
83	91	projects	1	{"id":1,"name":"Plannifii","title":"A shores planner web app","github":"https://github.com/gummyWalrus/Plannifii","body":"Created and deployed a Django web app on Heroku and using Docker on a VPS. The app includes a premium version wich adds a permission system. ","tags":["Stripe API","Django","Postgres"],"languages":[1]}	{"name":"Plannifii"}	\N
84	94	directus_fields	37	{"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"Profile"}	{"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"Profile"}	\N
85	95	directus_collections	Profile	{"singleton":true,"collection":"Profile"}	{"singleton":true,"collection":"Profile"}	\N
86	96	directus_fields	38	{"interface":"input","special":null,"options":{"placeholder":null},"collection":"Profile","field":"name"}	{"interface":"input","special":null,"options":{"placeholder":null},"collection":"Profile","field":"name"}	\N
87	97	directus_fields	39	{"interface":"input-multiline","special":null,"collection":"Profile","field":"description"}	{"interface":"input-multiline","special":null,"collection":"Profile","field":"description"}	\N
88	98	directus_fields	40	{"interface":"input","special":null,"collection":"Profile","field":"poste"}	{"interface":"input","special":null,"collection":"Profile","field":"poste"}	\N
89	100	directus_fields	41	{"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"profile"}	{"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"profile"}	\N
90	101	directus_collections	profile	{"singleton":true,"collection":"profile"}	{"singleton":true,"collection":"profile"}	\N
91	102	directus_fields	42	{"interface":"input","special":null,"collection":"profile","field":"nom"}	{"interface":"input","special":null,"collection":"profile","field":"nom"}	\N
92	103	directus_fields	43	{"interface":"input","special":null,"collection":"profile","field":"poste"}	{"interface":"input","special":null,"collection":"profile","field":"poste"}	\N
93	104	directus_fields	44	{"interface":"input-multiline","special":null,"collection":"profile","field":"description"}	{"interface":"input-multiline","special":null,"collection":"profile","field":"description"}	\N
94	105	profile	1	{"description":"Here is a static website I made as my resume, feel free to take a look ! You can leave a comment at the bottom of the page. I'm passionated about computing since I'm 12. Because I'm very curious, I've been tinkering with a lot of different programming languages. I have the habit to learn by myself and from others, that's why I fit easily in new environnements. "}	{"description":"Here is a static website I made as my resume, feel free to take a look ! You can leave a comment at the bottom of the page. I'm passionated about computing since I'm 12. Because I'm very curious, I've been tinkering with a lot of different programming languages. I have the habit to learn by myself and from others, that's why I fit easily in new environnements. "}	\N
95	106	directus_fields	45	{"interface":"file-image","special":["file"],"collection":"profile","field":"logo"}	{"interface":"file-image","special":["file"],"collection":"profile","field":"logo"}	\N
96	107	directus_files	a59de36c-0cd7-4c6f-8b12-6457cc407f27	{"title":"Lc","filename_download":"lc.png","type":"image/png","storage":"local"}	{"title":"Lc","filename_download":"lc.png","type":"image/png","storage":"local"}	\N
97	108	directus_files	d3eee8d9-f8c7-44aa-b274-5cf418101d70	{"title":"Lc","filename_download":"lc.png","type":"image/png","storage":"local"}	{"title":"Lc","filename_download":"lc.png","type":"image/png","storage":"local"}	\N
98	109	directus_files	78f2ccc0-3c21-4f0b-9dda-7a315f52a893	{"title":"Lc","filename_download":"lc.png","type":"image/png","storage":"local"}	{"title":"Lc","filename_download":"lc.png","type":"image/png","storage":"local"}	\N
99	110	directus_files	63466c88-2422-4b43-93f9-13eada1bcf45	{"title":"Lc","filename_download":"lc.png","type":"image/png","storage":"local"}	{"title":"Lc","filename_download":"lc.png","type":"image/png","storage":"local"}	\N
100	111	directus_files	044828b5-84c8-4380-9f37-e303f429d35d	{"title":"Lc","filename_download":"lc.png","type":"image/png","storage":"local"}	{"title":"Lc","filename_download":"lc.png","type":"image/png","storage":"local"}	\N
101	112	profile	1	{"id":1,"nom":"Loys Caucheteux","poste":"Développeur Full-stack","description":"Here is a static website I made as my resume, feel free to take a look ! You can leave a comment at the bottom of the page. I'm passionated about computing since I'm 12. Because I'm very curious, I've been tinkering with a lot of different programming languages. I have the habit to learn by myself and from others, that's why I fit easily in new environnements. ","logo":"044828b5-84c8-4380-9f37-e303f429d35d"}	{"logo":"044828b5-84c8-4380-9f37-e303f429d35d"}	\N
102	117	directus_permissions	12	{"role":null,"collection":"profile","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"profile","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
103	118	directus_permissions	13	{"role":null,"collection":"directus_files","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"directus_files","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
104	120	directus_permissions	14	{"role":null,"collection":"directus_folders","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"directus_folders","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
105	123	directus_permissions	15	{"role":null,"collection":"directus_files","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"directus_files","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
106	125	directus_permissions	16	{"role":null,"collection":"directus_files","action":"read"}	{"role":null,"collection":"directus_files","action":"read"}	\N
107	127	directus_permissions	17	{"role":null,"collection":"directus_files","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"directus_files","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
108	128	directus_permissions	18	{"role":null,"collection":"directus_files","action":"create","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"directus_files","action":"create","fields":["*"],"permissions":{},"validation":{}}	\N
109	129	directus_permissions	19	{"role":null,"collection":"directus_files","action":"update","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"directus_files","action":"update","fields":["*"],"permissions":{},"validation":{}}	\N
110	131	directus_permissions	20	{"role":null,"collection":"directus_files","action":"delete","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"directus_files","action":"delete","fields":["*"],"permissions":{},"validation":{}}	\N
111	130	directus_permissions	17	{"id":17,"role":null,"collection":"directus_files","action":"read","permissions":{},"validation":{},"presets":null,"fields":["*"]}	{"permissions":{},"validation":{},"fields":["*"]}	\N
112	132	directus_permissions	21	{"role":null,"collection":"directus_files","action":"share","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"directus_files","action":"share","fields":["*"],"permissions":{},"validation":{}}	\N
113	138	directus_permissions	22	{"role":null,"collection":"directus_files","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"directus_files","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
114	140	directus_permissions	23	{"role":null,"collection":"directus_files","action":"create","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"directus_files","action":"create","fields":["*"],"permissions":{},"validation":{}}	\N
115	142	directus_permissions	24	{"role":null,"collection":"directus_files","action":"update","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"directus_files","action":"update","fields":["*"],"permissions":{},"validation":{}}	\N
116	141	directus_permissions	22	{"id":22,"role":null,"collection":"directus_files","action":"read","permissions":{},"validation":{},"presets":null,"fields":["*"]}	{"permissions":{},"validation":{},"fields":["*"]}	\N
117	143	directus_permissions	25	{"role":null,"collection":"directus_files","action":"delete","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"directus_files","action":"delete","fields":["*"],"permissions":{},"validation":{}}	\N
118	144	directus_permissions	26	{"role":null,"collection":"directus_files","action":"share","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"directus_files","action":"share","fields":["*"],"permissions":{},"validation":{}}	\N
119	148	directus_files	03c8d29d-fc5a-429b-9299-60eb7fcb8a51	{"title":"Profile","filename_download":"profile.jpeg","type":"image/jpeg","storage":"local"}	{"title":"Profile","filename_download":"profile.jpeg","type":"image/jpeg","storage":"local"}	\N
120	149	profile	1	{"id":1,"nom":"Loys Caucheteux","poste":"Développeur Full-stack","description":"Here is a static website I made as my resume, feel free to take a look ! You can leave a comment at the bottom of the page. I'm passionated about computing since I'm 12. Because I'm very curious, I've been tinkering with a lot of different programming languages. I have the habit to learn by myself and from others, that's why I fit easily in new environnements. ","logo":"03c8d29d-fc5a-429b-9299-60eb7fcb8a51"}	{"logo":"03c8d29d-fc5a-429b-9299-60eb7fcb8a51"}	\N
121	150	profile	1	{"id":1,"nom":"Loys Caucheteux","poste":"Développeur Full-stack","description":"Hello, I'm Loys, I'm passionated about computing since I'm 12. Because I'm very curious, I've been tinkering with a lot of different programming languages. I have the habit to learn by myself and from others, that's why I fit easily in new environnements. ","logo":"03c8d29d-fc5a-429b-9299-60eb7fcb8a51"}	{"description":"Hello, I'm Loys, I'm passionated about computing since I'm 12. Because I'm very curious, I've been tinkering with a lot of different programming languages. I have the habit to learn by myself and from others, that's why I fit easily in new environnements. "}	\N
122	151	directus_fields	44	{"id":44,"collection":"profile","field":"description","special":null,"interface":"input-rich-text-md","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"profile","field":"description","special":null,"interface":"input-rich-text-md","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	\N
123	152	profile	1	{"id":1,"nom":"Loys Caucheteux","poste":"Développeur Full-stack","description":"Hello, I'm Loys, I'm passionated about computing since I'm 12\\n\\nI've been tinkering with a lot of different programming languages. \\n\\nI have the habit to learn by myself and from others, that's why I fit easily in new environnements. ","logo":"03c8d29d-fc5a-429b-9299-60eb7fcb8a51"}	{"description":"Hello, I'm Loys, I'm passionated about computing since I'm 12\\n\\nI've been tinkering with a lot of different programming languages. \\n\\nI have the habit to learn by myself and from others, that's why I fit easily in new environnements. "}	\N
124	153	directus_fields	46	{"interface":"file","special":["file"],"collection":"languages","field":"logo"}	{"interface":"file","special":["file"],"collection":"languages","field":"logo"}	\N
125	154	directus_files	2f3e0031-ff85-4ad1-911c-fe3a2b9a65b1	{"title":"Python Logo Notext.svg","filename_download":"Python-logo-notext.svg.png","type":"image/png","storage":"local"}	{"title":"Python Logo Notext.svg","filename_download":"Python-logo-notext.svg.png","type":"image/png","storage":"local"}	\N
126	155	languages	1	{"id":1,"name":"Python","logo":"2f3e0031-ff85-4ad1-911c-fe3a2b9a65b1"}	{"logo":"2f3e0031-ff85-4ad1-911c-fe3a2b9a65b1"}	\N
127	156	directus_fields	47	{"interface":"input-code","special":null,"options":{"language":"JSON"},"collection":"projects","field":"tags"}	{"interface":"input-code","special":null,"options":{"language":"JSON"},"collection":"projects","field":"tags"}	\N
128	157	projects	1	{"id":1,"name":"Plannifii","title":"A shores planner web app","github":"https://github.com/gummyWalrus/Plannifii","body":"Created and deployed a Django web app on Heroku and using Docker on a VPS. The app includes a premium version wich adds a permission system. ","tags":"{\\n    \\"name\\": \\"Stripe API\\",\\n    \\"icon\\": \\"fa-brands fa-stripe-s\\"\\n},\\n{\\n    \\"name\\": \\"Django\\",\\n    \\"icon\\": \\"fa-regular fa-user-bounty-hunter\\"\\n},\\n{\\n    \\"name\\": \\"Postgres\\",\\n    \\"icon\\": \\"fa-solid fa-database\\"\\n}","languages":[1]}	{"tags":"{\\n    \\"name\\": \\"Stripe API\\",\\n    \\"icon\\": \\"fa-brands fa-stripe-s\\"\\n},\\n{\\n    \\"name\\": \\"Django\\",\\n    \\"icon\\": \\"fa-regular fa-user-bounty-hunter\\"\\n},\\n{\\n    \\"name\\": \\"Postgres\\",\\n    \\"icon\\": \\"fa-solid fa-database\\"\\n}"}	\N
129	158	projects	1	{"id":1,"name":"Plannifii","title":"A shores planner web app","github":"https://github.com/gummyWalrus/Plannifii","body":"Created and deployed a Django web app on Heroku and using Docker on a VPS. The app includes a premium version wich adds a permission system. ","tags":"{\\n    \\"name\\": \\"Stripe API\\",\\n    \\"icon\\": \\"fa-brands fa-stripe-s\\"\\n},\\n{\\n    \\"name\\": \\"Django\\",\\n    \\"icon\\": \\"fa-regular fa-python\\"\\n},\\n{\\n    \\"name\\": \\"Postgres\\",\\n    \\"icon\\": \\"fa-solid fa-database\\"\\n}","languages":[1]}	{"tags":"{\\n    \\"name\\": \\"Stripe API\\",\\n    \\"icon\\": \\"fa-brands fa-stripe-s\\"\\n},\\n{\\n    \\"name\\": \\"Django\\",\\n    \\"icon\\": \\"fa-regular fa-python\\"\\n},\\n{\\n    \\"name\\": \\"Postgres\\",\\n    \\"icon\\": \\"fa-solid fa-database\\"\\n}"}	\N
130	159	projects	1	{"id":1,"name":"Plannifii","title":"A shores planner web app","github":"https://github.com/gummyWalrus/Plannifii","body":"Created and deployed a Django web app on Heroku and using Docker on a VPS. The app includes a premium version wich adds a permission system. ","tags":"{\\n    \\"name\\": \\"Stripe API\\",\\n    \\"icon\\": \\"fa-brands fa-stripe-s\\"\\n},\\n{\\n    \\"name\\": \\"Django\\",\\n    \\"icon\\": \\"fa-brands fa-python\\"\\n},\\n{\\n    \\"name\\": \\"Postgres\\",\\n    \\"icon\\": \\"fa-solid fa-database\\"\\n}","languages":[1]}	{"tags":"{\\n    \\"name\\": \\"Stripe API\\",\\n    \\"icon\\": \\"fa-brands fa-stripe-s\\"\\n},\\n{\\n    \\"name\\": \\"Django\\",\\n    \\"icon\\": \\"fa-brands fa-python\\"\\n},\\n{\\n    \\"name\\": \\"Postgres\\",\\n    \\"icon\\": \\"fa-solid fa-database\\"\\n}"}	\N
131	160	projects	1	{"id":1,"name":"Plannifii","title":"A shores planner web app","github":"https://github.com/gummyWalrus/Plannifii","body":"Created and deployed a Django web app on Heroku and using Docker on a VPS. The app includes a premium version wich adds a permission system. ","tags":"[\\n    {\\n    \\"name\\": \\"Stripe API\\",\\n    \\"icon\\": \\"fa-brands fa-stripe-s\\"\\n    },\\n    {\\n        \\"name\\": \\"Django\\",\\n        \\"icon\\": \\"fa-brands fa-python\\"\\n    },\\n    {\\n        \\"name\\": \\"Postgres\\",\\n        \\"icon\\": \\"fa-solid fa-database\\"\\n    }\\n]","languages":[1]}	{"tags":"[\\n    {\\n    \\"name\\": \\"Stripe API\\",\\n    \\"icon\\": \\"fa-brands fa-stripe-s\\"\\n    },\\n    {\\n        \\"name\\": \\"Django\\",\\n        \\"icon\\": \\"fa-brands fa-python\\"\\n    },\\n    {\\n        \\"name\\": \\"Postgres\\",\\n        \\"icon\\": \\"fa-solid fa-database\\"\\n    }\\n]"}	\N
132	161	directus_fields	48	{"interface":"input","special":null,"collection":"languages","field":"link"}	{"interface":"input","special":null,"collection":"languages","field":"link"}	\N
133	162	languages	1	{"id":1,"name":"Python","logo":"2f3e0031-ff85-4ad1-911c-fe3a2b9a65b1","link":"https://www.python.org/"}	{"link":"https://www.python.org/"}	\N
134	163	directus_fields	49	{"interface":"input-code","special":null,"options":{"language":"JSON"},"collection":"projects","field":"tags"}	{"interface":"input-code","special":null,"options":{"language":"JSON"},"collection":"projects","field":"tags"}	\N
135	164	projects	1	{"id":1,"name":"Plannifii","title":"A shores planner web app","github":"https://github.com/gummyWalrus/Plannifii","body":"Created and deployed a Django web app on Heroku and using Docker on a VPS. The app includes a premium version wich adds a permission system. ","tags":"[\\n    {\\n        \\"name\\": \\"Stripe API\\",\\n        \\"icon\\": \\"fa-brands fa-stripe-s\\",\\n        \\"link\\": \\"https://stripe.com\\"\\n    },\\n    {\\n        \\"name\\": \\"Django\\",\\n        \\"icon\\": \\"fa-brands fa-python\\",\\n        \\"link\\": \\"https://www.djangoproject.com/\\"\\n    },\\n    {\\n        \\"name\\": \\"Postgres\\",\\n        \\"icon\\": \\"fa-solid fa-database\\",\\n        \\"link\\": \\"https://www.postgresql.org/\\"\\n    }\\n]","languages":[1]}	{"tags":"[\\n    {\\n        \\"name\\": \\"Stripe API\\",\\n        \\"icon\\": \\"fa-brands fa-stripe-s\\",\\n        \\"link\\": \\"https://stripe.com\\"\\n    },\\n    {\\n        \\"name\\": \\"Django\\",\\n        \\"icon\\": \\"fa-brands fa-python\\",\\n        \\"link\\": \\"https://www.djangoproject.com/\\"\\n    },\\n    {\\n        \\"name\\": \\"Postgres\\",\\n        \\"icon\\": \\"fa-solid fa-database\\",\\n        \\"link\\": \\"https://www.postgresql.org/\\"\\n    }\\n]"}	\N
136	165	projects	1	{"id":1,"name":"Plannifii","title":"A shores planner web app","github":"https://github.com/gummyWalrus/Plannifii","body":"Created and deployed a Django web app on Heroku and using Docker on a VPS. The app includes a premium version wich adds a permission system. ","tags":"[\\n    {\\n        \\"name\\": \\"Stripe API\\",\\n        \\"icon\\": \\"fa-brands fa-stripe-s\\",\\n        \\"link\\": \\"https://stripe.com\\"\\n    },\\n    {\\n        \\"name\\": \\"Django\\",\\n        \\"icon\\": \\"fa-brands fa-python\\",\\n        \\"link\\": \\"https://www.djangoproject.com/\\"\\n    },\\n    {\\n        \\"name\\": \\"Postgres\\",\\n        \\"icon\\": \\"fa-solid fa-database\\",\\n        \\"link\\": \\"https://www.postgresql.org/\\"\\n    }\\n]","languages":[1]}	{"tags":"[\\n    {\\n        \\"name\\": \\"Stripe API\\",\\n        \\"icon\\": \\"fa-brands fa-stripe-s\\",\\n        \\"link\\": \\"https://stripe.com\\"\\n    },\\n    {\\n        \\"name\\": \\"Django\\",\\n        \\"icon\\": \\"fa-brands fa-python\\",\\n        \\"link\\": \\"https://www.djangoproject.com/\\"\\n    },\\n    {\\n        \\"name\\": \\"Postgres\\",\\n        \\"icon\\": \\"fa-solid fa-database\\",\\n        \\"link\\": \\"https://www.postgresql.org/\\"\\n    }\\n]"}	\N
137	166	directus_files	ab83e718-aa4a-4c88-bc19-f7514c32eef9	{"title":"Unofficial Java Script Logo 2.svg","filename_download":"Unofficial_JavaScript_logo_2.svg.png","type":"image/png","storage":"local"}	{"title":"Unofficial Java Script Logo 2.svg","filename_download":"Unofficial_JavaScript_logo_2.svg.png","type":"image/png","storage":"local"}	\N
138	167	languages	2	{"name":"Javascript","logo":"ab83e718-aa4a-4c88-bc19-f7514c32eef9","link":"https://developer.mozilla.org/fr/docs/Web/JavaScript"}	{"name":"Javascript","logo":"ab83e718-aa4a-4c88-bc19-f7514c32eef9","link":"https://developer.mozilla.org/fr/docs/Web/JavaScript"}	\N
139	168	directus_files	7b39f430-ce41-40a9-aec8-ffe5d849b0bb	{"title":"174854","filename_download":"174854.png","type":"image/png","storage":"local"}	{"title":"174854","filename_download":"174854.png","type":"image/png","storage":"local"}	\N
140	169	languages	3	{"link":"https://developer.mozilla.org/fr/docs/Web/HTML","logo":"7b39f430-ce41-40a9-aec8-ffe5d849b0bb","name":"HTML"}	{"link":"https://developer.mozilla.org/fr/docs/Web/HTML","logo":"7b39f430-ce41-40a9-aec8-ffe5d849b0bb","name":"HTML"}	\N
141	170	directus_files	85670c85-30d0-4ba7-a19e-8cbde6b11d09	{"title":"Cs S3 Logo.svg","filename_download":"CSS3_logo.svg.png","type":"image/png","storage":"local"}	{"title":"Cs S3 Logo.svg","filename_download":"CSS3_logo.svg.png","type":"image/png","storage":"local"}	\N
142	171	languages	4	{"name":"CSS","logo":"85670c85-30d0-4ba7-a19e-8cbde6b11d09","link":"https://developer.mozilla.org/fr/docs/Web/CSS"}	{"name":"CSS","logo":"85670c85-30d0-4ba7-a19e-8cbde6b11d09","link":"https://developer.mozilla.org/fr/docs/Web/CSS"}	\N
143	172	projects_languages	2	{"projects_id":"1","languages_id":{"id":3}}	{"projects_id":"1","languages_id":{"id":3}}	\N
144	173	projects_languages	3	{"projects_id":"1","languages_id":{"id":4}}	{"projects_id":"1","languages_id":{"id":4}}	\N
145	175	projects	2	{"name":"EpyTodo","title":"A todo list REST API","body":" Created a NodeJS REST API with Express and a MySQL server. I used Docker to deploy it has a full-stack app, React in front-end making HTTP requests to the API wich served has backend. "}	{"name":"EpyTodo","title":"A todo list REST API","body":" Created a NodeJS REST API with Express and a MySQL server. I used Docker to deploy it has a full-stack app, React in front-end making HTTP requests to the API wich served has backend. "}	\N
146	176	projects_languages	4	{"projects_id":"2","languages_id":{"id":2}}	{"projects_id":"2","languages_id":{"id":2}}	149
147	177	projects_languages	5	{"projects_id":"2","languages_id":{"id":3}}	{"projects_id":"2","languages_id":{"id":3}}	149
148	178	projects_languages	6	{"projects_id":"2","languages_id":{"id":4}}	{"projects_id":"2","languages_id":{"id":4}}	149
161	191	directus_fields	53	{"interface":"input","special":null,"collection":"profile","field":"github"}	{"interface":"input","special":null,"collection":"profile","field":"github"}	\N
162	192	directus_fields	54	{"interface":"input","special":null,"collection":"profile","field":"stackoverflow"}	{"interface":"input","special":null,"collection":"profile","field":"stackoverflow"}	\N
165	195	directus_fields	56	{"interface":"input","special":null,"collection":"lang","field":"name"}	{"interface":"input","special":null,"collection":"lang","field":"name"}	\N
167	197	lang	fr	{"code":"fr","name":"Français"}	{"code":"fr","name":"Français"}	\N
149	179	projects	2	{"id":2,"name":"EpyTodo","title":"A todo list REST API","github":"https://github.com/gummyWalrus/EpyTodo","body":" Created a NodeJS REST API with Express and a MySQL server. I used Docker to deploy it has a full-stack app, React in front-end making HTTP requests to the API wich served has backend. ","tags":"[\\n    {\\n        \\"name\\": \\"React\\",\\n        \\"icon\\": \\"fa-brands fa-react\\",\\n        \\"link\\": \\"https://fr.reactjs.org/\\"\\n    },\\n    {\\n        \\"name\\": \\"NodeJS\\",\\n        \\"icon\\": \\"fa-brands fa-node-js\\",\\n        \\"link\\": \\"https://nodejs.org/en/about/\\"\\n    },\\n    {\\n        \\"name\\": \\"MySQL\\",\\n        \\"icon\\": \\"fa-solid fa-database\\",\\n        \\"link\\": \\"https://www.mysql.com/fr/\\"\\n    }\\n]","languages":[4,5,6]}	{"github":"https://github.com/gummyWalrus/EpyTodo","tags":"[\\n    {\\n        \\"name\\": \\"React\\",\\n        \\"icon\\": \\"fa-brands fa-react\\",\\n        \\"link\\": \\"https://fr.reactjs.org/\\"\\n    },\\n    {\\n        \\"name\\": \\"NodeJS\\",\\n        \\"icon\\": \\"fa-brands fa-node-js\\",\\n        \\"link\\": \\"https://nodejs.org/en/about/\\"\\n    },\\n    {\\n        \\"name\\": \\"MySQL\\",\\n        \\"icon\\": \\"fa-solid fa-database\\",\\n        \\"link\\": \\"https://www.mysql.com/fr/\\"\\n    }\\n]"}	\N
150	180	projects	1	{"id":1,"name":"Plannifii","title":"A shores planner web app","github":"https://github.com/gummyWalrus/Plannifii","body":"Created and deployed a Django web app on Heroku and using Docker on a VPS. The app includes a premium version wich adds a permission system. ","tags":"[\\n    {\\n        \\"name\\": \\"Stripe API\\",\\n        \\"icon\\": \\"fa-brands fa-stripe-s\\",\\n        \\"link\\": \\"https://stripe.com\\"\\n    },\\n    {\\n        \\"name\\": \\"Django\\",\\n        \\"icon\\": \\"fa-brands fa-python\\",\\n        \\"link\\": \\"https://www.djangoproject.com/\\"\\n    },\\n    {\\n        \\"name\\": \\"Postgres\\",\\n        \\"icon\\": \\"fa-brands fa-docker\\",\\n        \\"link\\": \\"https://www.docker.com/\\"\\n    }\\n]","languages":[1,2,3]}	{"tags":"[\\n    {\\n        \\"name\\": \\"Stripe API\\",\\n        \\"icon\\": \\"fa-brands fa-stripe-s\\",\\n        \\"link\\": \\"https://stripe.com\\"\\n    },\\n    {\\n        \\"name\\": \\"Django\\",\\n        \\"icon\\": \\"fa-brands fa-python\\",\\n        \\"link\\": \\"https://www.djangoproject.com/\\"\\n    },\\n    {\\n        \\"name\\": \\"Postgres\\",\\n        \\"icon\\": \\"fa-brands fa-docker\\",\\n        \\"link\\": \\"https://www.docker.com/\\"\\n    }\\n]"}	\N
151	181	projects	1	{"id":1,"name":"Plannifii","title":"A shores planner web app","github":"https://github.com/gummyWalrus/Plannifii","body":"Created and deployed a Django web app on Heroku and using Docker on a VPS. The app includes a premium version wich adds a permission system. ","tags":"[\\n    {\\n        \\"name\\": \\"Stripe API\\",\\n        \\"icon\\": \\"fa-brands fa-stripe-s\\",\\n        \\"link\\": \\"https://stripe.com\\"\\n    },\\n    {\\n        \\"name\\": \\"Django\\",\\n        \\"icon\\": \\"fa-brands fa-python\\",\\n        \\"link\\": \\"https://www.djangoproject.com/\\"\\n    },\\n    {\\n        \\"name\\": \\"Docker\\",\\n        \\"icon\\": \\"fa-brands fa-docker\\",\\n        \\"link\\": \\"https://www.docker.com/\\"\\n    }\\n]","languages":[1,2,3]}	{"tags":"[\\n    {\\n        \\"name\\": \\"Stripe API\\",\\n        \\"icon\\": \\"fa-brands fa-stripe-s\\",\\n        \\"link\\": \\"https://stripe.com\\"\\n    },\\n    {\\n        \\"name\\": \\"Django\\",\\n        \\"icon\\": \\"fa-brands fa-python\\",\\n        \\"link\\": \\"https://www.djangoproject.com/\\"\\n    },\\n    {\\n        \\"name\\": \\"Docker\\",\\n        \\"icon\\": \\"fa-brands fa-docker\\",\\n        \\"link\\": \\"https://www.docker.com/\\"\\n    }\\n]"}	\N
155	185	projects	3	{"name":"City Supplier","title":"A participative web app for the Hackatown 2021","github":"https://github.com/gummyWalrus/Hackatown2021-citysupplier","body":"I developed this app with a few mates using Django during the Hackatown 2021. We used PostgreSQL as SQL server. ","languages":{"create":[{"projects_id":"+","languages_id":{"id":1}},{"projects_id":"+","languages_id":{"id":3}},{"projects_id":"+","languages_id":{"id":4}}],"update":[],"delete":[]},"tags":"[\\n    {\\n    \\t\\"name\\": \\"Django\\",\\n        \\"icon\\": \\"fa-\\n    }\\n]"}	{"name":"City Supplier","title":"A participative web app for the Hackatown 2021","github":"https://github.com/gummyWalrus/Hackatown2021-citysupplier","body":"I developed this app with a few mates using Django during the Hackatown 2021. We used PostgreSQL as SQL server. ","languages":{"create":[{"projects_id":"+","languages_id":{"id":1}},{"projects_id":"+","languages_id":{"id":3}},{"projects_id":"+","languages_id":{"id":4}}],"update":[],"delete":[]},"tags":"[\\n    {\\n    \\t\\"name\\": \\"Django\\",\\n        \\"icon\\": \\"fa-\\n    }\\n]"}	\N
152	182	projects_languages	7	{"projects_id":3,"languages_id":{"id":1}}	{"projects_id":3,"languages_id":{"id":1}}	155
153	183	projects_languages	8	{"projects_id":3,"languages_id":{"id":3}}	{"projects_id":3,"languages_id":{"id":3}}	155
154	184	projects_languages	9	{"projects_id":3,"languages_id":{"id":4}}	{"projects_id":3,"languages_id":{"id":4}}	155
156	186	projects	3	{"id":3,"name":"City Supplier","title":"A participative web app for the Hackatown 2021","github":"https://github.com/gummyWalrus/Hackatown2021-citysupplier","body":"I developed this app with a few mates using Django during the Hackatown 2021. We used PostgreSQL as SQL server. ","tags":"[\\n    {\\n        \\"name\\": \\"Django\\",\\n        \\"icon\\": \\"fa-brands fa-python\\",\\n        \\"link\\": \\"https://www.djangoproject.com/\\"\\n    },\\n    {\\n        \\"name\\": \\"Postgres\\",\\n        \\"icon\\": \\"fa-solid fa-database\\",\\n        \\"link\\": \\"http://postgresql.org\\"\\n    },\\n    {\\n        \\"name\\": \\"Heroku\\",\\n        \\"icon\\": \\"fa-solid fa-server\\",\\n        \\"link\\": \\"https://heroku.com\\"\\n    }\\n]","languages":[7,8,9]}	{"tags":"[\\n    {\\n        \\"name\\": \\"Django\\",\\n        \\"icon\\": \\"fa-brands fa-python\\",\\n        \\"link\\": \\"https://www.djangoproject.com/\\"\\n    },\\n    {\\n        \\"name\\": \\"Postgres\\",\\n        \\"icon\\": \\"fa-solid fa-database\\",\\n        \\"link\\": \\"http://postgresql.org\\"\\n    },\\n    {\\n        \\"name\\": \\"Heroku\\",\\n        \\"icon\\": \\"fa-solid fa-server\\",\\n        \\"link\\": \\"https://heroku.com\\"\\n    }\\n]"}	\N
157	187	directus_fields	50	{"interface":"input","special":null,"collection":"profile","field":"linkedin"}	{"interface":"input","special":null,"collection":"profile","field":"linkedin"}	\N
158	188	profile	1	{"id":1,"nom":"Loys Caucheteux","poste":"Développeur Full-stack","description":"Hello, I'm Loys, I'm passionated about computing since I'm 12\\n\\nI've been tinkering with a lot of different programming languages. \\n\\nI have the habit to learn by myself and from others, that's why I fit easily in new environnements. ","logo":"03c8d29d-fc5a-429b-9299-60eb7fcb8a51","linkedin":"https://www.linkedin.com/in/loys-caucheteux-a99655205/"}	{"linkedin":"https://www.linkedin.com/in/loys-caucheteux-a99655205/"}	\N
159	189	directus_fields	51	{"interface":"input","special":null,"collection":"profile","field":"phone"}	{"interface":"input","special":null,"collection":"profile","field":"phone"}	\N
160	190	directus_fields	52	{"interface":"input","special":null,"collection":"profile","field":"email"}	{"interface":"input","special":null,"collection":"profile","field":"email"}	\N
163	193	directus_fields	55	{"interface":"input","readonly":false,"hidden":false,"field":"code","collection":"lang"}	{"interface":"input","readonly":false,"hidden":false,"field":"code","collection":"lang"}	\N
164	194	directus_collections	lang	{"singleton":false,"collection":"lang"}	{"singleton":false,"collection":"lang"}	\N
168	199	directus_fields	57	{"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"profile_translation"}	{"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"profile_translation"}	\N
169	200	directus_collections	profile_translation	{"singleton":false,"collection":"profile_translation"}	{"singleton":false,"collection":"profile_translation"}	\N
170	201	directus_fields	58	{"interface":"input","special":null,"collection":"profile_translation","field":"poste"}	{"interface":"input","special":null,"collection":"profile_translation","field":"poste"}	\N
171	202	directus_fields	59	{"interface":"input-rich-text-md","special":null,"collection":"profile_translation","field":"description"}	{"interface":"input-rich-text-md","special":null,"collection":"profile_translation","field":"description"}	\N
172	203	directus_fields	60	{"interface":"input","special":null,"collection":"profile_translation","field":"phone"}	{"interface":"input","special":null,"collection":"profile_translation","field":"phone"}	\N
173	204	directus_fields	61	{"interface":"select-dropdown-m2o","special":["m2o"],"collection":"profile_translation","field":"language_code"}	{"interface":"select-dropdown-m2o","special":["m2o"],"collection":"profile_translation","field":"language_code"}	\N
174	205	directus_fields	62	{"hidden":true,"field":"id","collection":"profile_translation_translations"}	{"hidden":true,"field":"id","collection":"profile_translation_translations"}	\N
175	206	directus_collections	profile_translation_translations	{"hidden":true,"icon":"import_export","collection":"profile_translation_translations"}	{"hidden":true,"icon":"import_export","collection":"profile_translation_translations"}	\N
176	207	directus_fields	63	{"hidden":true,"collection":"profile_translation_translations","field":"profile_translation_id"}	{"hidden":true,"collection":"profile_translation_translations","field":"profile_translation_id"}	\N
177	208	directus_fields	64	{"hidden":true,"collection":"profile_translation_translations","field":"languages_id"}	{"hidden":true,"collection":"profile_translation_translations","field":"languages_id"}	\N
178	209	directus_fields	65	{"interface":"select-dropdown-m2o","special":["m2o"],"collection":"profile_translation","field":"profile"}	{"interface":"select-dropdown-m2o","special":["m2o"],"collection":"profile_translation","field":"profile"}	\N
179	210	directus_fields	66	{"hidden":true,"field":"id","collection":"profile_translation_translations_1"}	{"hidden":true,"field":"id","collection":"profile_translation_translations_1"}	\N
180	211	directus_collections	profile_translation_translations_1	{"hidden":true,"icon":"import_export","collection":"profile_translation_translations_1"}	{"hidden":true,"icon":"import_export","collection":"profile_translation_translations_1"}	\N
181	212	directus_fields	67	{"hidden":true,"collection":"profile_translation_translations_1","field":"profile_translation_id"}	{"hidden":true,"collection":"profile_translation_translations_1","field":"profile_translation_id"}	\N
182	213	directus_fields	68	{"hidden":true,"collection":"profile_translation_translations_1","field":"languages_id"}	{"hidden":true,"collection":"profile_translation_translations_1","field":"languages_id"}	\N
183	214	directus_fields	69	{"interface":"translations","special":["translations"],"options":{"languageField":"code","languageDirectionField":"name","defaultLanguage":"en"},"collection":"profile","field":"translations"}	{"interface":"translations","special":["translations"],"options":{"languageField":"code","languageDirectionField":"name","defaultLanguage":"en"},"collection":"profile","field":"translations"}	\N
184	215	directus_fields	70	{"hidden":true,"field":"id","collection":"profile_translations"}	{"hidden":true,"field":"id","collection":"profile_translations"}	\N
185	216	directus_collections	profile_translations	{"hidden":true,"icon":"import_export","collection":"profile_translations"}	{"hidden":true,"icon":"import_export","collection":"profile_translations"}	\N
186	217	directus_fields	71	{"hidden":true,"collection":"profile_translations","field":"profile_id"}	{"hidden":true,"collection":"profile_translations","field":"profile_id"}	\N
187	218	directus_fields	72	{"hidden":true,"collection":"profile_translations","field":"lang_code"}	{"hidden":true,"collection":"profile_translations","field":"lang_code"}	\N
188	219	directus_collections	profile	{"collection":"profile","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open"}	{"singleton":false}	\N
192	223	directus_collections	profile	{"collection":"profile","icon":null,"note":null,"display_template":"{{translations}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":null,"group":null,"collapse":"open"}	{"display_template":"{{translations}}","item_duplication_fields":[]}	\N
193	224	directus_collections	profile	{"collection":"profile","icon":null,"note":null,"display_template":"{{email}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":null,"group":null,"collapse":"open"}	{"display_template":"{{email}}"}	\N
194	225	directus_fields	73	{"interface":"translations","special":["translations"],"collection":"profile","field":"translations"}	{"interface":"translations","special":["translations"],"collection":"profile","field":"translations"}	\N
195	226	directus_fields	74	{"hidden":true,"field":"id","collection":"profile_translations_1"}	{"hidden":true,"field":"id","collection":"profile_translations_1"}	\N
196	227	directus_collections	profile_translations_1	{"hidden":true,"icon":"import_export","collection":"profile_translations_1"}	{"hidden":true,"icon":"import_export","collection":"profile_translations_1"}	\N
197	228	directus_fields	75	{"hidden":true,"collection":"profile_translations_1","field":"profile_id"}	{"hidden":true,"collection":"profile_translations_1","field":"profile_id"}	\N
198	229	directus_fields	76	{"hidden":true,"collection":"profile_translations_1","field":"lang_code"}	{"hidden":true,"collection":"profile_translations_1","field":"lang_code"}	\N
199	235	directus_fields	77	{"interface":"translations","special":["translations"],"options":{"languageField":"code","languageDirectionField":"name","defaultLanguage":"en"},"collection":"profile","field":"translations"}	{"interface":"translations","special":["translations"],"options":{"languageField":"code","languageDirectionField":"name","defaultLanguage":"en"},"collection":"profile","field":"translations"}	\N
200	236	directus_fields	78	{"hidden":true,"field":"id","collection":"profile_translations"}	{"hidden":true,"field":"id","collection":"profile_translations"}	\N
201	237	directus_collections	profile_translations	{"hidden":true,"icon":"import_export","collection":"profile_translations"}	{"hidden":true,"icon":"import_export","collection":"profile_translations"}	\N
202	238	directus_fields	79	{"hidden":true,"collection":"profile_translations","field":"profile_id"}	{"hidden":true,"collection":"profile_translations","field":"profile_id"}	\N
203	239	directus_fields	80	{"hidden":true,"collection":"profile_translations","field":"lang_code"}	{"hidden":true,"collection":"profile_translations","field":"lang_code"}	\N
204	240	directus_fields	81	{"interface":"input","special":null,"collection":"profile","field":"phone"}	{"interface":"input","special":null,"collection":"profile","field":"phone"}	\N
205	241	directus_fields	82	{"interface":"input","special":null,"collection":"profile_translations","field":"poste"}	{"interface":"input","special":null,"collection":"profile_translations","field":"poste"}	\N
206	242	directus_fields	83	{"interface":"input","special":null,"collection":"profile_translations","field":"description"}	{"interface":"input","special":null,"collection":"profile_translations","field":"description"}	\N
207	243	directus_fields	84	{"interface":"input","special":null,"collection":"profile","field":"name"}	{"interface":"input","special":null,"collection":"profile","field":"name"}	\N
208	244	directus_fields	85	{"interface":"input-rich-text-md","special":null,"collection":"profile_translations","field":"description"}	{"interface":"input-rich-text-md","special":null,"collection":"profile_translations","field":"description"}	\N
209	245	profile_translations	1	{"poste":"Full-stack Developer","lang_code":{"code":"en"},"profile_id":"1"}	{"poste":"Full-stack Developer","lang_code":{"code":"en"},"profile_id":"1"}	\N
210	247	profile_translations	1	{"id":1,"profile_id":1,"lang_code":"en","poste":"Full-stack Developer","description":"Hello, I'm Loys, I'm passionated about computing since I'm 12\\n\\nI've been tinkering with a lot of different programming languages.\\n\\nI have the habit to learn by myself and from others, that's why I fit easily in new environnements.\\n"}	{"profile_id":"1","lang_code":"en","description":"Hello, I'm Loys, I'm passionated about computing since I'm 12\\n\\nI've been tinkering with a lot of different programming languages.\\n\\nI have the habit to learn by myself and from others, that's why I fit easily in new environnements.\\n"}	\N
211	249	profile_translations	2	{"poste":"Développeur Full-stack","lang_code":{"code":"fr"},"profile_id":"1","description":"Passionné d’informatique depuis mes 12 ans,\\n\\nje profite de ma curiosité naturelle pour me former en autodidacte à de multiples langages de programmation.\\n\\nCette curiosité me donne envie d’apprendre des autres et de mon environnement,\\nc’est ce qui fait toute mon adaptabilité. "}	{"poste":"Développeur Full-stack","lang_code":{"code":"fr"},"profile_id":"1","description":"Passionné d’informatique depuis mes 12 ans,\\n\\nje profite de ma curiosité naturelle pour me former en autodidacte à de multiples langages de programmation.\\n\\nCette curiosité me donne envie d’apprendre des autres et de mon environnement,\\nc’est ce qui fait toute mon adaptabilité. "}	\N
212	251	directus_collections	profile_translations	{"collection":"profile_translations","icon":"import_export","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open"}	{"hidden":false}	\N
213	252	directus_collections	profile	{"collection":"profile","icon":null,"note":null,"display_template":"{{email}}{{translations}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":null,"group":null,"collapse":"open"}	{"display_template":"{{email}}{{translations}}"}	\N
214	253	directus_permissions	27	{"role":null,"collection":"profile_translations","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"profile_translations","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
215	255	directus_fields	86	{"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"profile_section"}	{"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"profile_section"}	\N
216	256	directus_fields	87	{"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"profile_section"}	{"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"profile_section"}	\N
243	286	directus_fields	108	{"hidden":true,"field":"id","collection":"projects_translations"}	{"hidden":true,"field":"id","collection":"projects_translations"}	\N
217	257	directus_fields	88	{"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"profile_section"}	{"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"profile_section"}	\N
218	258	directus_collections	profile_section	{"singleton":false,"collection":"profile_section"}	{"singleton":false,"collection":"profile_section"}	\N
219	259	directus_fields	89	{"interface":"input","special":null,"collection":"profile_section","field":"title"}	{"interface":"input","special":null,"collection":"profile_section","field":"title"}	\N
220	260	directus_fields	90	{"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"profile_section_item"}	{"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"profile_section_item"}	\N
221	261	directus_fields	91	{"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"profile_section_item"}	{"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"profile_section_item"}	\N
222	262	directus_fields	92	{"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"profile_section_item"}	{"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"profile_section_item"}	\N
223	263	directus_collections	profile_section_item	{"singleton":false,"collection":"profile_section_item"}	{"singleton":false,"collection":"profile_section_item"}	\N
224	264	directus_fields	93	{"interface":"list-o2m","special":["o2m"],"collection":"profile_section","field":"items"}	{"interface":"list-o2m","special":["o2m"],"collection":"profile_section","field":"items"}	\N
225	265	directus_fields	94	{"interface":"input","special":null,"collection":"profile_section_item","field":"title"}	{"interface":"input","special":null,"collection":"profile_section_item","field":"title"}	\N
226	266	directus_fields	95	{"interface":"input","special":null,"collection":"profile_section_item","field":"subtitle"}	{"interface":"input","special":null,"collection":"profile_section_item","field":"subtitle"}	\N
227	267	directus_fields	96	{"interface":"file-image","special":["file"],"collection":"profile_section_item","field":"image"}	{"interface":"file-image","special":["file"],"collection":"profile_section_item","field":"image"}	\N
228	268	directus_fields	97	{"interface":"translations","special":["translations"],"options":{"languageField":"code","languageDirectionField":"name"},"collection":"projects","field":"translations"}	{"interface":"translations","special":["translations"],"options":{"languageField":"code","languageDirectionField":"name"},"collection":"projects","field":"translations"}	\N
229	269	directus_fields	98	{"hidden":true,"field":"id","collection":"projects_translations"}	{"hidden":true,"field":"id","collection":"projects_translations"}	\N
230	270	directus_collections	projects_translations	{"hidden":true,"icon":"import_export","collection":"projects_translations"}	{"hidden":true,"icon":"import_export","collection":"projects_translations"}	\N
231	271	directus_fields	99	{"hidden":true,"collection":"projects_translations","field":"projects_id"}	{"hidden":true,"collection":"projects_translations","field":"projects_id"}	\N
232	272	directus_fields	100	{"hidden":true,"collection":"projects_translations","field":"lang_code"}	{"hidden":true,"collection":"projects_translations","field":"lang_code"}	\N
233	273	directus_fields	97	{"id":97,"collection":"projects","field":"translations","special":["translations"],"interface":"translations","options":{"languageField":"code","languageDirectionField":"name","defaultLanguage":"en"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"projects","field":"translations","special":["translations"],"interface":"translations","options":{"languageField":"code","languageDirectionField":"name","defaultLanguage":"en"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	\N
234	274	directus_fields	101	{"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"projects_translation"}	{"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"projects_translation"}	\N
235	275	directus_collections	projects_translation	{"singleton":false,"collection":"projects_translation"}	{"singleton":false,"collection":"projects_translation"}	\N
236	276	directus_fields	102	{"interface":"select-dropdown-m2o","special":["m2o"],"options":{"template":"{{name}}"},"collection":"projects_translation","field":"project_id"}	{"interface":"select-dropdown-m2o","special":["m2o"],"options":{"template":"{{name}}"},"collection":"projects_translation","field":"project_id"}	\N
237	278	directus_fields	103	{"interface":"translations","special":["translations"],"options":{"languageField":"code","languageDirectionField":"name","defaultLanguage":"en"},"collection":"projects","field":"translations"}	{"interface":"translations","special":["translations"],"options":{"languageField":"code","languageDirectionField":"name","defaultLanguage":"en"},"collection":"projects","field":"translations"}	\N
238	279	directus_fields	104	{"hidden":true,"field":"id","collection":"projects_translations_1"}	{"hidden":true,"field":"id","collection":"projects_translations_1"}	\N
239	280	directus_collections	projects_translations_1	{"hidden":true,"icon":"import_export","collection":"projects_translations_1"}	{"hidden":true,"icon":"import_export","collection":"projects_translations_1"}	\N
240	281	directus_fields	105	{"hidden":true,"collection":"projects_translations_1","field":"projects_id"}	{"hidden":true,"collection":"projects_translations_1","field":"projects_id"}	\N
241	282	directus_fields	106	{"hidden":true,"collection":"projects_translations_1","field":"lang_code"}	{"hidden":true,"collection":"projects_translations_1","field":"lang_code"}	\N
242	285	directus_fields	107	{"interface":"translations","special":["translations"],"options":{"languageField":"code","languageDirectionField":"name","defaultLanguage":"en"},"collection":"projects","field":"translations"}	{"interface":"translations","special":["translations"],"options":{"languageField":"code","languageDirectionField":"name","defaultLanguage":"en"},"collection":"projects","field":"translations"}	\N
244	287	directus_collections	projects_translations	{"hidden":true,"icon":"import_export","collection":"projects_translations"}	{"hidden":true,"icon":"import_export","collection":"projects_translations"}	\N
245	288	directus_fields	109	{"hidden":true,"collection":"projects_translations","field":"projects_id"}	{"hidden":true,"collection":"projects_translations","field":"projects_id"}	\N
247	290	directus_collections	projects_translations	{"collection":"projects_translations","icon":"import_export","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open"}	{"hidden":false}	\N
248	291	directus_collections	comments	{"collection":"comments","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open"}	{"sort":1,"group":null}	\N
249	292	directus_collections	lang	{"collection":"lang","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open"}	{"sort":2,"group":null}	\N
250	293	directus_collections	languages	{"collection":"languages","icon":null,"note":null,"display_template":"{{name}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open"}	{"sort":3,"group":null}	\N
251	294	directus_collections	links	{"collection":"links","icon":null,"note":null,"display_template":"{{name}}{{link}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":4,"group":null,"collapse":"open"}	{"sort":4,"group":null}	\N
252	295	directus_collections	profile	{"collection":"profile","icon":null,"note":null,"display_template":"{{email}}{{translations}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":5,"group":null,"collapse":"open"}	{"sort":5,"group":null}	\N
253	296	directus_collections	profile_section	{"collection":"profile_section","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":6,"group":null,"collapse":"open"}	{"sort":6,"group":null}	\N
254	297	directus_collections	profile_section_item	{"collection":"profile_section_item","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":7,"group":null,"collapse":"open"}	{"sort":7,"group":null}	\N
255	298	directus_collections	profile_translations	{"collection":"profile_translations","icon":"import_export","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":8,"group":null,"collapse":"open"}	{"sort":8,"group":null}	\N
256	299	directus_collections	projects_languages	{"collection":"projects_languages","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":9,"group":null,"collapse":"open"}	{"sort":9,"group":null}	\N
257	300	directus_collections	projects_links	{"collection":"projects_links","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":10,"group":null,"collapse":"open"}	{"sort":10,"group":null}	\N
258	301	directus_collections	projects_translations	{"collection":"projects_translations","icon":"import_export","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":11,"group":null,"collapse":"open"}	{"sort":11,"group":null}	\N
259	302	directus_collections	projects	{"collection":"projects","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":12,"group":null,"collapse":"open"}	{"sort":12,"group":null}	\N
261	304	directus_collections	comments	{"collection":"comments","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open"}	{"sort":1,"group":null}	\N
262	305	directus_collections	lang	{"collection":"lang","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open"}	{"sort":2,"group":null}	\N
263	306	directus_collections	languages	{"collection":"languages","icon":null,"note":null,"display_template":"{{name}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open"}	{"sort":3,"group":null}	\N
442	490	directus_fields	119	{"interface":"select-dropdown-m2o","special":["m2o"],"required":true,"options":{"template":"{{email}}"},"collection":"profile_section","field":"profile"}	{"interface":"select-dropdown-m2o","special":["m2o"],"required":true,"options":{"template":"{{email}}"},"collection":"profile_section","field":"profile"}	\N
246	289	directus_fields	110	{"hidden":true,"collection":"projects_translations","field":"lang_code"}	{"hidden":true,"collection":"projects_translations","field":"lang_code"}	\N
260	303	directus_collections	profile_translations	{"collection":"profile_translations","icon":"import_export","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"links","collapse":"open"}	{"sort":1,"group":"links"}	\N
272	315	directus_collections	comments	{"collection":"comments","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open"}	{"sort":1,"group":null}	\N
273	316	directus_collections	lang	{"collection":"lang","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open"}	{"sort":2,"group":null}	\N
274	317	directus_collections	languages	{"collection":"languages","icon":null,"note":null,"display_template":"{{name}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open"}	{"sort":3,"group":null}	\N
275	318	directus_collections	links	{"collection":"links","icon":null,"note":null,"display_template":"{{name}}{{link}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":4,"group":null,"collapse":"open"}	{"sort":4,"group":null}	\N
276	319	directus_collections	profile_translations	{"collection":"profile_translations","icon":"import_export","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":5,"group":null,"collapse":"open"}	{"sort":5,"group":null}	\N
277	320	directus_collections	profile	{"collection":"profile","icon":null,"note":null,"display_template":"{{email}}{{translations}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":6,"group":null,"collapse":"open"}	{"sort":6,"group":null}	\N
278	321	directus_collections	profile_section	{"collection":"profile_section","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":7,"group":null,"collapse":"open"}	{"sort":7,"group":null}	\N
279	322	directus_collections	profile_section_item	{"collection":"profile_section_item","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":8,"group":null,"collapse":"open"}	{"sort":8,"group":null}	\N
280	323	directus_collections	projects_languages	{"collection":"projects_languages","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":9,"group":null,"collapse":"open"}	{"sort":9,"group":null}	\N
281	324	directus_collections	projects_links	{"collection":"projects_links","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":10,"group":null,"collapse":"open"}	{"sort":10,"group":null}	\N
282	325	directus_collections	projects_translations	{"collection":"projects_translations","icon":"import_export","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":11,"group":null,"collapse":"open"}	{"sort":11,"group":null}	\N
283	326	directus_collections	projects	{"collection":"projects","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":12,"group":null,"collapse":"open"}	{"sort":12,"group":null}	\N
284	327	directus_collections	comments	{"collection":"comments","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open"}	{"sort":1,"group":null}	\N
285	328	directus_collections	lang	{"collection":"lang","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open"}	{"sort":2,"group":null}	\N
286	329	directus_collections	languages	{"collection":"languages","icon":null,"note":null,"display_template":"{{name}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open"}	{"sort":3,"group":null}	\N
287	330	directus_collections	links	{"collection":"links","icon":null,"note":null,"display_template":"{{name}}{{link}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":4,"group":null,"collapse":"open"}	{"sort":4,"group":null}	\N
264	307	directus_collections	links	{"collection":"links","icon":null,"note":null,"display_template":"{{name}}{{link}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":4,"group":null,"collapse":"open"}	{"sort":4,"group":null}	\N
265	308	directus_collections	profile	{"collection":"profile","icon":null,"note":null,"display_template":"{{email}}{{translations}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":5,"group":null,"collapse":"open"}	{"sort":5,"group":null}	\N
266	309	directus_collections	profile_section	{"collection":"profile_section","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":6,"group":null,"collapse":"open"}	{"sort":6,"group":null}	\N
267	310	directus_collections	profile_section_item	{"collection":"profile_section_item","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":7,"group":null,"collapse":"open"}	{"sort":7,"group":null}	\N
268	311	directus_collections	projects_languages	{"collection":"projects_languages","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":8,"group":null,"collapse":"open"}	{"sort":8,"group":null}	\N
269	312	directus_collections	projects_links	{"collection":"projects_links","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":9,"group":null,"collapse":"open"}	{"sort":9,"group":null}	\N
270	313	directus_collections	projects_translations	{"collection":"projects_translations","icon":"import_export","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":10,"group":null,"collapse":"open"}	{"sort":10,"group":null}	\N
271	314	directus_collections	projects	{"collection":"projects","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":11,"group":null,"collapse":"open"}	{"sort":11,"group":null}	\N
288	331	directus_collections	profile	{"collection":"profile","icon":null,"note":null,"display_template":"{{email}}{{translations}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":5,"group":null,"collapse":"open"}	{"sort":5,"group":null}	\N
289	332	directus_collections	profile_translations	{"collection":"profile_translations","icon":"import_export","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":6,"group":null,"collapse":"open"}	{"sort":6,"group":null}	\N
290	333	directus_collections	profile_section	{"collection":"profile_section","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":7,"group":null,"collapse":"open"}	{"sort":7,"group":null}	\N
291	334	directus_collections	profile_section_item	{"collection":"profile_section_item","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":8,"group":null,"collapse":"open"}	{"sort":8,"group":null}	\N
292	335	directus_collections	projects_languages	{"collection":"projects_languages","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":9,"group":null,"collapse":"open"}	{"sort":9,"group":null}	\N
293	336	directus_collections	projects_links	{"collection":"projects_links","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":10,"group":null,"collapse":"open"}	{"sort":10,"group":null}	\N
294	337	directus_collections	projects_translations	{"collection":"projects_translations","icon":"import_export","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":11,"group":null,"collapse":"open"}	{"sort":11,"group":null}	\N
295	338	directus_collections	projects	{"collection":"projects","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":12,"group":null,"collapse":"open"}	{"sort":12,"group":null}	\N
296	339	directus_collections	profile_translations	{"collection":"profile_translations","icon":"import_export","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"profile","collapse":"open"}	{"sort":1,"group":"profile"}	\N
297	340	directus_collections	comments	{"collection":"comments","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open"}	{"sort":1,"group":null}	\N
298	341	directus_collections	lang	{"collection":"lang","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open"}	{"sort":2,"group":null}	\N
299	342	directus_collections	languages	{"collection":"languages","icon":null,"note":null,"display_template":"{{name}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open"}	{"sort":3,"group":null}	\N
300	343	directus_collections	links	{"collection":"links","icon":null,"note":null,"display_template":"{{name}}{{link}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":4,"group":null,"collapse":"open"}	{"sort":4,"group":null}	\N
301	344	directus_collections	profile	{"collection":"profile","icon":null,"note":null,"display_template":"{{email}}{{translations}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":5,"group":null,"collapse":"open"}	{"sort":5,"group":null}	\N
302	345	directus_collections	profile_section	{"collection":"profile_section","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":6,"group":null,"collapse":"open"}	{"sort":6,"group":null}	\N
303	346	directus_collections	profile_section_item	{"collection":"profile_section_item","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":7,"group":null,"collapse":"open"}	{"sort":7,"group":null}	\N
304	347	directus_collections	projects_languages	{"collection":"projects_languages","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":8,"group":null,"collapse":"open"}	{"sort":8,"group":null}	\N
443	491	directus_fields	120	{"interface":"list-o2m","special":["o2m"],"required":false,"collection":"profile","field":"sections"}	{"interface":"list-o2m","special":["o2m"],"required":false,"collection":"profile","field":"sections"}	\N
305	348	directus_collections	projects_links	{"collection":"projects_links","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":9,"group":null,"collapse":"open"}	{"sort":9,"group":null}	\N
306	349	directus_collections	projects_translations	{"collection":"projects_translations","icon":"import_export","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":10,"group":null,"collapse":"open"}	{"sort":10,"group":null}	\N
307	350	directus_collections	projects	{"collection":"projects","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":11,"group":null,"collapse":"open"}	{"sort":11,"group":null}	\N
308	352	directus_collections	comments	{"collection":"comments","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open"}	{"sort":1,"group":null}	\N
310	353	directus_collections	lang	{"collection":"lang","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open"}	{"sort":2,"group":null}	\N
311	354	directus_collections	languages	{"collection":"languages","icon":null,"note":null,"display_template":"{{name}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open"}	{"sort":3,"group":null}	\N
312	355	directus_collections	links	{"collection":"links","icon":null,"note":null,"display_template":"{{name}}{{link}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":4,"group":null,"collapse":"open"}	{"sort":4,"group":null}	\N
313	356	directus_collections	profile	{"collection":"profile","icon":null,"note":null,"display_template":"{{email}}{{translations}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":5,"group":null,"collapse":"open"}	{"sort":5,"group":null}	\N
314	357	directus_collections	profile_section_item	{"collection":"profile_section_item","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":6,"group":null,"collapse":"open"}	{"sort":6,"group":null}	\N
315	358	directus_collections	projects_languages	{"collection":"projects_languages","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":7,"group":null,"collapse":"open"}	{"sort":7,"group":null}	\N
316	359	directus_collections	projects_links	{"collection":"projects_links","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":8,"group":null,"collapse":"open"}	{"sort":8,"group":null}	\N
317	360	directus_collections	projects_translations	{"collection":"projects_translations","icon":"import_export","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":9,"group":null,"collapse":"open"}	{"sort":9,"group":null}	\N
318	361	directus_collections	projects	{"collection":"projects","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":10,"group":null,"collapse":"open"}	{"sort":10,"group":null}	\N
319	363	directus_collections	comments	{"collection":"comments","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open"}	{"sort":1,"group":null}	\N
321	364	directus_collections	lang	{"collection":"lang","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open"}	{"sort":2,"group":null}	\N
323	366	directus_collections	languages	{"collection":"languages","icon":null,"note":null,"display_template":"{{name}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open"}	{"sort":3,"group":null}	\N
324	367	directus_collections	links	{"collection":"links","icon":null,"note":null,"display_template":"{{name}}{{link}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":4,"group":null,"collapse":"open"}	{"sort":4,"group":null}	\N
325	368	directus_collections	profile	{"collection":"profile","icon":null,"note":null,"display_template":"{{email}}{{translations}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":5,"group":null,"collapse":"open"}	{"sort":5,"group":null}	\N
309	351	directus_collections	profile_section	{"collection":"profile_section","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"profile_translations","collapse":"open"}	{"sort":1,"group":"profile_translations"}	\N
320	362	directus_collections	profile_section_item	{"collection":"profile_section_item","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"profile","collapse":"open"}	{"sort":1,"group":"profile"}	\N
322	365	directus_collections	profile_translations	{"collection":"profile_translations","icon":"import_export","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"profile","collapse":"open"}	{"sort":2,"group":"profile"}	\N
340	383	directus_collections	comments	{"collection":"comments","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open"}	{"sort":1,"group":null}	\N
342	385	directus_collections	lang	{"collection":"lang","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open"}	{"sort":2,"group":null}	\N
343	386	directus_collections	languages	{"collection":"languages","icon":null,"note":null,"display_template":"{{name}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open"}	{"sort":3,"group":null}	\N
344	387	directus_collections	links	{"collection":"links","icon":null,"note":null,"display_template":"{{name}}{{link}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":4,"group":null,"collapse":"open"}	{"sort":4,"group":null}	\N
345	388	directus_collections	profile_section_item	{"collection":"profile_section_item","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":5,"group":null,"collapse":"open"}	{"sort":5,"group":null}	\N
346	389	directus_collections	profile_section	{"collection":"profile_section","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":6,"group":null,"collapse":"open"}	{"sort":6,"group":null}	\N
347	390	directus_collections	profile	{"collection":"profile","icon":null,"note":null,"display_template":"{{email}}{{translations}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":7,"group":null,"collapse":"open"}	{"sort":7,"group":null}	\N
348	391	directus_collections	projects_languages	{"collection":"projects_languages","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":8,"group":null,"collapse":"open"}	{"sort":8,"group":null}	\N
349	392	directus_collections	projects_links	{"collection":"projects_links","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":9,"group":null,"collapse":"open"}	{"sort":9,"group":null}	\N
350	393	directus_collections	projects_translations	{"collection":"projects_translations","icon":"import_export","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":10,"group":null,"collapse":"open"}	{"sort":10,"group":null}	\N
351	394	directus_collections	projects	{"collection":"projects","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":11,"group":null,"collapse":"open"}	{"sort":11,"group":null}	\N
353	396	directus_collections	comments	{"collection":"comments","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open"}	{"sort":1,"group":null}	\N
355	398	directus_collections	lang	{"collection":"lang","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open"}	{"sort":2,"group":null}	\N
356	399	directus_collections	languages	{"collection":"languages","icon":null,"note":null,"display_template":"{{name}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open"}	{"sort":3,"group":null}	\N
444	492	directus_fields	121	{"interface":"list-o2m","special":["o2m"],"options":{"template":"{{title}}"},"collection":"profile_section","field":"items"}	{"interface":"list-o2m","special":["o2m"],"options":{"template":"{{title}}"},"collection":"profile_section","field":"items"}	\N
326	369	directus_collections	projects_languages	{"collection":"projects_languages","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":6,"group":null,"collapse":"open"}	{"sort":6,"group":null}	\N
327	370	directus_collections	projects_links	{"collection":"projects_links","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":7,"group":null,"collapse":"open"}	{"sort":7,"group":null}	\N
328	371	directus_collections	projects_translations	{"collection":"projects_translations","icon":"import_export","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":8,"group":null,"collapse":"open"}	{"sort":8,"group":null}	\N
329	372	directus_collections	projects	{"collection":"projects","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":9,"group":null,"collapse":"open"}	{"sort":9,"group":null}	\N
330	373	directus_collections	comments	{"collection":"comments","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open"}	{"sort":1,"group":null}	\N
331	374	directus_collections	lang	{"collection":"lang","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open"}	{"sort":2,"group":null}	\N
332	375	directus_collections	languages	{"collection":"languages","icon":null,"note":null,"display_template":"{{name}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open"}	{"sort":3,"group":null}	\N
333	376	directus_collections	links	{"collection":"links","icon":null,"note":null,"display_template":"{{name}}{{link}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":4,"group":null,"collapse":"open"}	{"sort":4,"group":null}	\N
334	377	directus_collections	profile_section	{"collection":"profile_section","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":5,"group":null,"collapse":"open"}	{"sort":5,"group":null}	\N
335	378	directus_collections	profile	{"collection":"profile","icon":null,"note":null,"display_template":"{{email}}{{translations}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":6,"group":null,"collapse":"open"}	{"sort":6,"group":null}	\N
336	379	directus_collections	projects_languages	{"collection":"projects_languages","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":7,"group":null,"collapse":"open"}	{"sort":7,"group":null}	\N
337	380	directus_collections	projects_links	{"collection":"projects_links","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":8,"group":null,"collapse":"open"}	{"sort":8,"group":null}	\N
338	381	directus_collections	projects_translations	{"collection":"projects_translations","icon":"import_export","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":9,"group":null,"collapse":"open"}	{"sort":9,"group":null}	\N
339	382	directus_collections	projects	{"collection":"projects","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":10,"group":null,"collapse":"open"}	{"sort":10,"group":null}	\N
341	384	directus_collections	profile_translations	{"collection":"profile_translations","icon":"import_export","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"profile","collapse":"open"}	{"sort":1,"group":"profile"}	\N
352	395	directus_collections	profile_section	{"collection":"profile_section","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"profile","collapse":"open"}	{"sort":1,"group":"profile"}	\N
354	397	directus_collections	profile_translations	{"collection":"profile_translations","icon":"import_export","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"profile","collapse":"open"}	{"sort":2,"group":"profile"}	\N
486	534	directus_permissions	32	{"role":null,"collection":"links","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"links","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
357	400	directus_collections	links	{"collection":"links","icon":null,"note":null,"display_template":"{{name}}{{link}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":4,"group":null,"collapse":"open"}	{"sort":4,"group":null}	\N
358	401	directus_collections	profile_section_item	{"collection":"profile_section_item","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":5,"group":null,"collapse":"open"}	{"sort":5,"group":null}	\N
359	402	directus_collections	profile	{"collection":"profile","icon":null,"note":null,"display_template":"{{email}}{{translations}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":6,"group":null,"collapse":"open"}	{"sort":6,"group":null}	\N
360	403	directus_collections	projects_languages	{"collection":"projects_languages","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":7,"group":null,"collapse":"open"}	{"sort":7,"group":null}	\N
361	404	directus_collections	projects_links	{"collection":"projects_links","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":8,"group":null,"collapse":"open"}	{"sort":8,"group":null}	\N
362	405	directus_collections	projects_translations	{"collection":"projects_translations","icon":"import_export","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":9,"group":null,"collapse":"open"}	{"sort":9,"group":null}	\N
363	406	directus_collections	projects	{"collection":"projects","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":10,"group":null,"collapse":"open"}	{"sort":10,"group":null}	\N
365	408	directus_collections	comments	{"collection":"comments","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open"}	{"sort":1,"group":null}	\N
366	409	directus_collections	lang	{"collection":"lang","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open"}	{"sort":2,"group":null}	\N
367	410	directus_collections	languages	{"collection":"languages","icon":null,"note":null,"display_template":"{{name}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open"}	{"sort":3,"group":null}	\N
368	411	directus_collections	links	{"collection":"links","icon":null,"note":null,"display_template":"{{name}}{{link}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":4,"group":null,"collapse":"open"}	{"sort":4,"group":null}	\N
369	412	directus_collections	profile	{"collection":"profile","icon":null,"note":null,"display_template":"{{email}}{{translations}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":5,"group":null,"collapse":"open"}	{"sort":5,"group":null}	\N
370	413	directus_collections	projects_languages	{"collection":"projects_languages","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":6,"group":null,"collapse":"open"}	{"sort":6,"group":null}	\N
371	414	directus_collections	projects_links	{"collection":"projects_links","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":7,"group":null,"collapse":"open"}	{"sort":7,"group":null}	\N
372	415	directus_collections	projects_translations	{"collection":"projects_translations","icon":"import_export","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":8,"group":null,"collapse":"open"}	{"sort":8,"group":null}	\N
373	416	directus_collections	projects	{"collection":"projects","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":9,"group":null,"collapse":"open"}	{"sort":9,"group":null}	\N
374	417	directus_collections	profile	{"collection":"profile","icon":null,"note":null,"display_template":"{{email}}{{translations}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":5,"group":null,"collapse":"closed"}	{"collapse":"closed"}	\N
487	535	directus_permissions	33	{"role":null,"collection":"lang","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"lang","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
364	407	directus_collections	profile_section_item	{"collection":"profile_section_item","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"profile_section","collapse":"open"}	{"sort":1,"group":"profile_section"}	\N
375	418	directus_collections	profile	{"collection":"profile","icon":null,"note":null,"display_template":"{{email}}{{translations}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":5,"group":null,"collapse":"locked"}	{"collapse":"locked"}	\N
376	419	directus_collections	profile	{"collection":"profile","icon":null,"note":null,"display_template":"{{email}}{{translations}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":5,"group":null,"collapse":"open"}	{"collapse":"open"}	\N
377	420	directus_collections	profile	{"collection":"profile","icon":null,"note":null,"display_template":"{{email}}{{translations}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":5,"group":null,"collapse":"closed"}	{"collapse":"closed"}	\N
378	421	directus_collections	profile_translations	{"collection":"profile_translations","icon":"import_export","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"profile","collapse":"open"}	{"sort":1,"group":"profile"}	\N
379	422	directus_collections	profile_section	{"collection":"profile_section","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"profile","collapse":"open"}	{"sort":2,"group":"profile"}	\N
380	423	directus_collections	comments	{"collection":"comments","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open"}	{"sort":1,"group":null}	\N
381	424	directus_collections	lang	{"collection":"lang","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open"}	{"sort":2,"group":null}	\N
382	425	directus_collections	languages	{"collection":"languages","icon":null,"note":null,"display_template":"{{name}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open"}	{"sort":3,"group":null}	\N
383	426	directus_collections	links	{"collection":"links","icon":null,"note":null,"display_template":"{{name}}{{link}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":4,"group":null,"collapse":"open"}	{"sort":4,"group":null}	\N
384	427	directus_collections	profile	{"collection":"profile","icon":null,"note":null,"display_template":"{{email}}{{translations}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":5,"group":null,"collapse":"closed"}	{"sort":5,"group":null}	\N
385	428	directus_collections	projects_translations	{"collection":"projects_translations","icon":"import_export","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":6,"group":null,"collapse":"open"}	{"sort":6,"group":null}	\N
386	429	directus_collections	projects_languages	{"collection":"projects_languages","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":7,"group":null,"collapse":"open"}	{"sort":7,"group":null}	\N
387	430	directus_collections	projects_links	{"collection":"projects_links","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":8,"group":null,"collapse":"open"}	{"sort":8,"group":null}	\N
388	431	directus_collections	projects	{"collection":"projects","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":9,"group":null,"collapse":"open"}	{"sort":9,"group":null}	\N
389	432	directus_collections	comments	{"collection":"comments","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open"}	{"sort":1,"group":null}	\N
390	433	directus_collections	lang	{"collection":"lang","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open"}	{"sort":2,"group":null}	\N
391	434	directus_collections	languages	{"collection":"languages","icon":null,"note":null,"display_template":"{{name}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open"}	{"sort":3,"group":null}	\N
488	536	directus_permissions	34	{"role":null,"collection":"projects_links","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"projects_links","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
392	435	directus_collections	links	{"collection":"links","icon":null,"note":null,"display_template":"{{name}}{{link}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":4,"group":null,"collapse":"open"}	{"sort":4,"group":null}	\N
393	436	directus_collections	profile	{"collection":"profile","icon":null,"note":null,"display_template":"{{email}}{{translations}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":5,"group":null,"collapse":"closed"}	{"sort":5,"group":null}	\N
394	437	directus_collections	projects	{"collection":"projects","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":6,"group":null,"collapse":"open"}	{"sort":6,"group":null}	\N
395	438	directus_collections	projects_translations	{"collection":"projects_translations","icon":"import_export","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":7,"group":null,"collapse":"open"}	{"sort":7,"group":null}	\N
396	439	directus_collections	projects_languages	{"collection":"projects_languages","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":8,"group":null,"collapse":"open"}	{"sort":8,"group":null}	\N
397	440	directus_collections	projects_links	{"collection":"projects_links","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":9,"group":null,"collapse":"open"}	{"sort":9,"group":null}	\N
398	441	directus_collections	projects_translations	{"collection":"projects_translations","icon":"import_export","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"projects","collapse":"open"}	{"sort":1,"group":"projects"}	\N
407	450	directus_collections	projects_languages	{"collection":"projects_languages","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"projects","collapse":"open"}	{"sort":1,"group":"projects"}	\N
410	452	directus_collections	projects_translations	{"collection":"projects_translations","icon":"import_export","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"projects","collapse":"open"}	{"sort":2,"group":"projects"}	\N
416	459	directus_collections	projects_links	{"collection":"projects_links","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"projects","collapse":"open"}	{"sort":1,"group":"projects"}	\N
418	461	directus_collections	projects_languages	{"collection":"projects_languages","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"projects","collapse":"open"}	{"sort":2,"group":"projects"}	\N
421	464	directus_collections	projects_translations	{"collection":"projects_translations","icon":"import_export","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":"projects","collapse":"open"}	{"sort":3,"group":"projects"}	\N
425	468	directus_fields	111	{"interface":"input","special":null,"options":{"iconLeft":null},"collection":"projects_translations","field":"title"}	{"interface":"input","special":null,"options":{"iconLeft":null},"collection":"projects_translations","field":"title"}	\N
399	442	directus_collections	comments	{"collection":"comments","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open"}	{"sort":1,"group":null}	\N
400	443	directus_collections	lang	{"collection":"lang","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open"}	{"sort":2,"group":null}	\N
401	444	directus_collections	languages	{"collection":"languages","icon":null,"note":null,"display_template":"{{name}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open"}	{"sort":3,"group":null}	\N
402	445	directus_collections	links	{"collection":"links","icon":null,"note":null,"display_template":"{{name}}{{link}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":4,"group":null,"collapse":"open"}	{"sort":4,"group":null}	\N
403	446	directus_collections	profile	{"collection":"profile","icon":null,"note":null,"display_template":"{{email}}{{translations}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":5,"group":null,"collapse":"closed"}	{"sort":5,"group":null}	\N
404	447	directus_collections	projects	{"collection":"projects","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":6,"group":null,"collapse":"open"}	{"sort":6,"group":null}	\N
405	448	directus_collections	projects_languages	{"collection":"projects_languages","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":7,"group":null,"collapse":"open"}	{"sort":7,"group":null}	\N
406	449	directus_collections	projects_links	{"collection":"projects_links","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":8,"group":null,"collapse":"open"}	{"sort":8,"group":null}	\N
408	451	directus_collections	comments	{"collection":"comments","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open"}	{"sort":1,"group":null}	\N
409	453	directus_collections	lang	{"collection":"lang","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open"}	{"sort":2,"group":null}	\N
411	454	directus_collections	languages	{"collection":"languages","icon":null,"note":null,"display_template":"{{name}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open"}	{"sort":3,"group":null}	\N
412	455	directus_collections	links	{"collection":"links","icon":null,"note":null,"display_template":"{{name}}{{link}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":4,"group":null,"collapse":"open"}	{"sort":4,"group":null}	\N
413	456	directus_collections	profile	{"collection":"profile","icon":null,"note":null,"display_template":"{{email}}{{translations}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":5,"group":null,"collapse":"closed"}	{"sort":5,"group":null}	\N
414	457	directus_collections	projects	{"collection":"projects","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":6,"group":null,"collapse":"open"}	{"sort":6,"group":null}	\N
415	458	directus_collections	projects_links	{"collection":"projects_links","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":7,"group":null,"collapse":"open"}	{"sort":7,"group":null}	\N
417	460	directus_collections	comments	{"collection":"comments","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open"}	{"sort":1,"group":null}	\N
419	462	directus_collections	lang	{"collection":"lang","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open"}	{"sort":2,"group":null}	\N
420	463	directus_collections	languages	{"collection":"languages","icon":null,"note":null,"display_template":"{{name}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open"}	{"sort":3,"group":null}	\N
422	465	directus_collections	links	{"collection":"links","icon":null,"note":null,"display_template":"{{name}}{{link}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":4,"group":null,"collapse":"open"}	{"sort":4,"group":null}	\N
423	466	directus_collections	profile	{"collection":"profile","icon":null,"note":null,"display_template":"{{email}}{{translations}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":5,"group":null,"collapse":"closed"}	{"sort":5,"group":null}	\N
424	467	directus_collections	projects	{"collection":"projects","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":6,"group":null,"collapse":"open"}	{"sort":6,"group":null}	\N
426	469	directus_fields	112	{"interface":"input","special":null,"collection":"projects_translations","field":"body"}	{"interface":"input","special":null,"collection":"projects_translations","field":"body"}	\N
427	470	projects_translations	1	{"title":"A shores planner web app","body":"Created and deployed a Django web app on Heroku and using Docker on a VPS. The app includes a premium version wich adds a permission system. "}	{"title":"A shores planner web app","body":"Created and deployed a Django web app on Heroku and using Docker on a VPS. The app includes a premium version wich adds a permission system. "}	\N
428	472	projects_translations	2	{"body":"Created and deployed a Django web app on Heroku and using Docker on a VPS. The app includes a premium version wich adds a permission system. ","lang_code":{"code":"en"},"title":"A shores planner web app","projects_id":"1"}	{"body":"Created and deployed a Django web app on Heroku and using Docker on a VPS. The app includes a premium version wich adds a permission system. ","lang_code":{"code":"en"},"title":"A shores planner web app","projects_id":"1"}	\N
429	474	projects_translations	3	{"lang_code":{"code":"fr"},"projects_id":"1","body":" J'ai développé et déployé une application Django via Heroku et via Docker sur un VPS. Une version premium permet de customiser le planning. ","title":"Un planning de taches ménagères"}	{"lang_code":{"code":"fr"},"projects_id":"1","body":" J'ai développé et déployé une application Django via Heroku et via Docker sur un VPS. Une version premium permet de customiser le planning. ","title":"Un planning de taches ménagères"}	\N
430	476	projects_translations	4	{"body":" Created a NodeJS REST API with Express and a MySQL server. I used Docker to deploy it has a full-stack app, React in front-end making HTTP requests to the API wich served has backend. ","lang_code":{"code":"en"},"title":"A todo list REST API","projects_id":"2"}	{"body":" Created a NodeJS REST API with Express and a MySQL server. I used Docker to deploy it has a full-stack app, React in front-end making HTTP requests to the API wich served has backend. ","lang_code":{"code":"en"},"title":"A todo list REST API","projects_id":"2"}	\N
431	477	projects_translations	5	{"title":" Une todo-list en API REST","lang_code":{"code":"fr"},"projects_id":"2","body":" J'ai developpé une API REST en NodeJS avec Express et un serveur MySQL. Je l'ai utilisées dans une application full-stack. ReactJS en front-end utilisant l'API graçe aux requetes http. "}	{"title":" Une todo-list en API REST","lang_code":{"code":"fr"},"projects_id":"2","body":" J'ai developpé une API REST en NodeJS avec Express et un serveur MySQL. Je l'ai utilisées dans une application full-stack. ReactJS en front-end utilisant l'API graçe aux requetes http. "}	\N
432	479	projects_translations	6	{"lang_code":{"code":"en"},"projects_id":"3","title":"A participative web app for the Hackatown 2021","body":" I developed this app with a few mates using Django during the Hackatown 2021. We used PostgreSQL as SQL server. "}	{"lang_code":{"code":"en"},"projects_id":"3","title":"A participative web app for the Hackatown 2021","body":" I developed this app with a few mates using Django during the Hackatown 2021. We used PostgreSQL as SQL server. "}	\N
433	480	projects_translations	7	{"body":" J'ai développé ce site avec Django pendant le Hackatown 2021. La base de données était assurée via PostgreSQL ","lang_code":{"code":"fr"},"title":"Une application participative pour le Hackatown 2021","projects_id":"3"}	{"body":" J'ai développé ce site avec Django pendant le Hackatown 2021. La base de données était assurée via PostgreSQL ","lang_code":{"code":"fr"},"title":"Une application participative pour le Hackatown 2021","projects_id":"3"}	\N
434	482	directus_permissions	28	{"role":null,"collection":"projects_translations","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"projects_translations","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
435	483	directus_fields	113	{"interface":"list-o2m","special":["o2m"],"collection":"profile","field":"sections"}	{"interface":"list-o2m","special":["o2m"],"collection":"profile","field":"sections"}	\N
436	484	directus_fields	114	{"interface":"input","special":["uuid"],"collection":"profile_section","field":"section_id"}	{"interface":"input","special":["uuid"],"collection":"profile_section","field":"section_id"}	\N
437	485	directus_fields	115	{"interface":"input","special":["uuid"],"collection":"profile_section_item","field":"section_id"}	{"interface":"input","special":["uuid"],"collection":"profile_section_item","field":"section_id"}	\N
438	486	directus_fields	115	{"id":115,"collection":"profile_section_item","field":"section_id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"profile_section_item","field":"section_id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	\N
439	487	directus_fields	116	{"interface":"select-dropdown-m2o","special":["m2o"],"options":{"template":"{{title}}"},"collection":"profile_section_item","field":"section_id"}	{"interface":"select-dropdown-m2o","special":["m2o"],"options":{"template":"{{title}}"},"collection":"profile_section_item","field":"section_id"}	\N
440	488	directus_fields	117	{"interface":"input","special":null,"collection":"profile_section_item","field":"section_id"}	{"interface":"input","special":null,"collection":"profile_section_item","field":"section_id"}	\N
441	489	directus_fields	118	{"interface":"select-dropdown-m2o","special":["m2o"],"options":{"template":"{{title}}"},"collection":"profile_section_item","field":"section"}	{"interface":"select-dropdown-m2o","special":["m2o"],"options":{"template":"{{title}}"},"collection":"profile_section_item","field":"section"}	\N
445	493	directus_collections	profile_section	{"collection":"profile_section","icon":null,"note":null,"display_template":"{{title}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"profile","collapse":"open"}	{"display_template":"{{title}}"}	\N
446	494	directus_files	dc446a36-ac14-4e6c-a463-71added7d9a2	{"filename_download":"png-clipart-javascript-open-logo-number-js-angle-text.png","storage":"local","type":"image/png","title":"Png Clipart Javascript Open Logo Number JS Angle Text.png"}	{"filename_download":"png-clipart-javascript-open-logo-number-js-angle-text.png","storage":"local","type":"image/png","title":"Png Clipart Javascript Open Logo Number JS Angle Text.png"}	\N
447	495	directus_files	0855e668-4b07-4373-8c76-ff744057f860	{"title":"Cpp","filename_download":"cpp.png","type":"image/png","storage":"local"}	{"title":"Cpp","filename_download":"cpp.png","type":"image/png","storage":"local"}	\N
448	496	directus_files	4acac7d6-e615-4e74-8a16-859a83a1f1fc	{"filename_download":"1869px-Python-logo-notext.svg.png","storage":"local","type":"image/png","title":"1869px Python Logo Notext.svg.png"}	{"filename_download":"1869px-Python-logo-notext.svg.png","storage":"local","type":"image/png","title":"1869px Python Logo Notext.svg.png"}	\N
449	497	directus_files	15794a77-6d4b-436f-8626-a40a24d36da1	{"title":"Web","filename_download":"web.png","type":"image/png","storage":"local"}	{"title":"Web","filename_download":"web.png","type":"image/png","storage":"local"}	\N
450	498	directus_files	90f06a4a-caff-4d70-a59e-64f5b61cee7e	{"filename_download":"800px-Java_Logo.svg.png","storage":"local","type":"image/png","title":"800px Java Logo.svg.png"}	{"filename_download":"800px-Java_Logo.svg.png","storage":"local","type":"image/png","title":"800px Java Logo.svg.png"}	\N
455	503	profile_section	1	{"title":"Practiced languages","profile":1,"items":{"create":[{"title":"Javascript, HTML & CSS","subtitle":"Frontend application development","image":"15794a77-6d4b-436f-8626-a40a24d36da1"},{"title":"C/C++","subtitle":"at {EPITECH.}","image":"0855e668-4b07-4373-8c76-ff744057f860"},{"title":"Python","subtitle":"Neural networks","image":"4acac7d6-e615-4e74-8a16-859a83a1f1fc"},{"title":"Java","subtitle":"Minecraft Modding","image":"90f06a4a-caff-4d70-a59e-64f5b61cee7e"}],"update":[],"delete":[]}}	{"title":"Practiced languages","profile":1,"items":{"create":[{"title":"Javascript, HTML & CSS","subtitle":"Frontend application development","image":"15794a77-6d4b-436f-8626-a40a24d36da1"},{"title":"C/C++","subtitle":"at {EPITECH.}","image":"0855e668-4b07-4373-8c76-ff744057f860"},{"title":"Python","subtitle":"Neural networks","image":"4acac7d6-e615-4e74-8a16-859a83a1f1fc"},{"title":"Java","subtitle":"Minecraft Modding","image":"90f06a4a-caff-4d70-a59e-64f5b61cee7e"}],"update":[],"delete":[]}}	\N
451	499	profile_section_item	1	{"title":"Javascript, HTML & CSS","subtitle":"Frontend application development","image":"15794a77-6d4b-436f-8626-a40a24d36da1","section":1}	{"title":"Javascript, HTML & CSS","subtitle":"Frontend application development","image":"15794a77-6d4b-436f-8626-a40a24d36da1","section":1}	455
452	500	profile_section_item	2	{"title":"C/C++","subtitle":"at {EPITECH.}","image":"0855e668-4b07-4373-8c76-ff744057f860","section":1}	{"title":"C/C++","subtitle":"at {EPITECH.}","image":"0855e668-4b07-4373-8c76-ff744057f860","section":1}	455
453	501	profile_section_item	3	{"title":"Python","subtitle":"Neural networks","image":"4acac7d6-e615-4e74-8a16-859a83a1f1fc","section":1}	{"title":"Python","subtitle":"Neural networks","image":"4acac7d6-e615-4e74-8a16-859a83a1f1fc","section":1}	455
454	502	profile_section_item	4	{"title":"Java","subtitle":"Minecraft Modding","image":"90f06a4a-caff-4d70-a59e-64f5b61cee7e","section":1}	{"title":"Java","subtitle":"Minecraft Modding","image":"90f06a4a-caff-4d70-a59e-64f5b61cee7e","section":1}	455
456	504	directus_fields	122	{"interface":"translations","special":["translations"],"options":{"languageField":"code","languageDirectionField":"name","defaultLanguage":"en"},"collection":"profile_section_item","field":"translations"}	{"interface":"translations","special":["translations"],"options":{"languageField":"code","languageDirectionField":"name","defaultLanguage":"en"},"collection":"profile_section_item","field":"translations"}	\N
457	505	directus_fields	123	{"hidden":true,"field":"id","collection":"profile_section_item_translations"}	{"hidden":true,"field":"id","collection":"profile_section_item_translations"}	\N
458	506	directus_collections	profile_section_item_translations	{"hidden":true,"icon":"import_export","collection":"profile_section_item_translations"}	{"hidden":true,"icon":"import_export","collection":"profile_section_item_translations"}	\N
459	507	directus_fields	124	{"hidden":true,"collection":"profile_section_item_translations","field":"profile_section_item_id"}	{"hidden":true,"collection":"profile_section_item_translations","field":"profile_section_item_id"}	\N
460	508	directus_fields	125	{"hidden":true,"collection":"profile_section_item_translations","field":"lang_code"}	{"hidden":true,"collection":"profile_section_item_translations","field":"lang_code"}	\N
461	509	directus_collections	profile_section_item_translations	{"collection":"profile_section_item_translations","icon":"import_export","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open"}	{"hidden":false}	\N
462	510	directus_permissions	29	{"role":null,"collection":"profile_section_item_translations","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"profile_section_item_translations","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
491	539	directus_collections	profile_section_translations	{"hidden":true,"icon":"import_export","collection":"profile_section_translations"}	{"hidden":true,"icon":"import_export","collection":"profile_section_translations"}	\N
492	540	directus_fields	130	{"hidden":true,"collection":"profile_section_translations","field":"profile_section_id"}	{"hidden":true,"collection":"profile_section_translations","field":"profile_section_id"}	\N
493	541	directus_fields	131	{"hidden":true,"collection":"profile_section_translations","field":"lang_code"}	{"hidden":true,"collection":"profile_section_translations","field":"lang_code"}	\N
496	543	directus_collections	profile_section_translations	{"collection":"profile_section_translations","icon":"import_export","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"profile_section","collapse":"open"}	{"sort":1,"group":"profile_section"}	\N
463	511	directus_collections	profile_section_item	{"collection":"profile_section_item","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"profile_section","collapse":"open"}	{"sort":1,"group":"profile_section"}	\N
465	513	directus_collections	profile_section_item_translations	{"collection":"profile_section_item_translations","icon":"import_export","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"profile_section","collapse":"open"}	{"sort":2,"group":"profile_section"}	\N
464	512	directus_collections	comments	{"collection":"comments","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open"}	{"sort":1,"group":null}	\N
466	514	directus_collections	lang	{"collection":"lang","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open"}	{"sort":2,"group":null}	\N
467	515	directus_collections	languages	{"collection":"languages","icon":null,"note":null,"display_template":"{{name}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open"}	{"sort":3,"group":null}	\N
468	516	directus_collections	links	{"collection":"links","icon":null,"note":null,"display_template":"{{name}}{{link}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":4,"group":null,"collapse":"open"}	{"sort":4,"group":null}	\N
469	517	directus_collections	profile	{"collection":"profile","icon":null,"note":null,"display_template":"{{email}}{{translations}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":5,"group":null,"collapse":"closed"}	{"sort":5,"group":null}	\N
470	518	directus_collections	projects	{"collection":"projects","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":6,"group":null,"collapse":"open"}	{"sort":6,"group":null}	\N
471	519	directus_fields	126	{"interface":"input","special":null,"collection":"profile_section_item_translations","field":"title"}	{"interface":"input","special":null,"collection":"profile_section_item_translations","field":"title"}	\N
472	520	directus_fields	127	{"interface":"input","special":null,"collection":"profile_section_item_translations","field":"subtitle"}	{"interface":"input","special":null,"collection":"profile_section_item_translations","field":"subtitle"}	\N
474	522	profile_section_item	1	{"id":1,"date_created":"2023-02-22T00:19:50.326Z","date_updated":"2023-02-22T00:28:37.156Z","image":"15794a77-6d4b-436f-8626-a40a24d36da1","section":1,"translations":[1]}	{"date_updated":"2023-02-22T00:28:37.156Z"}	\N
473	521	profile_section_item_translations	1	{"lang_code":{"code":"en"},"profile_section_item_id":"1","title":"Javascript, HTML & CSS","subtitle":"To build web apps using various framework"}	{"lang_code":{"code":"en"},"profile_section_item_id":"1","title":"Javascript, HTML & CSS","subtitle":"To build web apps using various framework"}	474
477	525	profile_section_item	2	{"id":2,"date_created":"2023-02-22T00:19:50.337Z","date_updated":"2023-02-22T00:31:07.259Z","image":"0855e668-4b07-4373-8c76-ff744057f860","section":1,"translations":[2,3]}	{"date_updated":"2023-02-22T00:31:07.259Z"}	\N
475	523	profile_section_item_translations	2	{"title":"C & C++","lang_code":{"code":"en"},"profile_section_item_id":"2","subtitle":"To build apps involving low level programming"}	{"title":"C & C++","lang_code":{"code":"en"},"profile_section_item_id":"2","subtitle":"To build apps involving low level programming"}	477
476	524	profile_section_item_translations	3	{"title":"C & C++","lang_code":{"code":"fr"},"profile_section_item_id":"2","subtitle":"Utilisé pour développer des logiciels bas niveau"}	{"title":"C & C++","lang_code":{"code":"fr"},"profile_section_item_id":"2","subtitle":"Utilisé pour développer des logiciels bas niveau"}	477
479	527	profile_section_item	3	{"id":3,"date_created":"2023-02-22T00:19:50.342Z","date_updated":"2023-02-22T00:32:18.389Z","image":"4acac7d6-e615-4e74-8a16-859a83a1f1fc","section":1,"translations":[4]}	{"date_updated":"2023-02-22T00:32:18.389Z"}	\N
478	526	profile_section_item_translations	4	{"title":"Python","lang_code":{"code":"en"},"profile_section_item_id":"3","subtitle":"Experienced with machine learning and web development"}	{"title":"Python","lang_code":{"code":"en"},"profile_section_item_id":"3","subtitle":"Experienced with machine learning and web development"}	479
481	529	profile_section_item	3	{"id":3,"date_created":"2023-02-22T00:19:50.342Z","date_updated":"2023-02-22T00:33:13.048Z","image":"4acac7d6-e615-4e74-8a16-859a83a1f1fc","section":1,"translations":[4,5]}	{"date_updated":"2023-02-22T00:33:13.048Z"}	\N
480	528	profile_section_item_translations	5	{"title":"Python","lang_code":{"code":"fr"},"profile_section_item_id":"3","subtitle":"Machine learning et développement web"}	{"title":"Python","lang_code":{"code":"fr"},"profile_section_item_id":"3","subtitle":"Machine learning et développement web"}	481
483	531	profile_section_item	4	{"id":4,"date_created":"2023-02-22T00:19:50.349Z","date_updated":"2023-02-22T00:33:38.513Z","image":"90f06a4a-caff-4d70-a59e-64f5b61cee7e","section":1,"translations":[6]}	{"date_updated":"2023-02-22T00:33:38.513Z"}	\N
482	530	profile_section_item_translations	6	{"title":"Java","lang_code":{"code":"en"},"profile_section_item_id":"4","subtitle":"I've developped minecraft mods"}	{"title":"Java","lang_code":{"code":"en"},"profile_section_item_id":"4","subtitle":"I've developped minecraft mods"}	483
484	532	directus_permissions	30	{"role":null,"collection":"profile_section","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"profile_section","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
485	533	directus_permissions	31	{"role":null,"collection":"profile_section_item","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"profile_section_item","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
489	537	directus_fields	128	{"interface":"translations","special":["translations"],"options":{"languageField":"code","languageDirectionField":"name","defaultLanguage":"en"},"collection":"profile_section","field":"translations"}	{"interface":"translations","special":["translations"],"options":{"languageField":"code","languageDirectionField":"name","defaultLanguage":"en"},"collection":"profile_section","field":"translations"}	\N
490	538	directus_fields	129	{"hidden":true,"field":"id","collection":"profile_section_translations"}	{"hidden":true,"field":"id","collection":"profile_section_translations"}	\N
494	542	directus_collections	profile_section_translations	{"collection":"profile_section_translations","icon":"import_export","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open"}	{"hidden":false}	\N
495	544	directus_collections	comments	{"collection":"comments","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open"}	{"sort":1,"group":null}	\N
497	545	directus_collections	lang	{"collection":"lang","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open"}	{"sort":2,"group":null}	\N
499	547	directus_collections	languages	{"collection":"languages","icon":null,"note":null,"display_template":"{{name}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open"}	{"sort":3,"group":null}	\N
501	549	directus_collections	links	{"collection":"links","icon":null,"note":null,"display_template":"{{name}}{{link}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":4,"group":null,"collapse":"open"}	{"sort":4,"group":null}	\N
502	550	directus_collections	profile	{"collection":"profile","icon":null,"note":null,"display_template":"{{email}}{{translations}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":5,"group":null,"collapse":"closed"}	{"sort":5,"group":null}	\N
503	551	directus_collections	projects	{"collection":"projects","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":6,"group":null,"collapse":"open"}	{"sort":6,"group":null}	\N
498	546	directus_collections	profile_section_item	{"collection":"profile_section_item","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"profile_section","collapse":"open"}	{"sort":2,"group":"profile_section"}	\N
500	548	directus_collections	profile_section_item_translations	{"collection":"profile_section_item_translations","icon":"import_export","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":"profile_section","collapse":"open"}	{"sort":3,"group":"profile_section"}	\N
504	552	directus_fields	132	{"interface":"input","special":null,"collection":"profile_section_translations","field":"title"}	{"interface":"input","special":null,"collection":"profile_section_translations","field":"title"}	\N
507	555	profile_section	1	{"id":1,"date_created":"2023-02-22T00:19:50.317Z","date_updated":"2023-02-22T00:47:54.002Z","profile":1,"items":[1,2,3,4],"translations":[1,2]}	{"date_updated":"2023-02-22T00:47:54.002Z"}	\N
508	556	directus_collections	profile_section	{"collection":"profile_section","icon":null,"note":null,"display_template":"{{translations.title}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"profile","collapse":"open"}	{"display_template":"{{translations.title}}"}	\N
509	557	directus_collections	profile_section_item	{"collection":"profile_section_item","icon":null,"note":null,"display_template":"{{translations.title}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"profile_section","collapse":"open"}	{"display_template":"{{translations.title}}"}	\N
510	558	directus_collections	profile_section_item_translations	{"collection":"profile_section_item_translations","icon":"import_export","note":null,"display_template":"{{lang_code.code}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":"profile_section","collapse":"open"}	{"display_template":"{{lang_code.code}}"}	\N
511	559	directus_collections	profile_translations	{"collection":"profile_translations","icon":"import_export","note":null,"display_template":"{{lang_code.code}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"profile","collapse":"open"}	{"display_template":"{{lang_code.code}}"}	\N
512	560	directus_collections	profile_section_translations	{"collection":"profile_section_translations","icon":"import_export","note":null,"display_template":"{{lang_code.code}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"profile_section","collapse":"open"}	{"display_template":"{{lang_code.code}}"}	\N
513	561	directus_collections	projects_translations	{"collection":"projects_translations","icon":"import_export","note":null,"display_template":"{{lang_code.code}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":"projects","collapse":"open"}	{"display_template":"{{lang_code.code}}"}	\N
515	563	profile_section	1	{"id":1,"date_created":"2023-02-22T00:19:50.317Z","date_updated":"2023-02-22T01:05:41.321Z","profile":1,"items":[1,2,3,4],"translations":[1,2]}	{"date_updated":"2023-02-22T01:05:41.321Z"}	\N
514	562	profile_section_item	1	{"id":1,"date_created":"2023-02-22T00:19:50.326Z","date_updated":"2023-02-22T01:05:41.324Z","image":"15794a77-6d4b-436f-8626-a40a24d36da1","section":1,"translations":[1]}	{"section":"1","date_updated":"2023-02-22T01:05:41.324Z"}	515
516	564	directus_collections	profile_section	{"collection":"profile_section","icon":null,"note":null,"display_template":"{{id}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"profile","collapse":"open"}	{"display_template":"{{id}}"}	\N
517	566	directus_fields	133	{"interface":"translations","special":["translations"],"options":{"languageField":"code","languageDirectionField":"name"},"collection":"profile_section","field":"translations"}	{"interface":"translations","special":["translations"],"options":{"languageField":"code","languageDirectionField":"name"},"collection":"profile_section","field":"translations"}	\N
518	567	directus_fields	134	{"hidden":true,"field":"id","collection":"profile_section_translations"}	{"hidden":true,"field":"id","collection":"profile_section_translations"}	\N
519	568	directus_collections	profile_section_translations	{"hidden":true,"icon":"import_export","collection":"profile_section_translations"}	{"hidden":true,"icon":"import_export","collection":"profile_section_translations"}	\N
520	569	directus_fields	135	{"hidden":true,"collection":"profile_section_translations","field":"profile_section_id"}	{"hidden":true,"collection":"profile_section_translations","field":"profile_section_id"}	\N
521	570	directus_fields	136	{"hidden":true,"collection":"profile_section_translations","field":"lang_code"}	{"hidden":true,"collection":"profile_section_translations","field":"lang_code"}	\N
522	571	directus_fields	137	{"interface":"input","special":null,"collection":"profile_section_translations","field":"section_title"}	{"interface":"input","special":null,"collection":"profile_section_translations","field":"section_title"}	\N
525	574	profile_section	1	{"id":1,"date_created":"2023-02-22T00:19:50.317Z","date_updated":"2023-02-22T01:20:27.020Z","profile":1,"translations":[1,2],"items":[1,2,3,4]}	{"date_updated":"2023-02-22T01:20:27.020Z"}	\N
523	572	profile_section_translations	1	{"lang_code":{"code":"en"},"profile_section_id":"1","section_title":"Languages"}	{"lang_code":{"code":"en"},"profile_section_id":"1","section_title":"Languages"}	525
524	573	profile_section_translations	2	{"section_title":"Languages pratiqués","lang_code":{"code":"fr"},"profile_section_id":"1"}	{"section_title":"Languages pratiqués","lang_code":{"code":"fr"},"profile_section_id":"1"}	525
526	575	directus_fields	138	{"interface":"input","special":null,"collection":"profile_section","field":"title"}	{"interface":"input","special":null,"collection":"profile_section","field":"title"}	\N
527	576	profile_section	1	{"id":1,"date_created":"2023-02-22T00:19:50.317Z","date_updated":"2023-02-22T01:21:52.631Z","profile":1,"title":"Languages","items":[1,2,3,4]}	{"title":"Languages","date_updated":"2023-02-22T01:21:52.631Z"}	\N
528	578	directus_files	b8117a85-157b-49a7-b67b-63a5276e0d42	{"filename_download":"docker.png","storage":"local","type":"image/png","title":"Docker.png"}	{"filename_download":"docker.png","storage":"local","type":"image/png","title":"Docker.png"}	\N
529	579	directus_files	c8a18cac-14da-47e3-81aa-686640d35ae7	{"filename_download":"traefik.png","storage":"local","type":"image/png","title":"Traefik.png"}	{"filename_download":"traefik.png","storage":"local","type":"image/png","title":"Traefik.png"}	\N
530	580	profile_section_item_translations	7	{"title":"Docker","lang_code":{"code":"en"},"profile_section_item_id":5,"subtitle":"Containerizing my apps"}	{"title":"Docker","lang_code":{"code":"en"},"profile_section_item_id":5,"subtitle":"Containerizing my apps"}	532
531	581	profile_section_item_translations	8	{"title":"Docker","lang_code":{"code":"fr"},"profile_section_item_id":5,"subtitle":"Pour avoir des conteneurs"}	{"title":"Docker","lang_code":{"code":"fr"},"profile_section_item_id":5,"subtitle":"Pour avoir des conteneurs"}	532
533	583	profile_section_item_translations	9	{"title":"Traefik","lang_code":{"code":"en"},"profile_section_item_id":6,"subtitle":"Open-source reverse proxy"}	{"title":"Traefik","lang_code":{"code":"en"},"profile_section_item_id":6,"subtitle":"Open-source reverse proxy"}	534
535	585	profile_section	2	{"profile":1,"title":"Softwares","items":{"create":[{"image":"b8117a85-157b-49a7-b67b-63a5276e0d42","translations":{"create":[{"title":"Docker","lang_code":{"code":"en"},"profile_section_item_id":"+","subtitle":"Containerizing my apps"},{"title":"Docker","lang_code":{"code":"fr"},"profile_section_item_id":"+","subtitle":"Pour avoir des conteneurs"}],"update":[],"delete":[]}},{"image":"c8a18cac-14da-47e3-81aa-686640d35ae7","translations":{"create":[{"title":"Traefik","lang_code":{"code":"en"},"profile_section_item_id":"+","subtitle":"Open-source reverse proxy"}],"update":[],"delete":[]}}],"update":[],"delete":[]}}	{"profile":1,"title":"Softwares","items":{"create":[{"image":"b8117a85-157b-49a7-b67b-63a5276e0d42","translations":{"create":[{"title":"Docker","lang_code":{"code":"en"},"profile_section_item_id":"+","subtitle":"Containerizing my apps"},{"title":"Docker","lang_code":{"code":"fr"},"profile_section_item_id":"+","subtitle":"Pour avoir des conteneurs"}],"update":[],"delete":[]}},{"image":"c8a18cac-14da-47e3-81aa-686640d35ae7","translations":{"create":[{"title":"Traefik","lang_code":{"code":"en"},"profile_section_item_id":"+","subtitle":"Open-source reverse proxy"}],"update":[],"delete":[]}}],"update":[],"delete":[]}}	\N
532	582	profile_section_item	5	{"image":"b8117a85-157b-49a7-b67b-63a5276e0d42","translations":{"create":[{"title":"Docker","lang_code":{"code":"en"},"profile_section_item_id":"+","subtitle":"Containerizing my apps"},{"title":"Docker","lang_code":{"code":"fr"},"profile_section_item_id":"+","subtitle":"Pour avoir des conteneurs"}],"update":[],"delete":[]},"section":2}	{"image":"b8117a85-157b-49a7-b67b-63a5276e0d42","translations":{"create":[{"title":"Docker","lang_code":{"code":"en"},"profile_section_item_id":"+","subtitle":"Containerizing my apps"},{"title":"Docker","lang_code":{"code":"fr"},"profile_section_item_id":"+","subtitle":"Pour avoir des conteneurs"}],"update":[],"delete":[]},"section":2}	535
534	584	profile_section_item	6	{"image":"c8a18cac-14da-47e3-81aa-686640d35ae7","translations":{"create":[{"title":"Traefik","lang_code":{"code":"en"},"profile_section_item_id":"+","subtitle":"Open-source reverse proxy"}],"update":[],"delete":[]},"section":2}	{"image":"c8a18cac-14da-47e3-81aa-686640d35ae7","translations":{"create":[{"title":"Traefik","lang_code":{"code":"en"},"profile_section_item_id":"+","subtitle":"Open-source reverse proxy"}],"update":[],"delete":[]},"section":2}	535
536	586	directus_fields	139	{"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"formations"}	{"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"formations"}	\N
537	587	directus_collections	formations	{"singleton":false,"collection":"formations"}	{"singleton":false,"collection":"formations"}	\N
538	588	directus_fields	140	{"interface":"datetime","special":null,"required":true,"collection":"formations","field":"start"}	{"interface":"datetime","special":null,"required":true,"collection":"formations","field":"start"}	\N
539	589	directus_fields	141	{"interface":"datetime","special":null,"collection":"formations","field":"end"}	{"interface":"datetime","special":null,"collection":"formations","field":"end"}	\N
540	590	directus_fields	142	{"interface":"boolean","special":["cast-boolean"],"collection":"formations","field":"current"}	{"interface":"boolean","special":["cast-boolean"],"collection":"formations","field":"current"}	\N
541	591	directus_fields	143	{"interface":"input","special":null,"collection":"formations","field":"institution"}	{"interface":"input","special":null,"collection":"formations","field":"institution"}	\N
542	592	directus_fields	144	{"interface":"file-image","special":["file"],"collection":"formations","field":"image"}	{"interface":"file-image","special":["file"],"collection":"formations","field":"image"}	\N
543	593	directus_fields	145	{"interface":"list","special":["cast-json"],"options":{"fields":[],"template":"[[ field ]]"},"collection":"formations","field":"skills"}	{"interface":"list","special":["cast-json"],"options":{"fields":[],"template":"[[ field ]]"},"collection":"formations","field":"skills"}	\N
544	594	directus_fields	146	{"interface":"translations","special":["translations"],"options":{"languageField":"code","languageDirectionField":"name","defaultLanguage":"en"},"collection":"formations","field":"translations"}	{"interface":"translations","special":["translations"],"options":{"languageField":"code","languageDirectionField":"name","defaultLanguage":"en"},"collection":"formations","field":"translations"}	\N
545	595	directus_fields	147	{"hidden":true,"field":"id","collection":"formations_translations"}	{"hidden":true,"field":"id","collection":"formations_translations"}	\N
546	596	directus_collections	formations_translations	{"hidden":true,"icon":"import_export","collection":"formations_translations"}	{"hidden":true,"icon":"import_export","collection":"formations_translations"}	\N
547	597	directus_fields	148	{"hidden":true,"collection":"formations_translations","field":"formations_id"}	{"hidden":true,"collection":"formations_translations","field":"formations_id"}	\N
548	598	directus_fields	149	{"hidden":true,"collection":"formations_translations","field":"lang_code"}	{"hidden":true,"collection":"formations_translations","field":"lang_code"}	\N
549	599	directus_fields	150	{"interface":"input","special":null,"collection":"formations_translations","field":"institution"}	{"interface":"input","special":null,"collection":"formations_translations","field":"institution"}	\N
550	600	directus_fields	151	{"interface":"list","special":["cast-json"],"options":{"fields":[{"field":"description","name":"description","meta":{"field":"description"}}]},"collection":"formations_translations","field":"skills"}	{"interface":"list","special":["cast-json"],"options":{"fields":[{"field":"description","name":"description","meta":{"field":"description"}}]},"collection":"formations_translations","field":"skills"}	\N
551	601	directus_fields	152	{"interface":"input","special":null,"collection":"formations_translations","field":"name"}	{"interface":"input","special":null,"collection":"formations_translations","field":"name"}	\N
552	602	directus_permissions	35	{"role":null,"collection":"profile_section_translations","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"profile_section_translations","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
553	603	directus_permissions	36	{"role":null,"collection":"formations","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"formations","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
554	604	directus_permissions	37	{"role":null,"collection":"formations_translations","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"formations_translations","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
555	605	directus_files	40e0ea72-9b8c-47ff-a0fb-2e8faf7dc221	{"filename_download":"epitech.ico","storage":"local","type":"image/x-icon","title":"Epitech.ico"}	{"filename_download":"epitech.ico","storage":"local","type":"image/x-icon","title":"Epitech.ico"}	\N
557	607	formations	1	{"start":"2020-09-21T12:00:00","current":true,"image":"40e0ea72-9b8c-47ff-a0fb-2e8faf7dc221","translations":{"create":[{"institution":"EPITECH","lang_code":{"code":"en"},"formations_id":"+","name":"Master in Information Technology","skills":[{"description":"Project management"},{"description":"Build complex programs such as debuggers in a Linux environnement"},{"description":"Acquire skills in the DevOps sector "}]}],"update":[],"delete":[]}}	{"start":"2020-09-21T12:00:00","current":true,"image":"40e0ea72-9b8c-47ff-a0fb-2e8faf7dc221","translations":{"create":[{"institution":"EPITECH","lang_code":{"code":"en"},"formations_id":"+","name":"Master in Information Technology","skills":[{"description":"Project management"},{"description":"Build complex programs such as debuggers in a Linux environnement"},{"description":"Acquire skills in the DevOps sector "}]}],"update":[],"delete":[]}}	\N
573	624	directus_files	242b35e1-524f-4227-9b6a-7f338b75c0ba	{"filename_download":"a44cf90b4f761c179058a0547da19683.jpg","storage":"local","type":"image/jpeg","title":"A44cf90b4f761c179058a0547da19683.jpg"}	{"filename_download":"a44cf90b4f761c179058a0547da19683.jpg","storage":"local","type":"image/jpeg","title":"A44cf90b4f761c179058a0547da19683.jpg"}	\N
574	625	projects	3	{"id":3,"name":"City Supplier","github":"https://github.com/gummyWalrus/Hackatown2021-citysupplier","tags":"[\\n    {\\n        \\"name\\": \\"Django\\",\\n        \\"icon\\": \\"fa-brands fa-python\\",\\n        \\"link\\": \\"https://www.djangoproject.com/\\"\\n    },\\n    {\\n        \\"name\\": \\"Postgres\\",\\n        \\"icon\\": \\"fa-solid fa-database\\",\\n        \\"link\\": \\"http://postgresql.org\\"\\n    },\\n    {\\n        \\"name\\": \\"Heroku\\",\\n        \\"icon\\": \\"fa-solid fa-server\\",\\n        \\"link\\": \\"https://heroku.com\\"\\n    }\\n]","background":"242b35e1-524f-4227-9b6a-7f338b75c0ba","languages":[7,8,9],"translations":[6,7]}	{"background":"242b35e1-524f-4227-9b6a-7f338b75c0ba"}	\N
556	606	formations_translations	1	{"institution":"EPITECH","lang_code":{"code":"en"},"formations_id":1,"name":"Master in Information Technology","skills":[{"description":"Project management"},{"description":"Build complex programs such as debuggers in a Linux environnement"},{"description":"Acquire skills in the DevOps sector "}]}	{"institution":"EPITECH","lang_code":{"code":"en"},"formations_id":1,"name":"Master in Information Technology","skills":[{"description":"Project management"},{"description":"Build complex programs such as debuggers in a Linux environnement"},{"description":"Acquire skills in the DevOps sector "}]}	557
558	608	formations_translations	2	{"institution":"EPITECH","lang_code":{"code":"fr"},"formations_id":"1","skills":[{"description":"Gestion de projet"},{"description":"Architecture réseau (DevOps)"},{"description":"Étudier toutes les couches d'abstraction qui font les logiciels d'aujourd'hui, de l'assembleur jusqu'au C++"},{"description":"Développement de programmes complexes tel qu'un debugger pour un environnement Linux"}],"name":"Master en Technologies de l'Information"}	{"institution":"EPITECH","lang_code":{"code":"fr"},"formations_id":"1","skills":[{"description":"Gestion de projet"},{"description":"Architecture réseau (DevOps)"},{"description":"Étudier toutes les couches d'abstraction qui font les logiciels d'aujourd'hui, de l'assembleur jusqu'au C++"},{"description":"Développement de programmes complexes tel qu'un debugger pour un environnement Linux"}],"name":"Master en Technologies de l'Information"}	\N
559	609	formations_translations	1	{"id":1,"formations_id":1,"lang_code":"en","institution":"EPITECH","skills":[{"description":"Project management"},{"description":"Build complex programs such as debuggers in a Linux environnement"},{"description":"Acquire skills in the DevOps sector "},{"description":"Study all layers of abstraction that make computing possible, from Assembly to C++"}],"name":"Master in Information Technology"}	{"formations_id":"1","lang_code":"en","skills":[{"description":"Project management"},{"description":"Build complex programs such as debuggers in a Linux environnement"},{"description":"Acquire skills in the DevOps sector "},{"description":"Study all layers of abstraction that make computing possible, from Assembly to C++"}]}	\N
560	611	directus_fields	153	{"interface":"input","special":null,"options":{"min":1,"max":100},"required":true,"collection":"formations","field":"type"}	{"interface":"input","special":null,"options":{"min":1,"max":100},"required":true,"collection":"formations","field":"type"}	\N
561	612	directus_collections	formations	{"collection":"formations","icon":null,"note":null,"display_template":"{{translations.institution}}{{translations.name}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open"}	{"display_template":"{{translations.institution}}{{translations.name}}"}	\N
562	613	directus_files	16f1ae3e-53ad-4451-8e74-63aee1edf1f1	{"title":"Indigen","filename_download":"indigen.svg","type":"image/svg+xml","storage":"local"}	{"title":"Indigen","filename_download":"indigen.svg","type":"image/svg+xml","storage":"local"}	\N
564	615	formations	2	{"start":"2022-11-01T12:00:00","current":true,"end":"2023-08-31T12:00:00","image":"16f1ae3e-53ad-4451-8e74-63aee1edf1f1","translations":{"create":[{"institution":"Indigen","lang_code":{"code":"en"},"formations_id":"+","skills":[{"description":"Cross-Platform applications in Flutter"},{"description":"Javascript full-stack development"}],"name":"Javascript full-stack developer"}],"update":[],"delete":[]}}	{"start":"2022-11-01T12:00:00","current":true,"end":"2023-08-31T12:00:00","image":"16f1ae3e-53ad-4451-8e74-63aee1edf1f1","translations":{"create":[{"institution":"Indigen","lang_code":{"code":"en"},"formations_id":"+","skills":[{"description":"Cross-Platform applications in Flutter"},{"description":"Javascript full-stack development"}],"name":"Javascript full-stack developer"}],"update":[],"delete":[]}}	\N
563	614	formations_translations	3	{"institution":"Indigen","lang_code":{"code":"en"},"formations_id":2,"skills":[{"description":"Cross-Platform applications in Flutter"},{"description":"Javascript full-stack development"}],"name":"Javascript full-stack developer"}	{"institution":"Indigen","lang_code":{"code":"en"},"formations_id":2,"skills":[{"description":"Cross-Platform applications in Flutter"},{"description":"Javascript full-stack development"}],"name":"Javascript full-stack developer"}	564
565	616	formations	2	{"id":2,"start":"2022-11-01T12:00:00","end":"2023-08-31T12:00:00","current":true,"image":"16f1ae3e-53ad-4451-8e74-63aee1edf1f1","type":2,"translations":[3]}	{"type":2}	\N
566	617	directus_files	2f8f12a0-255f-471e-99c6-8c70a7ea01d8	{"title":"I Ndigen","filename_download":"i ndigen.jpg","type":"image/jpeg","storage":"local"}	{"title":"I Ndigen","filename_download":"i ndigen.jpg","type":"image/jpeg","storage":"local"}	\N
567	618	formations	2	{"id":2,"start":"2022-11-01T12:00:00","end":"2023-08-31T12:00:00","current":true,"image":"2f8f12a0-255f-471e-99c6-8c70a7ea01d8","type":2,"translations":[3]}	{"image":"2f8f12a0-255f-471e-99c6-8c70a7ea01d8"}	\N
568	619	directus_fields	154	{"interface":"file-image","special":["file"],"collection":"projects","field":"background"}	{"interface":"file-image","special":["file"],"collection":"projects","field":"background"}	\N
569	620	directus_files	9e3206c7-b230-4953-98fe-dad086f421df	{"title":"Bg","filename_download":"bg.jpg","type":"image/jpeg","storage":"local"}	{"title":"Bg","filename_download":"bg.jpg","type":"image/jpeg","storage":"local"}	\N
570	621	projects	1	{"id":1,"name":"Plannifii","github":"https://github.com/gummyWalrus/Plannifii","tags":"[\\n    {\\n        \\"name\\": \\"Stripe API\\",\\n        \\"icon\\": \\"fa-brands fa-stripe-s\\",\\n        \\"link\\": \\"https://stripe.com\\"\\n    },\\n    {\\n        \\"name\\": \\"Django\\",\\n        \\"icon\\": \\"fa-brands fa-python\\",\\n        \\"link\\": \\"https://www.djangoproject.com/\\"\\n    },\\n    {\\n        \\"name\\": \\"Docker\\",\\n        \\"icon\\": \\"fa-brands fa-docker\\",\\n        \\"link\\": \\"https://www.docker.com/\\"\\n    }\\n]","background":"9e3206c7-b230-4953-98fe-dad086f421df","languages":[1,2,3],"translations":[2,3]}	{"background":"9e3206c7-b230-4953-98fe-dad086f421df"}	\N
571	622	directus_files	8f110ef2-feb3-4e55-ae2e-47fbb949dfd5	{"title":"Mrobot","filename_download":"mrobot.jpg","type":"image/jpeg","storage":"local"}	{"title":"Mrobot","filename_download":"mrobot.jpg","type":"image/jpeg","storage":"local"}	\N
572	623	projects	2	{"id":2,"name":"EpyTodo","github":"https://github.com/gummyWalrus/EpyTodo","tags":"[\\n    {\\n        \\"name\\": \\"React\\",\\n        \\"icon\\": \\"fa-brands fa-react\\",\\n        \\"link\\": \\"https://fr.reactjs.org/\\"\\n    },\\n    {\\n        \\"name\\": \\"NodeJS\\",\\n        \\"icon\\": \\"fa-brands fa-node-js\\",\\n        \\"link\\": \\"https://nodejs.org/en/about/\\"\\n    },\\n    {\\n        \\"name\\": \\"MySQL\\",\\n        \\"icon\\": \\"fa-solid fa-database\\",\\n        \\"link\\": \\"https://www.mysql.com/fr/\\"\\n    }\\n]","background":"8f110ef2-feb3-4e55-ae2e-47fbb949dfd5","languages":[4,5,6],"translations":[4,5]}	{"background":"8f110ef2-feb3-4e55-ae2e-47fbb949dfd5"}	\N
575	626	directus_fields	155	{"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"articles"}	{"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"articles"}	\N
576	627	directus_fields	156	{"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"articles"}	{"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"articles"}	\N
577	628	directus_collections	articles	{"singleton":false,"collection":"articles"}	{"singleton":false,"collection":"articles"}	\N
578	629	directus_fields	157	{"interface":"tags","special":["cast-json"],"collection":"articles","field":"tags"}	{"interface":"tags","special":["cast-json"],"collection":"articles","field":"tags"}	\N
579	630	directus_fields	158	{"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"categories"}	{"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"categories"}	\N
580	631	directus_collections	categories	{"singleton":false,"collection":"categories"}	{"singleton":false,"collection":"categories"}	\N
581	632	directus_fields	159	{"interface":"translations","special":["translations"],"options":{"languageField":"code","languageDirectionField":"name","defaultLanguage":"en"},"collection":"categories","field":"translations"}	{"interface":"translations","special":["translations"],"options":{"languageField":"code","languageDirectionField":"name","defaultLanguage":"en"},"collection":"categories","field":"translations"}	\N
582	633	directus_fields	160	{"hidden":true,"field":"id","collection":"categories_translations"}	{"hidden":true,"field":"id","collection":"categories_translations"}	\N
583	634	directus_collections	categories_translations	{"hidden":true,"icon":"import_export","collection":"categories_translations"}	{"hidden":true,"icon":"import_export","collection":"categories_translations"}	\N
584	635	directus_fields	161	{"hidden":true,"collection":"categories_translations","field":"categories_id"}	{"hidden":true,"collection":"categories_translations","field":"categories_id"}	\N
585	636	directus_fields	162	{"hidden":true,"collection":"categories_translations","field":"lang_code"}	{"hidden":true,"collection":"categories_translations","field":"lang_code"}	\N
586	637	directus_fields	163	{"interface":"translations","special":["translations"],"options":{"languageField":"code","languageDirectionField":"name","defaultLanguage":"en"},"collection":"articles","field":"translations"}	{"interface":"translations","special":["translations"],"options":{"languageField":"code","languageDirectionField":"name","defaultLanguage":"en"},"collection":"articles","field":"translations"}	\N
587	638	directus_fields	164	{"hidden":true,"field":"id","collection":"articles_translations"}	{"hidden":true,"field":"id","collection":"articles_translations"}	\N
588	639	directus_collections	articles_translations	{"hidden":true,"icon":"import_export","collection":"articles_translations"}	{"hidden":true,"icon":"import_export","collection":"articles_translations"}	\N
589	640	directus_fields	165	{"hidden":true,"collection":"articles_translations","field":"articles_id"}	{"hidden":true,"collection":"articles_translations","field":"articles_id"}	\N
590	641	directus_fields	166	{"hidden":true,"collection":"articles_translations","field":"lang_code"}	{"hidden":true,"collection":"articles_translations","field":"lang_code"}	\N
591	642	directus_collections	articles_translations	{"collection":"articles_translations","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"profile_translations","collapse":"open"}	{"sort":1,"group":"profile_translations"}	\N
592	643	directus_collections	comments	{"collection":"comments","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open"}	{"sort":1,"group":null}	\N
593	644	directus_collections	lang	{"collection":"lang","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open"}	{"sort":2,"group":null}	\N
594	645	directus_collections	languages	{"collection":"languages","icon":null,"note":null,"display_template":"{{name}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open"}	{"sort":3,"group":null}	\N
595	646	directus_collections	links	{"collection":"links","icon":null,"note":null,"display_template":"{{name}}{{link}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":4,"group":null,"collapse":"open"}	{"sort":4,"group":null}	\N
596	647	directus_collections	profile	{"collection":"profile","icon":null,"note":null,"display_template":"{{email}}{{translations}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":5,"group":null,"collapse":"closed"}	{"sort":5,"group":null}	\N
597	648	directus_collections	projects	{"collection":"projects","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":6,"group":null,"collapse":"open"}	{"sort":6,"group":null}	\N
598	649	directus_collections	articles	{"collection":"articles","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":7,"group":null,"collapse":"open"}	{"sort":7,"group":null}	\N
648	699	directus_fields	171	{"hidden":true,"collection":"articles_categories","field":"articles_id"}	{"hidden":true,"collection":"articles_categories","field":"articles_id"}	\N
599	650	directus_collections	categories	{"collection":"categories","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":8,"group":null,"collapse":"open"}	{"sort":8,"group":null}	\N
600	651	directus_collections	categories_translations	{"collection":"categories_translations","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":9,"group":null,"collapse":"open"}	{"sort":9,"group":null}	\N
601	652	directus_collections	formations	{"collection":"formations","icon":null,"note":null,"display_template":"{{translations.institution}}{{translations.name}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":10,"group":null,"collapse":"open"}	{"sort":10,"group":null}	\N
602	653	directus_collections	formations_translations	{"collection":"formations_translations","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":11,"group":null,"collapse":"open"}	{"sort":11,"group":null}	\N
603	654	directus_collections	profile_section_translations	{"collection":"profile_section_translations","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":12,"group":null,"collapse":"open"}	{"sort":12,"group":null}	\N
606	656	directus_collections	categories_translations	{"collection":"categories_translations","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"categories","collapse":"open"}	{"sort":1,"group":"categories"}	\N
617	668	directus_collections	formations_translations	{"collection":"formations_translations","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"formations","collapse":"open"}	{"sort":1,"group":"formations"}	\N
628	679	directus_collections	profile_section_translations	{"collection":"profile_section_translations","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"profile_section","collapse":"open"}	{"sort":1,"group":"profile_section"}	\N
630	682	directus_collections	profile_section_item	{"collection":"profile_section_item","icon":null,"note":null,"display_template":"{{translations.title}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"profile_section","collapse":"open"}	{"sort":2,"group":"profile_section"}	\N
632	683	directus_collections	profile_section_item_translations	{"collection":"profile_section_item_translations","icon":"import_export","note":null,"display_template":"{{lang_code.code}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":"profile_section","collapse":"open"}	{"sort":3,"group":"profile_section"}	\N
641	692	directus_collections	profile_section_translations	{"collection":"profile_section_translations","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"profile_section","collapse":"open"}	{"sort":1,"group":"profile_section"}	\N
642	693	directus_collections	profile_section_item	{"collection":"profile_section_item","icon":null,"note":null,"display_template":"{{translations.title}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"profile_section","collapse":"open"}	{"sort":2,"group":"profile_section"}	\N
604	655	directus_collections	articles_translations	{"collection":"articles_translations","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"articles","collapse":"open"}	{"sort":1,"group":"articles"}	\N
605	657	directus_collections	comments	{"collection":"comments","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open"}	{"sort":1,"group":null}	\N
607	658	directus_collections	lang	{"collection":"lang","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open"}	{"sort":2,"group":null}	\N
608	659	directus_collections	languages	{"collection":"languages","icon":null,"note":null,"display_template":"{{name}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open"}	{"sort":3,"group":null}	\N
609	660	directus_collections	links	{"collection":"links","icon":null,"note":null,"display_template":"{{name}}{{link}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":4,"group":null,"collapse":"open"}	{"sort":4,"group":null}	\N
610	661	directus_collections	profile	{"collection":"profile","icon":null,"note":null,"display_template":"{{email}}{{translations}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":5,"group":null,"collapse":"closed"}	{"sort":5,"group":null}	\N
611	662	directus_collections	projects	{"collection":"projects","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":6,"group":null,"collapse":"open"}	{"sort":6,"group":null}	\N
612	663	directus_collections	articles	{"collection":"articles","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":7,"group":null,"collapse":"open"}	{"sort":7,"group":null}	\N
613	664	directus_collections	categories	{"collection":"categories","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":8,"group":null,"collapse":"open"}	{"sort":8,"group":null}	\N
614	665	directus_collections	formations	{"collection":"formations","icon":null,"note":null,"display_template":"{{translations.institution}}{{translations.name}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":9,"group":null,"collapse":"open"}	{"sort":9,"group":null}	\N
615	666	directus_collections	formations_translations	{"collection":"formations_translations","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":10,"group":null,"collapse":"open"}	{"sort":10,"group":null}	\N
616	667	directus_collections	profile_section_translations	{"collection":"profile_section_translations","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":11,"group":null,"collapse":"open"}	{"sort":11,"group":null}	\N
618	669	directus_collections	comments	{"collection":"comments","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open"}	{"sort":1,"group":null}	\N
619	670	directus_collections	lang	{"collection":"lang","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open"}	{"sort":2,"group":null}	\N
620	671	directus_collections	languages	{"collection":"languages","icon":null,"note":null,"display_template":"{{name}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open"}	{"sort":3,"group":null}	\N
621	672	directus_collections	links	{"collection":"links","icon":null,"note":null,"display_template":"{{name}}{{link}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":4,"group":null,"collapse":"open"}	{"sort":4,"group":null}	\N
622	673	directus_collections	profile	{"collection":"profile","icon":null,"note":null,"display_template":"{{email}}{{translations}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":5,"group":null,"collapse":"closed"}	{"sort":5,"group":null}	\N
649	700	directus_fields	172	{"hidden":true,"collection":"articles_categories","field":"categories_id"}	{"hidden":true,"collection":"articles_categories","field":"categories_id"}	\N
623	674	directus_collections	projects	{"collection":"projects","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":6,"group":null,"collapse":"open"}	{"sort":6,"group":null}	\N
624	675	directus_collections	articles	{"collection":"articles","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":7,"group":null,"collapse":"open"}	{"sort":7,"group":null}	\N
625	676	directus_collections	categories	{"collection":"categories","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":8,"group":null,"collapse":"open"}	{"sort":8,"group":null}	\N
626	677	directus_collections	formations	{"collection":"formations","icon":null,"note":null,"display_template":"{{translations.institution}}{{translations.name}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":9,"group":null,"collapse":"open"}	{"sort":9,"group":null}	\N
627	678	directus_collections	profile_section_translations	{"collection":"profile_section_translations","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":10,"group":null,"collapse":"open"}	{"sort":10,"group":null}	\N
629	680	directus_collections	comments	{"collection":"comments","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open"}	{"sort":1,"group":null}	\N
631	681	directus_collections	lang	{"collection":"lang","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open"}	{"sort":2,"group":null}	\N
633	684	directus_collections	languages	{"collection":"languages","icon":null,"note":null,"display_template":"{{name}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open"}	{"sort":3,"group":null}	\N
634	685	directus_collections	links	{"collection":"links","icon":null,"note":null,"display_template":"{{name}}{{link}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":4,"group":null,"collapse":"open"}	{"sort":4,"group":null}	\N
635	686	directus_collections	profile	{"collection":"profile","icon":null,"note":null,"display_template":"{{email}}{{translations}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":[],"sort":5,"group":null,"collapse":"closed"}	{"sort":5,"group":null}	\N
636	687	directus_collections	projects	{"collection":"projects","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":6,"group":null,"collapse":"open"}	{"sort":6,"group":null}	\N
637	688	directus_collections	articles	{"collection":"articles","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":7,"group":null,"collapse":"open"}	{"sort":7,"group":null}	\N
638	689	directus_collections	categories	{"collection":"categories","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":8,"group":null,"collapse":"open"}	{"sort":8,"group":null}	\N
639	690	directus_collections	formations	{"collection":"formations","icon":null,"note":null,"display_template":"{{translations.institution}}{{translations.name}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":9,"group":null,"collapse":"open"}	{"sort":9,"group":null}	\N
640	691	directus_collections	profile_section_item_translations	{"collection":"profile_section_item_translations","icon":"import_export","note":null,"display_template":"{{lang_code.code}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"profile_section_item","collapse":"open"}	{"sort":1,"group":"profile_section_item"}	\N
643	694	directus_fields	167	{"interface":"input","special":null,"collection":"articles_translations","field":"title"}	{"interface":"input","special":null,"collection":"articles_translations","field":"title"}	\N
644	695	directus_fields	168	{"interface":"input-rich-text-md","special":null,"collection":"articles_translations","field":"body"}	{"interface":"input-rich-text-md","special":null,"collection":"articles_translations","field":"body"}	\N
645	696	directus_fields	169	{"interface":"list-m2m","special":["m2m"],"collection":"articles","field":"categories"}	{"interface":"list-m2m","special":["m2m"],"collection":"articles","field":"categories"}	\N
646	697	directus_fields	170	{"hidden":true,"field":"id","collection":"articles_categories"}	{"hidden":true,"field":"id","collection":"articles_categories"}	\N
647	698	directus_collections	articles_categories	{"hidden":true,"icon":"import_export","collection":"articles_categories"}	{"hidden":true,"icon":"import_export","collection":"articles_categories"}	\N
650	701	directus_collections	profile_section_item_translations	{"collection":"profile_section_item_translations","icon":"import_export","note":null,"display_template":"{{lang_code.code}}","hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"profile_section_item","collapse":"open"}	{"hidden":true}	\N
651	702	directus_collections	profile_translations	{"collection":"profile_translations","icon":"import_export","note":null,"display_template":"{{lang_code.code}}","hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"profile","collapse":"open"}	{"hidden":true}	\N
652	703	directus_collections	projects_translations	{"collection":"projects_translations","icon":"import_export","note":null,"display_template":"{{lang_code.code}}","hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":"projects","collapse":"open"}	{"hidden":true}	\N
653	704	directus_fields	173	{"interface":"input","special":null,"collection":"categories_translations","field":"title"}	{"interface":"input","special":null,"collection":"categories_translations","field":"title"}	\N
656	707	categories	1	{"translations":{"create":[{"title":"DevOps","lang_code":{"code":"en"},"categories_id":"+"},{"title":"DevOps","lang_code":{"code":"fr"},"categories_id":"+"}],"update":[],"delete":[]}}	{"translations":{"create":[{"title":"DevOps","lang_code":{"code":"en"},"categories_id":"+"},{"title":"DevOps","lang_code":{"code":"fr"},"categories_id":"+"}],"update":[],"delete":[]}}	\N
654	705	categories_translations	1	{"title":"DevOps","lang_code":{"code":"en"},"categories_id":1}	{"title":"DevOps","lang_code":{"code":"en"},"categories_id":1}	656
655	706	categories_translations	2	{"title":"DevOps","lang_code":{"code":"fr"},"categories_id":1}	{"title":"DevOps","lang_code":{"code":"fr"},"categories_id":1}	656
657	708	directus_permissions	38	{"role":null,"collection":"categories_translations","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"categories_translations","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
658	709	directus_permissions	39	{"role":null,"collection":"categories","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"categories","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
659	710	directus_permissions	40	{"role":null,"collection":"articles_translations","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"articles_translations","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
660	711	directus_permissions	41	{"role":null,"collection":"articles_categories","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"articles_categories","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
661	712	directus_permissions	42	{"role":null,"collection":"articles","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"articles","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
662	713	directus_collections	categories	{"collection":"categories","icon":null,"note":null,"display_template":"{{translations.title}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":8,"group":null,"collapse":"open"}	{"display_template":"{{translations.title}}"}	\N
665	716	articles	1	{"tags":["devops"],"translations":{"create":[{"title":"Kubernetes","lang_code":{"code":"en"},"articles_id":"+","body":"## Kubectl is love"}],"update":[],"delete":[]},"categories":{"create":[{"articles_id":"+","categories_id":{"id":1}}],"update":[],"delete":[]}}	{"tags":["devops"],"translations":{"create":[{"title":"Kubernetes","lang_code":{"code":"en"},"articles_id":"+","body":"## Kubectl is love"}],"update":[],"delete":[]},"categories":{"create":[{"articles_id":"+","categories_id":{"id":1}}],"update":[],"delete":[]}}	\N
663	714	articles_categories	1	{"articles_id":1,"categories_id":{"id":1}}	{"articles_id":1,"categories_id":{"id":1}}	665
664	715	articles_translations	1	{"title":"Kubernetes","lang_code":{"code":"en"},"articles_id":1,"body":"## Kubectl is love"}	{"title":"Kubernetes","lang_code":{"code":"en"},"articles_id":1,"body":"## Kubectl is love"}	665
668	719	categories	2	{"translations":{"create":[{"title":"C++","lang_code":{"code":"en"},"categories_id":"+"},{"title":"C++","lang_code":{"code":"fr"},"categories_id":"+"}],"update":[],"delete":[]}}	{"translations":{"create":[{"title":"C++","lang_code":{"code":"en"},"categories_id":"+"},{"title":"C++","lang_code":{"code":"fr"},"categories_id":"+"}],"update":[],"delete":[]}}	\N
666	717	categories_translations	3	{"title":"C++","lang_code":{"code":"en"},"categories_id":2}	{"title":"C++","lang_code":{"code":"en"},"categories_id":2}	668
667	718	categories_translations	4	{"title":"C++","lang_code":{"code":"fr"},"categories_id":2}	{"title":"C++","lang_code":{"code":"fr"},"categories_id":2}	668
669	720	directus_collections	categories	{"collection":"categories","icon":null,"note":null,"display_template":"{{translations.title}} {{id}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":8,"group":null,"collapse":"open"}	{"display_template":"{{translations.title}} {{id}}"}	\N
671	722	articles	1	{"id":1,"date_updated":"2023-02-28T04:06:57.304Z","tags":["devops"],"translations":[1,2],"categories":[1]}	{"date_updated":"2023-02-28T04:06:57.304Z"}	\N
670	721	articles_translations	2	{"title":"Kubernetes","lang_code":{"code":"fr"},"articles_id":"1","body":"# kubernetes c bien"}	{"title":"Kubernetes","lang_code":{"code":"fr"},"articles_id":"1","body":"# kubernetes c bien"}	671
\.


--
-- Data for Name: directus_roles; Type: TABLE DATA; Schema: public; Owner: cv
--

COPY public.directus_roles (id, name, icon, description, ip_access, enforce_tfa, admin_access, app_access) FROM stdin;
af6a6943-47a4-4e26-8b14-c4c86745f89d	Administrator	verified	$t:admin_description	\N	f	t	t
\.


--
-- Data for Name: directus_sessions; Type: TABLE DATA; Schema: public; Owner: cv
--

COPY public.directus_sessions (token, "user", expires, ip, user_agent, share, origin) FROM stdin;
ycPxrWNROhcMIfl4Oc5-PjBCrax2dvNHyl6PW-7PLmvjWUvpZXreHXVv46kwcR1X	a5813e40-3394-40b1-8143-74e680638c71	2023-03-10 07:49:42.683+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	\N	http://localhost:8055
EfIA_sEjTYtAZNgpj0upnCWkeXYAmhyFqJGLH79xyC_Db7oonTj0_u9Tmr6jeJuH	a5813e40-3394-40b1-8143-74e680638c71	2023-03-17 02:49:32.104+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0	\N	http://localhost:8055
\.


--
-- Data for Name: directus_settings; Type: TABLE DATA; Schema: public; Owner: cv
--

COPY public.directus_settings (id, project_name, project_url, project_color, project_logo, public_foreground, public_background, public_note, auth_login_attempts, auth_password_policy, storage_asset_transform, storage_asset_presets, custom_css, storage_default_folder, basemaps, mapbox_key, module_bar, project_descriptor, translation_strings, default_language, custom_aspect_ratios) FROM stdin;
\.


--
-- Data for Name: directus_shares; Type: TABLE DATA; Schema: public; Owner: cv
--

COPY public.directus_shares (id, name, collection, item, role, password, user_created, date_created, date_start, date_end, times_used, max_uses) FROM stdin;
\.


--
-- Data for Name: directus_users; Type: TABLE DATA; Schema: public; Owner: cv
--

COPY public.directus_users (id, first_name, last_name, email, password, location, title, description, tags, avatar, language, theme, tfa_secret, status, role, token, last_access, last_page, provider, external_identifier, auth_data, email_notifications) FROM stdin;
a5813e40-3394-40b1-8143-74e680638c71	Admin	User	loys@loys.me	$argon2id$v=19$m=65536,t=3,p=4$+Hz4zmoQiPSGsVowHx1Hmg$5kJ2tQmh+ZV0vWZ1mFETWihpCkAG2WJEWPzgmu/Doxg	\N	\N	\N	\N	\N	\N	auto	\N	active	af6a6943-47a4-4e26-8b14-c4c86745f89d	\N	2023-03-10 02:49:32.111+00	/content/lang	default	\N	\N	t
\.


--
-- Data for Name: directus_webhooks; Type: TABLE DATA; Schema: public; Owner: cv
--

COPY public.directus_webhooks (id, name, method, url, status, data, actions, collections, headers) FROM stdin;
\.


--
-- Data for Name: formations; Type: TABLE DATA; Schema: public; Owner: cv
--

COPY public.formations (id, start, "end", current, image, type) FROM stdin;
1	2020-09-21 12:00:00	\N	t	40e0ea72-9b8c-47ff-a0fb-2e8faf7dc221	1
2	2022-11-01 12:00:00	2023-08-31 12:00:00	t	2f8f12a0-255f-471e-99c6-8c70a7ea01d8	2
\.


--
-- Data for Name: formations_translations; Type: TABLE DATA; Schema: public; Owner: cv
--

COPY public.formations_translations (id, formations_id, lang_code, institution, skills, name) FROM stdin;
2	1	fr	EPITECH	[{"description":"Gestion de projet"},{"description":"Architecture réseau (DevOps)"},{"description":"Étudier toutes les couches d'abstraction qui font les logiciels d'aujourd'hui, de l'assembleur jusqu'au C++"},{"description":"Développement de programmes complexes tel qu'un debugger pour un environnement Linux"}]	Master en Technologies de l'Information
1	1	en	EPITECH	[{"description":"Project management"},{"description":"Build complex programs such as debuggers in a Linux environnement"},{"description":"Acquire skills in the DevOps sector "},{"description":"Study all layers of abstraction that make computing possible, from Assembly to C++"}]	Master in Information Technology
3	2	en	Indigen	[{"description":"Cross-Platform applications in Flutter"},{"description":"Javascript full-stack development"}]	Javascript full-stack developer
\.


--
-- Data for Name: lang; Type: TABLE DATA; Schema: public; Owner: cv
--

COPY public.lang (code, name) FROM stdin;
en	English
fr	Français
\.


--
-- Data for Name: languages; Type: TABLE DATA; Schema: public; Owner: cv
--

COPY public.languages (id, name, logo, link) FROM stdin;
1	Python	2f3e0031-ff85-4ad1-911c-fe3a2b9a65b1	https://www.python.org/
2	Javascript	ab83e718-aa4a-4c88-bc19-f7514c32eef9	https://developer.mozilla.org/fr/docs/Web/JavaScript
3	HTML	7b39f430-ce41-40a9-aec8-ffe5d849b0bb	https://developer.mozilla.org/fr/docs/Web/HTML
4	CSS	85670c85-30d0-4ba7-a19e-8cbde6b11d09	https://developer.mozilla.org/fr/docs/Web/CSS
\.


--
-- Data for Name: links; Type: TABLE DATA; Schema: public; Owner: cv
--

COPY public.links (id, link, name) FROM stdin;
1	https://github.com/gummyWalrus/Plannifii	Github
\.


--
-- Data for Name: profile; Type: TABLE DATA; Schema: public; Owner: cv
--

COPY public.profile (id, logo, linkedin, email, github, stackoverflow, phone, name) FROM stdin;
1	03c8d29d-fc5a-429b-9299-60eb7fcb8a51	https://www.linkedin.com/in/loys-caucheteux-a99655205/	loys.caucheteux@gmail.com	https://github.com/gummyWalrus	https://stackoverflow.com/users/15122221/loys-caucheteux	+33 7 68 85 35 64	Loys Caucheteux
\.


--
-- Data for Name: profile_section; Type: TABLE DATA; Schema: public; Owner: cv
--

COPY public.profile_section (id, date_created, date_updated, profile, title) FROM stdin;
1	2023-02-22 00:19:50.317+00	2023-02-22 01:21:52.631+00	1	Languages
2	2023-02-27 01:22:51.058+00	\N	1	Softwares
\.


--
-- Data for Name: profile_section_item; Type: TABLE DATA; Schema: public; Owner: cv
--

COPY public.profile_section_item (id, date_created, date_updated, image, section) FROM stdin;
2	2023-02-22 00:19:50.337+00	2023-02-22 00:31:07.259+00	0855e668-4b07-4373-8c76-ff744057f860	1
3	2023-02-22 00:19:50.342+00	2023-02-22 00:33:13.048+00	4acac7d6-e615-4e74-8a16-859a83a1f1fc	1
4	2023-02-22 00:19:50.349+00	2023-02-22 00:33:38.513+00	90f06a4a-caff-4d70-a59e-64f5b61cee7e	1
1	2023-02-22 00:19:50.326+00	2023-02-22 01:05:41.324+00	15794a77-6d4b-436f-8626-a40a24d36da1	1
5	2023-02-27 01:22:51.068+00	\N	b8117a85-157b-49a7-b67b-63a5276e0d42	2
6	2023-02-27 01:22:51.099+00	\N	c8a18cac-14da-47e3-81aa-686640d35ae7	2
\.


--
-- Data for Name: profile_section_item_translations; Type: TABLE DATA; Schema: public; Owner: cv
--

COPY public.profile_section_item_translations (id, profile_section_item_id, lang_code, title, subtitle) FROM stdin;
1	1	en	Javascript, HTML & CSS	To build web apps using various framework
2	2	en	C & C++	To build apps involving low level programming
3	2	fr	C & C++	Utilisé pour développer des logiciels bas niveau
4	3	en	Python	Experienced with machine learning and web development
5	3	fr	Python	Machine learning et développement web
6	4	en	Java	I've developped minecraft mods
7	5	en	Docker	Containerizing my apps
8	5	fr	Docker	Pour avoir des conteneurs
9	6	en	Traefik	Open-source reverse proxy
\.


--
-- Data for Name: profile_section_translations; Type: TABLE DATA; Schema: public; Owner: cv
--

COPY public.profile_section_translations (id, profile_section_id, lang_code, section_title) FROM stdin;
1	1	en	Languages
2	1	fr	Languages pratiqués
\.


--
-- Data for Name: profile_translations; Type: TABLE DATA; Schema: public; Owner: cv
--

COPY public.profile_translations (id, profile_id, lang_code, poste, description) FROM stdin;
1	1	en	Full-stack Developer	Hello, I'm Loys, I'm passionated about computing since I'm 12\n\nI've been tinkering with a lot of different programming languages.\n\nI have the habit to learn by myself and from others, that's why I fit easily in new environnements.\n
2	1	fr	Développeur Full-stack	Passionné d’informatique depuis mes 12 ans,\n\nje profite de ma curiosité naturelle pour me former en autodidacte à de multiples langages de programmation.\n\nCette curiosité me donne envie d’apprendre des autres et de mon environnement,\nc’est ce qui fait toute mon adaptabilité. 
\.


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: cv
--

COPY public.projects (id, name, github, tags, background) FROM stdin;
1	Plannifii	https://github.com/gummyWalrus/Plannifii	[\n    {\n        "name": "Stripe API",\n        "icon": "fa-brands fa-stripe-s",\n        "link": "https://stripe.com"\n    },\n    {\n        "name": "Django",\n        "icon": "fa-brands fa-python",\n        "link": "https://www.djangoproject.com/"\n    },\n    {\n        "name": "Docker",\n        "icon": "fa-brands fa-docker",\n        "link": "https://www.docker.com/"\n    }\n]	9e3206c7-b230-4953-98fe-dad086f421df
2	EpyTodo	https://github.com/gummyWalrus/EpyTodo	[\n    {\n        "name": "React",\n        "icon": "fa-brands fa-react",\n        "link": "https://fr.reactjs.org/"\n    },\n    {\n        "name": "NodeJS",\n        "icon": "fa-brands fa-node-js",\n        "link": "https://nodejs.org/en/about/"\n    },\n    {\n        "name": "MySQL",\n        "icon": "fa-solid fa-database",\n        "link": "https://www.mysql.com/fr/"\n    }\n]	8f110ef2-feb3-4e55-ae2e-47fbb949dfd5
3	City Supplier	https://github.com/gummyWalrus/Hackatown2021-citysupplier	[\n    {\n        "name": "Django",\n        "icon": "fa-brands fa-python",\n        "link": "https://www.djangoproject.com/"\n    },\n    {\n        "name": "Postgres",\n        "icon": "fa-solid fa-database",\n        "link": "http://postgresql.org"\n    },\n    {\n        "name": "Heroku",\n        "icon": "fa-solid fa-server",\n        "link": "https://heroku.com"\n    }\n]	242b35e1-524f-4227-9b6a-7f338b75c0ba
\.


--
-- Data for Name: projects_languages; Type: TABLE DATA; Schema: public; Owner: cv
--

COPY public.projects_languages (id, projects_id, languages_id) FROM stdin;
1	1	1
2	1	3
3	1	4
4	2	2
5	2	3
6	2	4
7	3	1
8	3	3
9	3	4
\.


--
-- Data for Name: projects_links; Type: TABLE DATA; Schema: public; Owner: cv
--

COPY public.projects_links (id, projects_id, links_id) FROM stdin;
1	1	1
\.


--
-- Data for Name: projects_translations; Type: TABLE DATA; Schema: public; Owner: cv
--

COPY public.projects_translations (id, projects_id, lang_code, title, body) FROM stdin;
2	1	en	A shores planner web app	Created and deployed a Django web app on Heroku and using Docker on a VPS. The app includes a premium version wich adds a permission system. 
3	1	fr	Un planning de taches ménagères	 J'ai développé et déployé une application Django via Heroku et via Docker sur un VPS. Une version premium permet de customiser le planning. 
4	2	en	A todo list REST API	 Created a NodeJS REST API with Express and a MySQL server. I used Docker to deploy it has a full-stack app, React in front-end making HTTP requests to the API wich served has backend. 
5	2	fr	 Une todo-list en API REST	 J'ai developpé une API REST en NodeJS avec Express et un serveur MySQL. Je l'ai utilisées dans une application full-stack. ReactJS en front-end utilisant l'API graçe aux requetes http. 
6	3	en	A participative web app for the Hackatown 2021	 I developed this app with a few mates using Django during the Hackatown 2021. We used PostgreSQL as SQL server. 
7	3	fr	Une application participative pour le Hackatown 2021	 J'ai développé ce site avec Django pendant le Hackatown 2021. La base de données était assurée via PostgreSQL 
\.


--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: cv
--

COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- Data for Name: geocode_settings; Type: TABLE DATA; Schema: tiger; Owner: cv
--

COPY tiger.geocode_settings (name, setting, unit, category, short_desc) FROM stdin;
\.


--
-- Data for Name: pagc_gaz; Type: TABLE DATA; Schema: tiger; Owner: cv
--

COPY tiger.pagc_gaz (id, seq, word, stdword, token, is_custom) FROM stdin;
\.


--
-- Data for Name: pagc_lex; Type: TABLE DATA; Schema: tiger; Owner: cv
--

COPY tiger.pagc_lex (id, seq, word, stdword, token, is_custom) FROM stdin;
\.


--
-- Data for Name: pagc_rules; Type: TABLE DATA; Schema: tiger; Owner: cv
--

COPY tiger.pagc_rules (id, rule, is_custom) FROM stdin;
\.


--
-- Data for Name: topology; Type: TABLE DATA; Schema: topology; Owner: cv
--

COPY topology.topology (id, name, srid, "precision", hasz) FROM stdin;
\.


--
-- Data for Name: layer; Type: TABLE DATA; Schema: topology; Owner: cv
--

COPY topology.layer (topology_id, layer_id, schema_name, table_name, feature_column, feature_type, level, child_id) FROM stdin;
\.


--
-- Name: articles_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cv
--

SELECT pg_catalog.setval('public.articles_categories_id_seq', 1, true);


--
-- Name: articles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cv
--

SELECT pg_catalog.setval('public.articles_id_seq', 1, true);


--
-- Name: articles_translations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cv
--

SELECT pg_catalog.setval('public.articles_translations_id_seq', 2, true);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cv
--

SELECT pg_catalog.setval('public.categories_id_seq', 2, true);


--
-- Name: categories_translations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cv
--

SELECT pg_catalog.setval('public.categories_translations_id_seq', 4, true);


--
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cv
--

SELECT pg_catalog.setval('public.comments_id_seq', 3, true);


--
-- Name: directus_activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cv
--

SELECT pg_catalog.setval('public.directus_activity_id_seq', 724, true);


--
-- Name: directus_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cv
--

SELECT pg_catalog.setval('public.directus_fields_id_seq', 173, true);


--
-- Name: directus_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cv
--

SELECT pg_catalog.setval('public.directus_notifications_id_seq', 1, false);


--
-- Name: directus_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cv
--

SELECT pg_catalog.setval('public.directus_permissions_id_seq', 42, true);


--
-- Name: directus_presets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cv
--

SELECT pg_catalog.setval('public.directus_presets_id_seq', 10, true);


--
-- Name: directus_relations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cv
--

SELECT pg_catalog.setval('public.directus_relations_id_seq', 41, true);


--
-- Name: directus_revisions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cv
--

SELECT pg_catalog.setval('public.directus_revisions_id_seq', 671, true);


--
-- Name: directus_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cv
--

SELECT pg_catalog.setval('public.directus_settings_id_seq', 1, false);


--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cv
--

SELECT pg_catalog.setval('public.directus_webhooks_id_seq', 1, false);


--
-- Name: formations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cv
--

SELECT pg_catalog.setval('public.formations_id_seq', 2, true);


--
-- Name: formations_translations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cv
--

SELECT pg_catalog.setval('public.formations_translations_id_seq', 3, true);


--
-- Name: languages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cv
--

SELECT pg_catalog.setval('public.languages_id_seq', 4, true);


--
-- Name: links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cv
--

SELECT pg_catalog.setval('public.links_id_seq', 1, true);


--
-- Name: profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cv
--

SELECT pg_catalog.setval('public.profile_id_seq', 1, true);


--
-- Name: profile_section_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cv
--

SELECT pg_catalog.setval('public.profile_section_id_seq', 2, true);


--
-- Name: profile_section_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cv
--

SELECT pg_catalog.setval('public.profile_section_item_id_seq', 6, true);


--
-- Name: profile_section_item_translations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cv
--

SELECT pg_catalog.setval('public.profile_section_item_translations_id_seq', 9, true);


--
-- Name: profile_section_translations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cv
--

SELECT pg_catalog.setval('public.profile_section_translations_id_seq', 2, true);


--
-- Name: profile_translations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cv
--

SELECT pg_catalog.setval('public.profile_translations_id_seq', 2, true);


--
-- Name: projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cv
--

SELECT pg_catalog.setval('public.projects_id_seq', 3, true);


--
-- Name: projects_languages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cv
--

SELECT pg_catalog.setval('public.projects_languages_id_seq', 9, true);


--
-- Name: projects_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cv
--

SELECT pg_catalog.setval('public.projects_links_id_seq', 1, true);


--
-- Name: projects_translations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cv
--

SELECT pg_catalog.setval('public.projects_translations_id_seq', 7, true);


--
-- Name: articles_categories articles_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.articles_categories
    ADD CONSTRAINT articles_categories_pkey PRIMARY KEY (id);


--
-- Name: articles articles_pkey; Type: CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.articles
    ADD CONSTRAINT articles_pkey PRIMARY KEY (id);


--
-- Name: articles_translations articles_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.articles_translations
    ADD CONSTRAINT articles_translations_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: categories_translations categories_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.categories_translations
    ADD CONSTRAINT categories_translations_pkey PRIMARY KEY (id);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: directus_activity directus_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_activity
    ADD CONSTRAINT directus_activity_pkey PRIMARY KEY (id);


--
-- Name: directus_collections directus_collections_pkey; Type: CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_collections
    ADD CONSTRAINT directus_collections_pkey PRIMARY KEY (collection);


--
-- Name: directus_dashboards directus_dashboards_pkey; Type: CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_dashboards
    ADD CONSTRAINT directus_dashboards_pkey PRIMARY KEY (id);


--
-- Name: directus_fields directus_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_fields
    ADD CONSTRAINT directus_fields_pkey PRIMARY KEY (id);


--
-- Name: directus_files directus_files_pkey; Type: CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_pkey PRIMARY KEY (id);


--
-- Name: directus_flows directus_flows_operation_unique; Type: CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_operation_unique UNIQUE (operation);


--
-- Name: directus_flows directus_flows_pkey; Type: CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_pkey PRIMARY KEY (id);


--
-- Name: directus_folders directus_folders_pkey; Type: CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_pkey PRIMARY KEY (id);


--
-- Name: directus_migrations directus_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_migrations
    ADD CONSTRAINT directus_migrations_pkey PRIMARY KEY (version);


--
-- Name: directus_notifications directus_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_pkey PRIMARY KEY (id);


--
-- Name: directus_operations directus_operations_pkey; Type: CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_pkey PRIMARY KEY (id);


--
-- Name: directus_operations directus_operations_reject_unique; Type: CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_reject_unique UNIQUE (reject);


--
-- Name: directus_operations directus_operations_resolve_unique; Type: CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_resolve_unique UNIQUE (resolve);


--
-- Name: directus_panels directus_panels_pkey; Type: CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_pkey PRIMARY KEY (id);


--
-- Name: directus_permissions directus_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_pkey PRIMARY KEY (id);


--
-- Name: directus_presets directus_presets_pkey; Type: CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_pkey PRIMARY KEY (id);


--
-- Name: directus_relations directus_relations_pkey; Type: CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_relations
    ADD CONSTRAINT directus_relations_pkey PRIMARY KEY (id);


--
-- Name: directus_revisions directus_revisions_pkey; Type: CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_pkey PRIMARY KEY (id);


--
-- Name: directus_roles directus_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_roles
    ADD CONSTRAINT directus_roles_pkey PRIMARY KEY (id);


--
-- Name: directus_sessions directus_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_pkey PRIMARY KEY (token);


--
-- Name: directus_settings directus_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_pkey PRIMARY KEY (id);


--
-- Name: directus_shares directus_shares_pkey; Type: CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_pkey PRIMARY KEY (id);


--
-- Name: directus_users directus_users_email_unique; Type: CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_email_unique UNIQUE (email);


--
-- Name: directus_users directus_users_external_identifier_unique; Type: CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_external_identifier_unique UNIQUE (external_identifier);


--
-- Name: directus_users directus_users_pkey; Type: CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_pkey PRIMARY KEY (id);


--
-- Name: directus_users directus_users_token_unique; Type: CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_token_unique UNIQUE (token);


--
-- Name: directus_webhooks directus_webhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_webhooks
    ADD CONSTRAINT directus_webhooks_pkey PRIMARY KEY (id);


--
-- Name: formations formations_pkey; Type: CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.formations
    ADD CONSTRAINT formations_pkey PRIMARY KEY (id);


--
-- Name: formations_translations formations_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.formations_translations
    ADD CONSTRAINT formations_translations_pkey PRIMARY KEY (id);


--
-- Name: lang lang_pkey; Type: CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.lang
    ADD CONSTRAINT lang_pkey PRIMARY KEY (code);


--
-- Name: languages languages_pkey; Type: CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.languages
    ADD CONSTRAINT languages_pkey PRIMARY KEY (id);


--
-- Name: links links_pkey; Type: CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.links
    ADD CONSTRAINT links_pkey PRIMARY KEY (id);


--
-- Name: profile profile_pkey; Type: CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT profile_pkey PRIMARY KEY (id);


--
-- Name: profile_section_item profile_section_item_pkey; Type: CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.profile_section_item
    ADD CONSTRAINT profile_section_item_pkey PRIMARY KEY (id);


--
-- Name: profile_section_item_translations profile_section_item_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.profile_section_item_translations
    ADD CONSTRAINT profile_section_item_translations_pkey PRIMARY KEY (id);


--
-- Name: profile_section profile_section_pkey; Type: CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.profile_section
    ADD CONSTRAINT profile_section_pkey PRIMARY KEY (id);


--
-- Name: profile_section_translations profile_section_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.profile_section_translations
    ADD CONSTRAINT profile_section_translations_pkey PRIMARY KEY (id);


--
-- Name: profile_translations profile_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.profile_translations
    ADD CONSTRAINT profile_translations_pkey PRIMARY KEY (id);


--
-- Name: projects_languages projects_languages_pkey; Type: CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.projects_languages
    ADD CONSTRAINT projects_languages_pkey PRIMARY KEY (id);


--
-- Name: projects_links projects_links_pkey; Type: CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.projects_links
    ADD CONSTRAINT projects_links_pkey PRIMARY KEY (id);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: projects_translations projects_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.projects_translations
    ADD CONSTRAINT projects_translations_pkey PRIMARY KEY (id);


--
-- Name: articles_categories articles_categories_articles_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.articles_categories
    ADD CONSTRAINT articles_categories_articles_id_foreign FOREIGN KEY (articles_id) REFERENCES public.articles(id) ON DELETE SET NULL;


--
-- Name: articles_categories articles_categories_categories_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.articles_categories
    ADD CONSTRAINT articles_categories_categories_id_foreign FOREIGN KEY (categories_id) REFERENCES public.categories(id) ON DELETE SET NULL;


--
-- Name: articles_translations articles_translations_articles_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.articles_translations
    ADD CONSTRAINT articles_translations_articles_id_foreign FOREIGN KEY (articles_id) REFERENCES public.articles(id) ON DELETE SET NULL;


--
-- Name: articles_translations articles_translations_lang_code_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.articles_translations
    ADD CONSTRAINT articles_translations_lang_code_foreign FOREIGN KEY (lang_code) REFERENCES public.lang(code) ON DELETE SET NULL;


--
-- Name: categories_translations categories_translations_categories_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.categories_translations
    ADD CONSTRAINT categories_translations_categories_id_foreign FOREIGN KEY (categories_id) REFERENCES public.categories(id) ON DELETE SET NULL;


--
-- Name: categories_translations categories_translations_lang_code_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.categories_translations
    ADD CONSTRAINT categories_translations_lang_code_foreign FOREIGN KEY (lang_code) REFERENCES public.lang(code) ON DELETE SET NULL;


--
-- Name: directus_collections directus_collections_group_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_collections
    ADD CONSTRAINT directus_collections_group_foreign FOREIGN KEY ("group") REFERENCES public.directus_collections(collection);


--
-- Name: directus_dashboards directus_dashboards_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_dashboards
    ADD CONSTRAINT directus_dashboards_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_files directus_files_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_folder_foreign FOREIGN KEY (folder) REFERENCES public.directus_folders(id) ON DELETE SET NULL;


--
-- Name: directus_files directus_files_modified_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_modified_by_foreign FOREIGN KEY (modified_by) REFERENCES public.directus_users(id);


--
-- Name: directus_files directus_files_uploaded_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_uploaded_by_foreign FOREIGN KEY (uploaded_by) REFERENCES public.directus_users(id);


--
-- Name: directus_flows directus_flows_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_folders directus_folders_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_folders(id);


--
-- Name: directus_notifications directus_notifications_recipient_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_recipient_foreign FOREIGN KEY (recipient) REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_notifications directus_notifications_sender_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_sender_foreign FOREIGN KEY (sender) REFERENCES public.directus_users(id);


--
-- Name: directus_operations directus_operations_flow_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_flow_foreign FOREIGN KEY (flow) REFERENCES public.directus_flows(id) ON DELETE CASCADE;


--
-- Name: directus_operations directus_operations_reject_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_reject_foreign FOREIGN KEY (reject) REFERENCES public.directus_operations(id);


--
-- Name: directus_operations directus_operations_resolve_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_resolve_foreign FOREIGN KEY (resolve) REFERENCES public.directus_operations(id);


--
-- Name: directus_operations directus_operations_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_panels directus_panels_dashboard_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_dashboard_foreign FOREIGN KEY (dashboard) REFERENCES public.directus_dashboards(id) ON DELETE CASCADE;


--
-- Name: directus_panels directus_panels_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_permissions directus_permissions_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_presets directus_presets_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_presets directus_presets_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_revisions directus_revisions_activity_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_activity_foreign FOREIGN KEY (activity) REFERENCES public.directus_activity(id) ON DELETE CASCADE;


--
-- Name: directus_revisions directus_revisions_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_revisions(id);


--
-- Name: directus_sessions directus_sessions_share_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_share_foreign FOREIGN KEY (share) REFERENCES public.directus_shares(id) ON DELETE CASCADE;


--
-- Name: directus_sessions directus_sessions_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_settings directus_settings_project_logo_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_project_logo_foreign FOREIGN KEY (project_logo) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_background_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_background_foreign FOREIGN KEY (public_background) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_foreground_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_foreground_foreign FOREIGN KEY (public_foreground) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_storage_default_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_storage_default_folder_foreign FOREIGN KEY (storage_default_folder) REFERENCES public.directus_folders(id) ON DELETE SET NULL;


--
-- Name: directus_shares directus_shares_collection_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_collection_foreign FOREIGN KEY (collection) REFERENCES public.directus_collections(collection) ON DELETE CASCADE;


--
-- Name: directus_shares directus_shares_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_shares directus_shares_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_users directus_users_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE SET NULL;


--
-- Name: formations formations_image_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.formations
    ADD CONSTRAINT formations_image_foreign FOREIGN KEY (image) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: formations_translations formations_translations_formations_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.formations_translations
    ADD CONSTRAINT formations_translations_formations_id_foreign FOREIGN KEY (formations_id) REFERENCES public.formations(id) ON DELETE SET NULL;


--
-- Name: formations_translations formations_translations_lang_code_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.formations_translations
    ADD CONSTRAINT formations_translations_lang_code_foreign FOREIGN KEY (lang_code) REFERENCES public.lang(code) ON DELETE SET NULL;


--
-- Name: languages languages_logo_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.languages
    ADD CONSTRAINT languages_logo_foreign FOREIGN KEY (logo) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: profile profile_logo_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT profile_logo_foreign FOREIGN KEY (logo) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: profile_section_item profile_section_item_image_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.profile_section_item
    ADD CONSTRAINT profile_section_item_image_foreign FOREIGN KEY (image) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: profile_section_item profile_section_item_section_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.profile_section_item
    ADD CONSTRAINT profile_section_item_section_foreign FOREIGN KEY (section) REFERENCES public.profile_section(id) ON DELETE SET NULL;


--
-- Name: profile_section_item_translations profile_section_item_translations_lang_code_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.profile_section_item_translations
    ADD CONSTRAINT profile_section_item_translations_lang_code_foreign FOREIGN KEY (lang_code) REFERENCES public.lang(code) ON DELETE SET NULL;


--
-- Name: profile_section_item_translations profile_section_item_translations_profile_se__1b67cb_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.profile_section_item_translations
    ADD CONSTRAINT profile_section_item_translations_profile_se__1b67cb_foreign FOREIGN KEY (profile_section_item_id) REFERENCES public.profile_section_item(id) ON DELETE SET NULL;


--
-- Name: profile_section profile_section_profile_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.profile_section
    ADD CONSTRAINT profile_section_profile_foreign FOREIGN KEY (profile) REFERENCES public.profile(id) ON DELETE SET NULL;


--
-- Name: profile_section_translations profile_section_translations_lang_code_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.profile_section_translations
    ADD CONSTRAINT profile_section_translations_lang_code_foreign FOREIGN KEY (lang_code) REFERENCES public.lang(code) ON DELETE SET NULL;


--
-- Name: profile_section_translations profile_section_translations_profile_section_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.profile_section_translations
    ADD CONSTRAINT profile_section_translations_profile_section_id_foreign FOREIGN KEY (profile_section_id) REFERENCES public.profile_section(id) ON DELETE SET NULL;


--
-- Name: profile_translations profile_translations_lang_code_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.profile_translations
    ADD CONSTRAINT profile_translations_lang_code_foreign FOREIGN KEY (lang_code) REFERENCES public.lang(code) ON DELETE SET NULL;


--
-- Name: profile_translations profile_translations_profile_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.profile_translations
    ADD CONSTRAINT profile_translations_profile_id_foreign FOREIGN KEY (profile_id) REFERENCES public.profile(id) ON DELETE SET NULL;


--
-- Name: projects projects_background_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_background_foreign FOREIGN KEY (background) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: projects_languages projects_languages_languages_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.projects_languages
    ADD CONSTRAINT projects_languages_languages_id_foreign FOREIGN KEY (languages_id) REFERENCES public.languages(id) ON DELETE SET NULL;


--
-- Name: projects_languages projects_languages_projects_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.projects_languages
    ADD CONSTRAINT projects_languages_projects_id_foreign FOREIGN KEY (projects_id) REFERENCES public.projects(id) ON DELETE SET NULL;


--
-- Name: projects_links projects_links_links_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.projects_links
    ADD CONSTRAINT projects_links_links_id_foreign FOREIGN KEY (links_id) REFERENCES public.links(id) ON DELETE SET NULL;


--
-- Name: projects_links projects_links_projects_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.projects_links
    ADD CONSTRAINT projects_links_projects_id_foreign FOREIGN KEY (projects_id) REFERENCES public.projects(id) ON DELETE SET NULL;


--
-- Name: projects_translations projects_translations_lang_code_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.projects_translations
    ADD CONSTRAINT projects_translations_lang_code_foreign FOREIGN KEY (lang_code) REFERENCES public.lang(code) ON DELETE SET NULL;


--
-- Name: projects_translations projects_translations_projects_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: cv
--

ALTER TABLE ONLY public.projects_translations
    ADD CONSTRAINT projects_translations_projects_id_foreign FOREIGN KEY (projects_id) REFERENCES public.projects(id) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

