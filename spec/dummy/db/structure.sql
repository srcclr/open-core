--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: api_keys; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE api_keys (
    id integer NOT NULL,
    key character varying(64) NOT NULL,
    user_id integer,
    created_by_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    allowed_ips inet[],
    hidden boolean DEFAULT false NOT NULL
);


--
-- Name: api_keys_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE api_keys_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: api_keys_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE api_keys_id_seq OWNED BY api_keys.id;


--
-- Name: badge_groupings; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE badge_groupings (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    "position" integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: badge_groupings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE badge_groupings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: badge_groupings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE badge_groupings_id_seq OWNED BY badge_groupings.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE categories (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    color character varying(6) DEFAULT 'AB9364'::character varying NOT NULL,
    topic_id integer,
    topic_count integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id integer NOT NULL,
    topics_year integer DEFAULT 0,
    topics_month integer DEFAULT 0,
    topics_week integer DEFAULT 0,
    slug character varying(255) NOT NULL,
    description text,
    text_color character varying(6) DEFAULT 'FFFFFF'::character varying NOT NULL,
    read_restricted boolean DEFAULT false NOT NULL,
    auto_close_hours double precision,
    post_count integer DEFAULT 0 NOT NULL,
    latest_post_id integer,
    latest_topic_id integer,
    "position" integer,
    parent_category_id integer,
    posts_year integer DEFAULT 0,
    posts_month integer DEFAULT 0,
    posts_week integer DEFAULT 0,
    email_in character varying(255),
    email_in_allow_strangers boolean DEFAULT false,
    topics_day integer DEFAULT 0,
    posts_day integer DEFAULT 0,
    logo_url character varying(255),
    background_url character varying(255),
    allow_badges boolean DEFAULT true NOT NULL,
    name_lower character varying(50) NOT NULL,
    auto_close_based_on_last_post boolean DEFAULT false
);


--
-- Name: posts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE posts (
    id integer NOT NULL,
    user_id integer,
    topic_id integer NOT NULL,
    post_number integer NOT NULL,
    raw text NOT NULL,
    cooked text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    reply_to_post_number integer,
    reply_count integer DEFAULT 0 NOT NULL,
    quote_count integer DEFAULT 0 NOT NULL,
    deleted_at timestamp without time zone,
    off_topic_count integer DEFAULT 0 NOT NULL,
    like_count integer DEFAULT 0 NOT NULL,
    incoming_link_count integer DEFAULT 0 NOT NULL,
    bookmark_count integer DEFAULT 0 NOT NULL,
    avg_time integer,
    score double precision,
    reads integer DEFAULT 0 NOT NULL,
    post_type integer DEFAULT 1 NOT NULL,
    vote_count integer DEFAULT 0 NOT NULL,
    sort_order integer,
    last_editor_id integer,
    hidden boolean DEFAULT false NOT NULL,
    hidden_reason_id integer,
    notify_moderators_count integer DEFAULT 0 NOT NULL,
    spam_count integer DEFAULT 0 NOT NULL,
    illegal_count integer DEFAULT 0 NOT NULL,
    inappropriate_count integer DEFAULT 0 NOT NULL,
    last_version_at timestamp without time zone NOT NULL,
    user_deleted boolean DEFAULT false NOT NULL,
    reply_to_user_id integer,
    percent_rank double precision DEFAULT 1.0,
    notify_user_count integer DEFAULT 0 NOT NULL,
    like_score integer DEFAULT 0 NOT NULL,
    deleted_by_id integer,
    edit_reason character varying(255),
    word_count integer,
    version integer DEFAULT 1 NOT NULL,
    cook_method integer DEFAULT 1 NOT NULL,
    wiki boolean DEFAULT false NOT NULL,
    baked_at timestamp without time zone,
    baked_version integer,
    hidden_at timestamp without time zone,
    self_edits integer DEFAULT 0 NOT NULL,
    reply_quoted boolean DEFAULT false NOT NULL,
    via_email boolean DEFAULT false NOT NULL,
    raw_email text,
    public_version integer DEFAULT 1 NOT NULL
);


--
-- Name: topics; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE topics (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    last_posted_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    views integer DEFAULT 0 NOT NULL,
    posts_count integer DEFAULT 0 NOT NULL,
    user_id integer,
    last_post_user_id integer NOT NULL,
    reply_count integer DEFAULT 0 NOT NULL,
    featured_user1_id integer,
    featured_user2_id integer,
    featured_user3_id integer,
    avg_time integer,
    deleted_at timestamp without time zone,
    highest_post_number integer DEFAULT 0 NOT NULL,
    image_url character varying(255),
    off_topic_count integer DEFAULT 0 NOT NULL,
    like_count integer DEFAULT 0 NOT NULL,
    incoming_link_count integer DEFAULT 0 NOT NULL,
    bookmark_count integer DEFAULT 0 NOT NULL,
    category_id integer,
    visible boolean DEFAULT true NOT NULL,
    moderator_posts_count integer DEFAULT 0 NOT NULL,
    closed boolean DEFAULT false NOT NULL,
    archived boolean DEFAULT false NOT NULL,
    bumped_at timestamp without time zone NOT NULL,
    has_summary boolean DEFAULT false NOT NULL,
    vote_count integer DEFAULT 0 NOT NULL,
    archetype character varying(255) DEFAULT 'regular'::character varying NOT NULL,
    featured_user4_id integer,
    notify_moderators_count integer DEFAULT 0 NOT NULL,
    spam_count integer DEFAULT 0 NOT NULL,
    illegal_count integer DEFAULT 0 NOT NULL,
    inappropriate_count integer DEFAULT 0 NOT NULL,
    pinned_at timestamp without time zone,
    score double precision,
    percent_rank double precision DEFAULT 1.0 NOT NULL,
    notify_user_count integer DEFAULT 0 NOT NULL,
    subtype character varying(255),
    slug character varying(255),
    auto_close_at timestamp without time zone,
    auto_close_user_id integer,
    auto_close_started_at timestamp without time zone,
    deleted_by_id integer,
    participant_count integer DEFAULT 1,
    word_count integer,
    excerpt character varying(1000),
    pinned_globally boolean DEFAULT false NOT NULL,
    auto_close_based_on_last_post boolean DEFAULT false,
    auto_close_hours double precision,
    CONSTRAINT has_category_id CHECK (((category_id IS NOT NULL) OR ((archetype)::text <> 'regular'::text))),
    CONSTRAINT pm_has_no_category CHECK (((category_id IS NULL) OR ((archetype)::text <> 'private_message'::text)))
);


--
-- Name: badge_posts; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW badge_posts AS
 SELECT p.id,
    p.user_id,
    p.topic_id,
    p.post_number,
    p.raw,
    p.cooked,
    p.created_at,
    p.updated_at,
    p.reply_to_post_number,
    p.reply_count,
    p.quote_count,
    p.deleted_at,
    p.off_topic_count,
    p.like_count,
    p.incoming_link_count,
    p.bookmark_count,
    p.avg_time,
    p.score,
    p.reads,
    p.post_type,
    p.vote_count,
    p.sort_order,
    p.last_editor_id,
    p.hidden,
    p.hidden_reason_id,
    p.notify_moderators_count,
    p.spam_count,
    p.illegal_count,
    p.inappropriate_count,
    p.last_version_at,
    p.user_deleted,
    p.reply_to_user_id,
    p.percent_rank,
    p.notify_user_count,
    p.like_score,
    p.deleted_by_id,
    p.edit_reason,
    p.word_count,
    p.version,
    p.cook_method,
    p.wiki,
    p.baked_at,
    p.baked_version,
    p.hidden_at,
    p.self_edits,
    p.reply_quoted
   FROM ((posts p
     JOIN topics t ON ((t.id = p.topic_id)))
     JOIN categories c ON ((c.id = t.category_id)))
  WHERE ((((c.allow_badges AND (p.deleted_at IS NULL)) AND (t.deleted_at IS NULL)) AND (NOT c.read_restricted)) AND t.visible);


--
-- Name: badge_types; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE badge_types (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: badge_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE badge_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: badge_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE badge_types_id_seq OWNED BY badge_types.id;


--
-- Name: badges; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE badges (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    badge_type_id integer NOT NULL,
    grant_count integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    allow_title boolean DEFAULT false NOT NULL,
    multiple_grant boolean DEFAULT false NOT NULL,
    icon character varying(255) DEFAULT 'fa-certificate'::character varying,
    listable boolean DEFAULT true,
    target_posts boolean DEFAULT false,
    query text,
    enabled boolean DEFAULT true NOT NULL,
    auto_revoke boolean DEFAULT true NOT NULL,
    badge_grouping_id integer DEFAULT 5 NOT NULL,
    trigger integer,
    show_posts boolean DEFAULT false NOT NULL,
    system boolean DEFAULT false NOT NULL,
    image character varying(255)
);


--
-- Name: badges_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE badges_id_seq
    START WITH 100
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: badges_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE badges_id_seq OWNED BY badges.id;


--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE categories_id_seq OWNED BY categories.id;


--
-- Name: category_custom_fields; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE category_custom_fields (
    id integer NOT NULL,
    category_id integer NOT NULL,
    name character varying(256) NOT NULL,
    value text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: category_custom_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE category_custom_fields_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: category_custom_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE category_custom_fields_id_seq OWNED BY category_custom_fields.id;


--
-- Name: category_featured_topics; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE category_featured_topics (
    category_id integer NOT NULL,
    topic_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    rank integer DEFAULT 0 NOT NULL,
    id integer NOT NULL
);


--
-- Name: category_featured_topics_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE category_featured_topics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: category_featured_topics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE category_featured_topics_id_seq OWNED BY category_featured_topics.id;


--
-- Name: category_featured_users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE category_featured_users (
    id integer NOT NULL,
    category_id integer,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: category_featured_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE category_featured_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: category_featured_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE category_featured_users_id_seq OWNED BY category_featured_users.id;


--
-- Name: category_groups; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE category_groups (
    id integer NOT NULL,
    category_id integer NOT NULL,
    group_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    permission_type integer DEFAULT 1
);


--
-- Name: category_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE category_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: category_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE category_groups_id_seq OWNED BY category_groups.id;


--
-- Name: category_search_data; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE category_search_data (
    category_id integer NOT NULL,
    search_data tsvector,
    raw_data text,
    locale text
);


--
-- Name: category_users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE category_users (
    id integer NOT NULL,
    category_id integer NOT NULL,
    user_id integer NOT NULL,
    notification_level integer NOT NULL
);


--
-- Name: category_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE category_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: category_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE category_users_id_seq OWNED BY category_users.id;


--
-- Name: color_scheme_colors; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE color_scheme_colors (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    hex character varying(255) NOT NULL,
    color_scheme_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: color_scheme_colors_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE color_scheme_colors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: color_scheme_colors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE color_scheme_colors_id_seq OWNED BY color_scheme_colors.id;


--
-- Name: color_schemes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE color_schemes (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    versioned_id integer,
    version integer DEFAULT 1 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: color_schemes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE color_schemes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: color_schemes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE color_schemes_id_seq OWNED BY color_schemes.id;


--
-- Name: draft_sequences; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE draft_sequences (
    id integer NOT NULL,
    user_id integer NOT NULL,
    draft_key character varying(255) NOT NULL,
    sequence integer NOT NULL
);


--
-- Name: draft_sequences_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE draft_sequences_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: draft_sequences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE draft_sequences_id_seq OWNED BY draft_sequences.id;


--
-- Name: drafts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE drafts (
    id integer NOT NULL,
    user_id integer NOT NULL,
    draft_key character varying(255) NOT NULL,
    data text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    sequence integer DEFAULT 0 NOT NULL
);


--
-- Name: drafts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE drafts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: drafts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE drafts_id_seq OWNED BY drafts.id;


--
-- Name: email_logs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE email_logs (
    id integer NOT NULL,
    to_address character varying(255) NOT NULL,
    email_type character varying(255) NOT NULL,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    reply_key character varying(32),
    post_id integer,
    topic_id integer,
    skipped boolean DEFAULT false,
    skipped_reason character varying(255)
);


--
-- Name: email_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE email_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: email_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE email_logs_id_seq OWNED BY email_logs.id;


--
-- Name: email_tokens; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE email_tokens (
    id integer NOT NULL,
    user_id integer NOT NULL,
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    confirmed boolean DEFAULT false NOT NULL,
    expired boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: email_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE email_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: email_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE email_tokens_id_seq OWNED BY email_tokens.id;


--
-- Name: facebook_user_infos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE facebook_user_infos (
    id integer NOT NULL,
    user_id integer NOT NULL,
    facebook_user_id bigint NOT NULL,
    username character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    email character varying(255),
    gender character varying(255),
    name character varying(255),
    link character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: facebook_user_infos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE facebook_user_infos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: facebook_user_infos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE facebook_user_infos_id_seq OWNED BY facebook_user_infos.id;


--
-- Name: github_user_infos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE github_user_infos (
    id integer NOT NULL,
    user_id integer NOT NULL,
    screen_name character varying(255) NOT NULL,
    github_user_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: github_user_infos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE github_user_infos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: github_user_infos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE github_user_infos_id_seq OWNED BY github_user_infos.id;


--
-- Name: google_user_infos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE google_user_infos (
    id integer NOT NULL,
    user_id integer NOT NULL,
    google_user_id character varying(255) NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    email character varying(255),
    gender character varying(255),
    name character varying(255),
    link character varying(255),
    profile_link character varying(255),
    picture character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: google_user_infos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE google_user_infos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: google_user_infos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE google_user_infos_id_seq OWNED BY google_user_infos.id;


--
-- Name: group_custom_fields; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE group_custom_fields (
    id integer NOT NULL,
    group_id integer NOT NULL,
    name character varying(256) NOT NULL,
    value text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: group_custom_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE group_custom_fields_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: group_custom_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE group_custom_fields_id_seq OWNED BY group_custom_fields.id;


--
-- Name: group_users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE group_users (
    id integer NOT NULL,
    group_id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: group_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE group_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: group_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE group_users_id_seq OWNED BY group_users.id;


--
-- Name: groups; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE groups (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    automatic boolean DEFAULT false NOT NULL,
    user_count integer DEFAULT 0 NOT NULL,
    alias_level integer DEFAULT 0,
    visible boolean DEFAULT true NOT NULL
);


--
-- Name: groups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE groups_id_seq
    START WITH 100
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE groups_id_seq OWNED BY groups.id;


--
-- Name: incoming_domains; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE incoming_domains (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    https boolean DEFAULT false NOT NULL,
    port integer NOT NULL
);


--
-- Name: incoming_domains_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE incoming_domains_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: incoming_domains_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE incoming_domains_id_seq OWNED BY incoming_domains.id;


--
-- Name: incoming_links; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE incoming_links (
    id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    user_id integer,
    ip_address inet,
    current_user_id integer,
    post_id integer NOT NULL,
    incoming_referer_id integer
);


--
-- Name: incoming_links_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE incoming_links_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: incoming_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE incoming_links_id_seq OWNED BY incoming_links.id;


--
-- Name: incoming_referers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE incoming_referers (
    id integer NOT NULL,
    path character varying(1000) NOT NULL,
    incoming_domain_id integer NOT NULL
);


--
-- Name: incoming_referers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE incoming_referers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: incoming_referers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE incoming_referers_id_seq OWNED BY incoming_referers.id;


--
-- Name: invited_groups; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE invited_groups (
    id integer NOT NULL,
    group_id integer,
    invite_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: invited_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE invited_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: invited_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE invited_groups_id_seq OWNED BY invited_groups.id;


--
-- Name: invites; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE invites (
    id integer NOT NULL,
    invite_key character varying(32) NOT NULL,
    email character varying(255),
    invited_by_id integer NOT NULL,
    user_id integer,
    redeemed_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone,
    deleted_by_id integer,
    invalidated_at timestamp without time zone
);


--
-- Name: invites_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE invites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: invites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE invites_id_seq OWNED BY invites.id;


--
-- Name: message_bus; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE message_bus (
    id integer NOT NULL,
    name character varying(255),
    context character varying(255),
    data text,
    created_at timestamp without time zone NOT NULL
);


--
-- Name: message_bus_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE message_bus_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: message_bus_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE message_bus_id_seq OWNED BY message_bus.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE notifications (
    id integer NOT NULL,
    notification_type integer NOT NULL,
    user_id integer NOT NULL,
    data character varying(1000) NOT NULL,
    read boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    topic_id integer,
    post_number integer,
    post_action_id integer
);


--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE notifications_id_seq OWNED BY notifications.id;


--
-- Name: oauth2_user_infos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE oauth2_user_infos (
    id integer NOT NULL,
    user_id integer NOT NULL,
    uid character varying(255) NOT NULL,
    provider character varying(255) NOT NULL,
    email character varying(255),
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: oauth2_user_infos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE oauth2_user_infos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: oauth2_user_infos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE oauth2_user_infos_id_seq OWNED BY oauth2_user_infos.id;


--
-- Name: optimized_images; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE optimized_images (
    id integer NOT NULL,
    sha1 character varying(40) NOT NULL,
    extension character varying(10) NOT NULL,
    width integer NOT NULL,
    height integer NOT NULL,
    upload_id integer NOT NULL,
    url character varying(255) NOT NULL
);


--
-- Name: optimized_images_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE optimized_images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: optimized_images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE optimized_images_id_seq OWNED BY optimized_images.id;


--
-- Name: permalinks; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE permalinks (
    id integer NOT NULL,
    url character varying(1000) NOT NULL,
    topic_id integer,
    post_id integer,
    category_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    external_url character varying(1000)
);


--
-- Name: permalinks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE permalinks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: permalinks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE permalinks_id_seq OWNED BY permalinks.id;


--
-- Name: plugin_store_rows; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE plugin_store_rows (
    id integer NOT NULL,
    plugin_name character varying(255) NOT NULL,
    key character varying(255) NOT NULL,
    type_name character varying(255) NOT NULL,
    value text
);


--
-- Name: plugin_store_rows_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE plugin_store_rows_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: plugin_store_rows_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE plugin_store_rows_id_seq OWNED BY plugin_store_rows.id;


--
-- Name: post_action_types; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE post_action_types (
    name_key character varying(50) NOT NULL,
    is_flag boolean DEFAULT false NOT NULL,
    icon character varying(20),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    id integer NOT NULL,
    "position" integer DEFAULT 0 NOT NULL
);


--
-- Name: post_action_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE post_action_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: post_action_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE post_action_types_id_seq OWNED BY post_action_types.id;


--
-- Name: post_actions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE post_actions (
    id integer NOT NULL,
    post_id integer NOT NULL,
    user_id integer NOT NULL,
    post_action_type_id integer NOT NULL,
    deleted_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_by_id integer,
    related_post_id integer,
    staff_took_action boolean DEFAULT false NOT NULL,
    deferred_by_id integer,
    targets_topic boolean DEFAULT false NOT NULL,
    agreed_at timestamp without time zone,
    agreed_by_id integer,
    deferred_at timestamp without time zone,
    disagreed_at timestamp without time zone,
    disagreed_by_id integer
);


--
-- Name: post_actions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE post_actions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: post_actions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE post_actions_id_seq OWNED BY post_actions.id;


--
-- Name: post_custom_fields; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE post_custom_fields (
    id integer NOT NULL,
    post_id integer NOT NULL,
    name character varying(256) NOT NULL,
    value text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: post_custom_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE post_custom_fields_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: post_custom_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE post_custom_fields_id_seq OWNED BY post_custom_fields.id;


--
-- Name: post_details; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE post_details (
    id integer NOT NULL,
    post_id integer,
    key character varying(255),
    value character varying(255),
    extra text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: post_details_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE post_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: post_details_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE post_details_id_seq OWNED BY post_details.id;


--
-- Name: post_replies; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE post_replies (
    post_id integer,
    reply_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: post_revisions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE post_revisions (
    id integer NOT NULL,
    user_id integer,
    post_id integer,
    modifications text,
    number integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    hidden boolean DEFAULT false NOT NULL
);


--
-- Name: post_revisions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE post_revisions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: post_revisions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE post_revisions_id_seq OWNED BY post_revisions.id;


--
-- Name: post_search_data; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE post_search_data (
    post_id integer NOT NULL,
    search_data tsvector,
    raw_data text,
    locale character varying(255)
);


--
-- Name: post_timings; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE post_timings (
    topic_id integer NOT NULL,
    post_number integer NOT NULL,
    user_id integer NOT NULL,
    msecs integer NOT NULL
);


--
-- Name: post_uploads; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE post_uploads (
    id integer NOT NULL,
    post_id integer NOT NULL,
    upload_id integer NOT NULL
);


--
-- Name: post_uploads_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE post_uploads_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: post_uploads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE post_uploads_id_seq OWNED BY post_uploads.id;


--
-- Name: posts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE posts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE posts_id_seq OWNED BY posts.id;


--
-- Name: quoted_posts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE quoted_posts (
    id integer NOT NULL,
    post_id integer NOT NULL,
    quoted_post_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: quoted_posts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE quoted_posts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: quoted_posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE quoted_posts_id_seq OWNED BY quoted_posts.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: screened_emails; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE screened_emails (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    action_type integer NOT NULL,
    match_count integer DEFAULT 0 NOT NULL,
    last_match_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    ip_address inet
);


--
-- Name: screened_emails_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE screened_emails_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: screened_emails_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE screened_emails_id_seq OWNED BY screened_emails.id;


--
-- Name: screened_ip_addresses; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE screened_ip_addresses (
    id integer NOT NULL,
    ip_address inet NOT NULL,
    action_type integer NOT NULL,
    match_count integer DEFAULT 0 NOT NULL,
    last_match_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: screened_ip_addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE screened_ip_addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: screened_ip_addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE screened_ip_addresses_id_seq OWNED BY screened_ip_addresses.id;


--
-- Name: screened_urls; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE screened_urls (
    id integer NOT NULL,
    url character varying(255) NOT NULL,
    domain character varying(255) NOT NULL,
    action_type integer NOT NULL,
    match_count integer DEFAULT 0 NOT NULL,
    last_match_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    ip_address inet
);


--
-- Name: screened_urls_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE screened_urls_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: screened_urls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE screened_urls_id_seq OWNED BY screened_urls.id;


--
-- Name: single_sign_on_records; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE single_sign_on_records (
    id integer NOT NULL,
    user_id integer NOT NULL,
    external_id character varying(255) NOT NULL,
    last_payload text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    external_username character varying(255),
    external_email character varying(255),
    external_name character varying(255),
    external_avatar_url character varying(255)
);


--
-- Name: single_sign_on_records_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE single_sign_on_records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: single_sign_on_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE single_sign_on_records_id_seq OWNED BY single_sign_on_records.id;


--
-- Name: site_customizations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE site_customizations (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    stylesheet text,
    header text,
    user_id integer NOT NULL,
    enabled boolean NOT NULL,
    key character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    stylesheet_baked text DEFAULT ''::text NOT NULL,
    mobile_stylesheet text,
    mobile_header text,
    mobile_stylesheet_baked text,
    footer text,
    mobile_footer text,
    head_tag text,
    body_tag text
);


--
-- Name: site_customizations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE site_customizations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: site_customizations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE site_customizations_id_seq OWNED BY site_customizations.id;


--
-- Name: site_settings; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE site_settings (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    data_type integer NOT NULL,
    value text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: site_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE site_settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: site_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE site_settings_id_seq OWNED BY site_settings.id;


--
-- Name: site_texts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE site_texts (
    text_type character varying(255) NOT NULL,
    value text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: top_topics; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE top_topics (
    id integer NOT NULL,
    topic_id integer,
    yearly_posts_count integer DEFAULT 0 NOT NULL,
    yearly_views_count integer DEFAULT 0 NOT NULL,
    yearly_likes_count integer DEFAULT 0 NOT NULL,
    monthly_posts_count integer DEFAULT 0 NOT NULL,
    monthly_views_count integer DEFAULT 0 NOT NULL,
    monthly_likes_count integer DEFAULT 0 NOT NULL,
    weekly_posts_count integer DEFAULT 0 NOT NULL,
    weekly_views_count integer DEFAULT 0 NOT NULL,
    weekly_likes_count integer DEFAULT 0 NOT NULL,
    daily_posts_count integer DEFAULT 0 NOT NULL,
    daily_views_count integer DEFAULT 0 NOT NULL,
    daily_likes_count integer DEFAULT 0 NOT NULL,
    yearly_score double precision DEFAULT 0,
    monthly_score double precision DEFAULT 0,
    weekly_score double precision DEFAULT 0,
    daily_score double precision DEFAULT 0
);


--
-- Name: top_topics_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE top_topics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: top_topics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE top_topics_id_seq OWNED BY top_topics.id;


--
-- Name: topic_allowed_groups; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE topic_allowed_groups (
    id integer NOT NULL,
    group_id integer NOT NULL,
    topic_id integer NOT NULL
);


--
-- Name: topic_allowed_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE topic_allowed_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: topic_allowed_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE topic_allowed_groups_id_seq OWNED BY topic_allowed_groups.id;


--
-- Name: topic_allowed_users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE topic_allowed_users (
    id integer NOT NULL,
    user_id integer NOT NULL,
    topic_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: topic_allowed_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE topic_allowed_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: topic_allowed_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE topic_allowed_users_id_seq OWNED BY topic_allowed_users.id;


--
-- Name: topic_custom_fields; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE topic_custom_fields (
    id integer NOT NULL,
    topic_id integer NOT NULL,
    name character varying(256) NOT NULL,
    value text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: topic_custom_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE topic_custom_fields_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: topic_custom_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE topic_custom_fields_id_seq OWNED BY topic_custom_fields.id;


--
-- Name: topic_embeds; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE topic_embeds (
    id integer NOT NULL,
    topic_id integer NOT NULL,
    post_id integer NOT NULL,
    embed_url character varying(255) NOT NULL,
    content_sha1 character varying(40),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: topic_embeds_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE topic_embeds_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: topic_embeds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE topic_embeds_id_seq OWNED BY topic_embeds.id;


--
-- Name: topic_invites; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE topic_invites (
    id integer NOT NULL,
    topic_id integer NOT NULL,
    invite_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: topic_invites_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE topic_invites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: topic_invites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE topic_invites_id_seq OWNED BY topic_invites.id;


--
-- Name: topic_link_clicks; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE topic_link_clicks (
    id integer NOT NULL,
    topic_link_id integer NOT NULL,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    ip_address inet NOT NULL
);


--
-- Name: topic_link_clicks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE topic_link_clicks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: topic_link_clicks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE topic_link_clicks_id_seq OWNED BY topic_link_clicks.id;


--
-- Name: topic_links; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE topic_links (
    id integer NOT NULL,
    topic_id integer NOT NULL,
    post_id integer,
    user_id integer NOT NULL,
    url character varying(500) NOT NULL,
    domain character varying(100) NOT NULL,
    internal boolean DEFAULT false NOT NULL,
    link_topic_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    reflection boolean DEFAULT false,
    clicks integer DEFAULT 0 NOT NULL,
    link_post_id integer,
    title character varying(255),
    crawled_at timestamp without time zone,
    quote boolean DEFAULT false NOT NULL
);


--
-- Name: topic_links_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE topic_links_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: topic_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE topic_links_id_seq OWNED BY topic_links.id;


--
-- Name: topic_search_data; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE topic_search_data (
    topic_id integer NOT NULL,
    raw_data text,
    locale character varying(255) NOT NULL,
    search_data tsvector
);


--
-- Name: topic_users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE topic_users (
    user_id integer NOT NULL,
    topic_id integer NOT NULL,
    posted boolean DEFAULT false NOT NULL,
    last_read_post_number integer,
    highest_seen_post_number integer,
    last_visited_at timestamp without time zone,
    first_visited_at timestamp without time zone,
    notification_level integer DEFAULT 1 NOT NULL,
    notifications_changed_at timestamp without time zone,
    notifications_reason_id integer,
    total_msecs_viewed integer DEFAULT 0 NOT NULL,
    cleared_pinned_at timestamp without time zone,
    id integer NOT NULL,
    last_emailed_post_number integer,
    liked boolean DEFAULT false,
    bookmarked boolean DEFAULT false
);


--
-- Name: topic_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE topic_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: topic_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE topic_users_id_seq OWNED BY topic_users.id;


--
-- Name: topic_views; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE topic_views (
    topic_id integer NOT NULL,
    viewed_at date NOT NULL,
    user_id integer,
    ip_address inet NOT NULL
);


--
-- Name: topics_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE topics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: topics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE topics_id_seq OWNED BY topics.id;


--
-- Name: twitter_user_infos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE twitter_user_infos (
    id integer NOT NULL,
    user_id integer NOT NULL,
    screen_name character varying(255) NOT NULL,
    twitter_user_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: twitter_user_infos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE twitter_user_infos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: twitter_user_infos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE twitter_user_infos_id_seq OWNED BY twitter_user_infos.id;


--
-- Name: uploads; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE uploads (
    id integer NOT NULL,
    user_id integer NOT NULL,
    original_filename character varying(255) NOT NULL,
    filesize integer NOT NULL,
    width integer,
    height integer,
    url character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    sha1 character varying(40),
    origin character varying(1000),
    retain_hours integer
);


--
-- Name: uploads_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE uploads_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: uploads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE uploads_id_seq OWNED BY uploads.id;


--
-- Name: user_actions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE user_actions (
    id integer NOT NULL,
    action_type integer NOT NULL,
    user_id integer NOT NULL,
    target_topic_id integer,
    target_post_id integer,
    target_user_id integer,
    acting_user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: user_actions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_actions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_actions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_actions_id_seq OWNED BY user_actions.id;


--
-- Name: user_avatars; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE user_avatars (
    id integer NOT NULL,
    user_id integer NOT NULL,
    custom_upload_id integer,
    gravatar_upload_id integer,
    last_gravatar_download_attempt timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: user_avatars_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_avatars_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_avatars_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_avatars_id_seq OWNED BY user_avatars.id;


--
-- Name: user_badges; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE user_badges (
    id integer NOT NULL,
    badge_id integer NOT NULL,
    user_id integer NOT NULL,
    granted_at timestamp without time zone NOT NULL,
    granted_by_id integer NOT NULL,
    post_id integer,
    notification_id integer,
    seq integer DEFAULT 0 NOT NULL
);


--
-- Name: user_badges_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_badges_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_badges_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_badges_id_seq OWNED BY user_badges.id;


--
-- Name: user_custom_fields; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE user_custom_fields (
    id integer NOT NULL,
    user_id integer NOT NULL,
    name character varying(256) NOT NULL,
    value text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: user_custom_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_custom_fields_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_custom_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_custom_fields_id_seq OWNED BY user_custom_fields.id;


--
-- Name: user_exports; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE user_exports (
    id integer NOT NULL,
    export_type character varying(255) NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: user_exports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_exports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_exports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_exports_id_seq OWNED BY user_exports.id;


--
-- Name: user_fields; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE user_fields (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    field_type character varying(255) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    editable boolean DEFAULT false NOT NULL,
    description character varying(255) NOT NULL,
    required boolean DEFAULT true NOT NULL
);


--
-- Name: user_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_fields_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_fields_id_seq OWNED BY user_fields.id;


--
-- Name: user_histories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE user_histories (
    id integer NOT NULL,
    action integer NOT NULL,
    acting_user_id integer,
    target_user_id integer,
    details text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    context character varying(255),
    ip_address character varying(255),
    email character varying(255),
    subject text,
    previous_value text,
    new_value text,
    topic_id integer,
    admin_only boolean DEFAULT false,
    post_id integer
);


--
-- Name: user_histories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_histories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_histories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_histories_id_seq OWNED BY user_histories.id;


--
-- Name: user_open_ids; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE user_open_ids (
    id integer NOT NULL,
    user_id integer NOT NULL,
    email character varying(255) NOT NULL,
    url character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    active boolean NOT NULL
);


--
-- Name: user_open_ids_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_open_ids_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_open_ids_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_open_ids_id_seq OWNED BY user_open_ids.id;


--
-- Name: user_profiles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE user_profiles (
    user_id integer NOT NULL,
    location character varying(255),
    website character varying(255),
    bio_raw text,
    bio_cooked text,
    profile_background character varying(255),
    dismissed_banner_key integer,
    bio_cooked_version integer,
    badge_granted_title boolean DEFAULT false,
    card_background character varying(255),
    card_image_badge_id integer
);


--
-- Name: user_search_data; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE user_search_data (
    user_id integer NOT NULL,
    search_data tsvector,
    raw_data text,
    locale text
);


--
-- Name: user_stats; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE user_stats (
    user_id integer NOT NULL,
    topics_entered integer DEFAULT 0 NOT NULL,
    time_read integer DEFAULT 0 NOT NULL,
    days_visited integer DEFAULT 0 NOT NULL,
    posts_read_count integer DEFAULT 0 NOT NULL,
    likes_given integer DEFAULT 0 NOT NULL,
    likes_received integer DEFAULT 0 NOT NULL,
    topic_reply_count integer DEFAULT 0 NOT NULL,
    new_since timestamp without time zone NOT NULL,
    read_faq timestamp without time zone,
    first_post_created_at timestamp without time zone,
    post_count integer DEFAULT 0 NOT NULL,
    topic_count integer DEFAULT 0 NOT NULL
);


--
-- Name: user_visits; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE user_visits (
    id integer NOT NULL,
    user_id integer NOT NULL,
    visited_at date NOT NULL,
    posts_read integer DEFAULT 0
);


--
-- Name: user_visits_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_visits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_visits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_visits_id_seq OWNED BY user_visits.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    username character varying(60) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    name character varying(255),
    seen_notification_id integer DEFAULT 0 NOT NULL,
    last_posted_at timestamp without time zone,
    email character varying(256) NOT NULL,
    password_hash character varying(64),
    salt character varying(32),
    active boolean DEFAULT false NOT NULL,
    username_lower character varying(60) NOT NULL,
    auth_token character varying(32),
    last_seen_at timestamp without time zone,
    admin boolean DEFAULT false NOT NULL,
    last_emailed_at timestamp without time zone,
    email_digests boolean NOT NULL,
    trust_level integer NOT NULL,
    email_private_messages boolean DEFAULT true,
    email_direct boolean DEFAULT true NOT NULL,
    approved boolean DEFAULT false NOT NULL,
    approved_by_id integer,
    approved_at timestamp without time zone,
    digest_after_days integer,
    previous_visit_at timestamp without time zone,
    suspended_at timestamp without time zone,
    suspended_till timestamp without time zone,
    date_of_birth date,
    auto_track_topics_after_msecs integer,
    views integer DEFAULT 0 NOT NULL,
    flag_level integer DEFAULT 0 NOT NULL,
    ip_address inet,
    new_topic_duration_minutes integer,
    external_links_in_new_tab boolean NOT NULL,
    enable_quoting boolean DEFAULT true NOT NULL,
    moderator boolean DEFAULT false,
    blocked boolean DEFAULT false,
    dynamic_favicon boolean DEFAULT false NOT NULL,
    title character varying(255),
    uploaded_avatar_id integer,
    email_always boolean DEFAULT false NOT NULL,
    mailing_list_mode boolean DEFAULT false NOT NULL,
    locale character varying(10),
    primary_group_id integer,
    registration_ip_address inet,
    last_redirected_to_top_at timestamp without time zone,
    disable_jump_reply boolean DEFAULT false NOT NULL,
    edit_history_public boolean DEFAULT false NOT NULL,
    trust_level_locked boolean DEFAULT false NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: versions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE versions (
    id integer NOT NULL,
    versioned_id integer,
    versioned_type character varying(255),
    user_id integer,
    user_type character varying(255),
    user_name character varying(255),
    modifications text,
    number integer,
    reverted_from integer,
    tag character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: versions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE versions_id_seq OWNED BY versions.id;


--
-- Name: warnings; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE warnings (
    id integer NOT NULL,
    topic_id integer NOT NULL,
    user_id integer NOT NULL,
    created_by_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: warnings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE warnings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: warnings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE warnings_id_seq OWNED BY warnings.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY api_keys ALTER COLUMN id SET DEFAULT nextval('api_keys_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY badge_groupings ALTER COLUMN id SET DEFAULT nextval('badge_groupings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY badge_types ALTER COLUMN id SET DEFAULT nextval('badge_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY badges ALTER COLUMN id SET DEFAULT nextval('badges_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY categories ALTER COLUMN id SET DEFAULT nextval('categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY category_custom_fields ALTER COLUMN id SET DEFAULT nextval('category_custom_fields_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY category_featured_topics ALTER COLUMN id SET DEFAULT nextval('category_featured_topics_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY category_featured_users ALTER COLUMN id SET DEFAULT nextval('category_featured_users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY category_groups ALTER COLUMN id SET DEFAULT nextval('category_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY category_users ALTER COLUMN id SET DEFAULT nextval('category_users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY color_scheme_colors ALTER COLUMN id SET DEFAULT nextval('color_scheme_colors_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY color_schemes ALTER COLUMN id SET DEFAULT nextval('color_schemes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY draft_sequences ALTER COLUMN id SET DEFAULT nextval('draft_sequences_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY drafts ALTER COLUMN id SET DEFAULT nextval('drafts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY email_logs ALTER COLUMN id SET DEFAULT nextval('email_logs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY email_tokens ALTER COLUMN id SET DEFAULT nextval('email_tokens_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY facebook_user_infos ALTER COLUMN id SET DEFAULT nextval('facebook_user_infos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY github_user_infos ALTER COLUMN id SET DEFAULT nextval('github_user_infos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY google_user_infos ALTER COLUMN id SET DEFAULT nextval('google_user_infos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY group_custom_fields ALTER COLUMN id SET DEFAULT nextval('group_custom_fields_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY group_users ALTER COLUMN id SET DEFAULT nextval('group_users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY groups ALTER COLUMN id SET DEFAULT nextval('groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY incoming_domains ALTER COLUMN id SET DEFAULT nextval('incoming_domains_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY incoming_links ALTER COLUMN id SET DEFAULT nextval('incoming_links_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY incoming_referers ALTER COLUMN id SET DEFAULT nextval('incoming_referers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY invited_groups ALTER COLUMN id SET DEFAULT nextval('invited_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY invites ALTER COLUMN id SET DEFAULT nextval('invites_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY message_bus ALTER COLUMN id SET DEFAULT nextval('message_bus_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY notifications ALTER COLUMN id SET DEFAULT nextval('notifications_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY oauth2_user_infos ALTER COLUMN id SET DEFAULT nextval('oauth2_user_infos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY optimized_images ALTER COLUMN id SET DEFAULT nextval('optimized_images_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY permalinks ALTER COLUMN id SET DEFAULT nextval('permalinks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY plugin_store_rows ALTER COLUMN id SET DEFAULT nextval('plugin_store_rows_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY post_action_types ALTER COLUMN id SET DEFAULT nextval('post_action_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY post_actions ALTER COLUMN id SET DEFAULT nextval('post_actions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY post_custom_fields ALTER COLUMN id SET DEFAULT nextval('post_custom_fields_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY post_details ALTER COLUMN id SET DEFAULT nextval('post_details_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY post_revisions ALTER COLUMN id SET DEFAULT nextval('post_revisions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY post_uploads ALTER COLUMN id SET DEFAULT nextval('post_uploads_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY posts ALTER COLUMN id SET DEFAULT nextval('posts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY quoted_posts ALTER COLUMN id SET DEFAULT nextval('quoted_posts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY screened_emails ALTER COLUMN id SET DEFAULT nextval('screened_emails_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY screened_ip_addresses ALTER COLUMN id SET DEFAULT nextval('screened_ip_addresses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY screened_urls ALTER COLUMN id SET DEFAULT nextval('screened_urls_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY single_sign_on_records ALTER COLUMN id SET DEFAULT nextval('single_sign_on_records_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY site_customizations ALTER COLUMN id SET DEFAULT nextval('site_customizations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY site_settings ALTER COLUMN id SET DEFAULT nextval('site_settings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY top_topics ALTER COLUMN id SET DEFAULT nextval('top_topics_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY topic_allowed_groups ALTER COLUMN id SET DEFAULT nextval('topic_allowed_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY topic_allowed_users ALTER COLUMN id SET DEFAULT nextval('topic_allowed_users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY topic_custom_fields ALTER COLUMN id SET DEFAULT nextval('topic_custom_fields_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY topic_embeds ALTER COLUMN id SET DEFAULT nextval('topic_embeds_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY topic_invites ALTER COLUMN id SET DEFAULT nextval('topic_invites_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY topic_link_clicks ALTER COLUMN id SET DEFAULT nextval('topic_link_clicks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY topic_links ALTER COLUMN id SET DEFAULT nextval('topic_links_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY topic_users ALTER COLUMN id SET DEFAULT nextval('topic_users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY topics ALTER COLUMN id SET DEFAULT nextval('topics_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY twitter_user_infos ALTER COLUMN id SET DEFAULT nextval('twitter_user_infos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY uploads ALTER COLUMN id SET DEFAULT nextval('uploads_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_actions ALTER COLUMN id SET DEFAULT nextval('user_actions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_avatars ALTER COLUMN id SET DEFAULT nextval('user_avatars_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_badges ALTER COLUMN id SET DEFAULT nextval('user_badges_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_custom_fields ALTER COLUMN id SET DEFAULT nextval('user_custom_fields_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_exports ALTER COLUMN id SET DEFAULT nextval('user_exports_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_fields ALTER COLUMN id SET DEFAULT nextval('user_fields_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_histories ALTER COLUMN id SET DEFAULT nextval('user_histories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_open_ids ALTER COLUMN id SET DEFAULT nextval('user_open_ids_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_visits ALTER COLUMN id SET DEFAULT nextval('user_visits_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY versions ALTER COLUMN id SET DEFAULT nextval('versions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY warnings ALTER COLUMN id SET DEFAULT nextval('warnings_id_seq'::regclass);


--
-- Name: actions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY user_actions
    ADD CONSTRAINT actions_pkey PRIMARY KEY (id);


--
-- Name: api_keys_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY api_keys
    ADD CONSTRAINT api_keys_pkey PRIMARY KEY (id);


--
-- Name: badge_groupings_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY badge_groupings
    ADD CONSTRAINT badge_groupings_pkey PRIMARY KEY (id);


--
-- Name: badge_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY badge_types
    ADD CONSTRAINT badge_types_pkey PRIMARY KEY (id);


--
-- Name: badges_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY badges
    ADD CONSTRAINT badges_pkey PRIMARY KEY (id);


--
-- Name: blocked_emails_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY screened_emails
    ADD CONSTRAINT blocked_emails_pkey PRIMARY KEY (id);


--
-- Name: categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: categories_search_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY category_search_data
    ADD CONSTRAINT categories_search_pkey PRIMARY KEY (category_id);


--
-- Name: category_custom_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY category_custom_fields
    ADD CONSTRAINT category_custom_fields_pkey PRIMARY KEY (id);


--
-- Name: category_featured_topics_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY category_featured_topics
    ADD CONSTRAINT category_featured_topics_pkey PRIMARY KEY (id);


--
-- Name: category_featured_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY category_featured_users
    ADD CONSTRAINT category_featured_users_pkey PRIMARY KEY (id);


--
-- Name: category_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY category_groups
    ADD CONSTRAINT category_groups_pkey PRIMARY KEY (id);


--
-- Name: category_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY category_users
    ADD CONSTRAINT category_users_pkey PRIMARY KEY (id);


--
-- Name: color_scheme_colors_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY color_scheme_colors
    ADD CONSTRAINT color_scheme_colors_pkey PRIMARY KEY (id);


--
-- Name: color_schemes_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY color_schemes
    ADD CONSTRAINT color_schemes_pkey PRIMARY KEY (id);


--
-- Name: csv_export_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY user_exports
    ADD CONSTRAINT csv_export_logs_pkey PRIMARY KEY (id);


--
-- Name: draft_sequences_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY draft_sequences
    ADD CONSTRAINT draft_sequences_pkey PRIMARY KEY (id);


--
-- Name: drafts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY drafts
    ADD CONSTRAINT drafts_pkey PRIMARY KEY (id);


--
-- Name: email_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY email_logs
    ADD CONSTRAINT email_logs_pkey PRIMARY KEY (id);


--
-- Name: email_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY email_tokens
    ADD CONSTRAINT email_tokens_pkey PRIMARY KEY (id);


--
-- Name: facebook_user_infos_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY facebook_user_infos
    ADD CONSTRAINT facebook_user_infos_pkey PRIMARY KEY (id);


--
-- Name: forum_thread_link_clicks_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY topic_link_clicks
    ADD CONSTRAINT forum_thread_link_clicks_pkey PRIMARY KEY (id);


--
-- Name: forum_thread_links_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY topic_links
    ADD CONSTRAINT forum_thread_links_pkey PRIMARY KEY (id);


--
-- Name: forum_threads_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY topics
    ADD CONSTRAINT forum_threads_pkey PRIMARY KEY (id);


--
-- Name: github_user_infos_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY github_user_infos
    ADD CONSTRAINT github_user_infos_pkey PRIMARY KEY (id);


--
-- Name: google_user_infos_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY google_user_infos
    ADD CONSTRAINT google_user_infos_pkey PRIMARY KEY (id);


--
-- Name: group_custom_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY group_custom_fields
    ADD CONSTRAINT group_custom_fields_pkey PRIMARY KEY (id);


--
-- Name: group_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY group_users
    ADD CONSTRAINT group_users_pkey PRIMARY KEY (id);


--
-- Name: groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (id);


--
-- Name: incoming_domains_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY incoming_domains
    ADD CONSTRAINT incoming_domains_pkey PRIMARY KEY (id);


--
-- Name: incoming_links_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY incoming_links
    ADD CONSTRAINT incoming_links_pkey PRIMARY KEY (id);


--
-- Name: incoming_referers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY incoming_referers
    ADD CONSTRAINT incoming_referers_pkey PRIMARY KEY (id);


--
-- Name: invited_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY invited_groups
    ADD CONSTRAINT invited_groups_pkey PRIMARY KEY (id);


--
-- Name: invites_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY invites
    ADD CONSTRAINT invites_pkey PRIMARY KEY (id);


--
-- Name: message_bus_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY message_bus
    ADD CONSTRAINT message_bus_pkey PRIMARY KEY (id);


--
-- Name: notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: oauth2_user_infos_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY oauth2_user_infos
    ADD CONSTRAINT oauth2_user_infos_pkey PRIMARY KEY (id);


--
-- Name: optimized_images_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY optimized_images
    ADD CONSTRAINT optimized_images_pkey PRIMARY KEY (id);


--
-- Name: permalinks_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY permalinks
    ADD CONSTRAINT permalinks_pkey PRIMARY KEY (id);


--
-- Name: plugin_store_rows_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY plugin_store_rows
    ADD CONSTRAINT plugin_store_rows_pkey PRIMARY KEY (id);


--
-- Name: post_action_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY post_action_types
    ADD CONSTRAINT post_action_types_pkey PRIMARY KEY (id);


--
-- Name: post_actions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY post_actions
    ADD CONSTRAINT post_actions_pkey PRIMARY KEY (id);


--
-- Name: post_custom_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY post_custom_fields
    ADD CONSTRAINT post_custom_fields_pkey PRIMARY KEY (id);


--
-- Name: post_details_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY post_details
    ADD CONSTRAINT post_details_pkey PRIMARY KEY (id);


--
-- Name: post_revisions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY post_revisions
    ADD CONSTRAINT post_revisions_pkey PRIMARY KEY (id);


--
-- Name: post_uploads_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY post_uploads
    ADD CONSTRAINT post_uploads_pkey PRIMARY KEY (id);


--
-- Name: posts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- Name: posts_search_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY post_search_data
    ADD CONSTRAINT posts_search_pkey PRIMARY KEY (post_id);


--
-- Name: quoted_posts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY quoted_posts
    ADD CONSTRAINT quoted_posts_pkey PRIMARY KEY (id);


--
-- Name: screened_ip_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY screened_ip_addresses
    ADD CONSTRAINT screened_ip_addresses_pkey PRIMARY KEY (id);


--
-- Name: screened_urls_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY screened_urls
    ADD CONSTRAINT screened_urls_pkey PRIMARY KEY (id);


--
-- Name: single_sign_on_records_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY single_sign_on_records
    ADD CONSTRAINT single_sign_on_records_pkey PRIMARY KEY (id);


--
-- Name: site_customizations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY site_customizations
    ADD CONSTRAINT site_customizations_pkey PRIMARY KEY (id);


--
-- Name: site_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY site_settings
    ADD CONSTRAINT site_settings_pkey PRIMARY KEY (id);


--
-- Name: top_topics_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY top_topics
    ADD CONSTRAINT top_topics_pkey PRIMARY KEY (id);


--
-- Name: topic_allowed_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY topic_allowed_groups
    ADD CONSTRAINT topic_allowed_groups_pkey PRIMARY KEY (id);


--
-- Name: topic_allowed_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY topic_allowed_users
    ADD CONSTRAINT topic_allowed_users_pkey PRIMARY KEY (id);


--
-- Name: topic_custom_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY topic_custom_fields
    ADD CONSTRAINT topic_custom_fields_pkey PRIMARY KEY (id);


--
-- Name: topic_embeds_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY topic_embeds
    ADD CONSTRAINT topic_embeds_pkey PRIMARY KEY (id);


--
-- Name: topic_invites_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY topic_invites
    ADD CONSTRAINT topic_invites_pkey PRIMARY KEY (id);


--
-- Name: topic_search_data_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY topic_search_data
    ADD CONSTRAINT topic_search_data_pkey PRIMARY KEY (topic_id);


--
-- Name: topic_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY topic_users
    ADD CONSTRAINT topic_users_pkey PRIMARY KEY (id);


--
-- Name: twitter_user_infos_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY twitter_user_infos
    ADD CONSTRAINT twitter_user_infos_pkey PRIMARY KEY (id);


--
-- Name: uploads_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY uploads
    ADD CONSTRAINT uploads_pkey PRIMARY KEY (id);


--
-- Name: user_avatars_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY user_avatars
    ADD CONSTRAINT user_avatars_pkey PRIMARY KEY (id);


--
-- Name: user_badges_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY user_badges
    ADD CONSTRAINT user_badges_pkey PRIMARY KEY (id);


--
-- Name: user_custom_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY user_custom_fields
    ADD CONSTRAINT user_custom_fields_pkey PRIMARY KEY (id);


--
-- Name: user_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY user_fields
    ADD CONSTRAINT user_fields_pkey PRIMARY KEY (id);


--
-- Name: user_histories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY user_histories
    ADD CONSTRAINT user_histories_pkey PRIMARY KEY (id);


--
-- Name: user_open_ids_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY user_open_ids
    ADD CONSTRAINT user_open_ids_pkey PRIMARY KEY (id);


--
-- Name: user_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY user_profiles
    ADD CONSTRAINT user_profiles_pkey PRIMARY KEY (user_id);


--
-- Name: user_stats_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY user_stats
    ADD CONSTRAINT user_stats_pkey PRIMARY KEY (user_id);


--
-- Name: user_visits_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY user_visits
    ADD CONSTRAINT user_visits_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users_search_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY user_search_data
    ADD CONSTRAINT users_search_pkey PRIMARY KEY (user_id);


--
-- Name: versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY versions
    ADD CONSTRAINT versions_pkey PRIMARY KEY (id);


--
-- Name: warnings_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY warnings
    ADD CONSTRAINT warnings_pkey PRIMARY KEY (id);


--
-- Name: by_link; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX by_link ON topic_link_clicks USING btree (topic_link_id);


--
-- Name: cat_featured_threads; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX cat_featured_threads ON category_featured_topics USING btree (category_id, topic_id);


--
-- Name: idx_posts_created_at_topic_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX idx_posts_created_at_topic_id ON posts USING btree (created_at, topic_id) WHERE (deleted_at IS NULL);


--
-- Name: idx_posts_user_id_deleted_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX idx_posts_user_id_deleted_at ON posts USING btree (user_id) WHERE (deleted_at IS NULL);


--
-- Name: idx_search_category; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX idx_search_category ON category_search_data USING gin (search_data);


--
-- Name: idx_search_post; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX idx_search_post ON post_search_data USING gin (search_data);


--
-- Name: idx_search_topic; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX idx_search_topic ON topic_search_data USING gin (search_data);


--
-- Name: idx_search_user; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX idx_search_user ON user_search_data USING gin (search_data);


--
-- Name: idx_topics_front_page; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX idx_topics_front_page ON topics USING btree (deleted_at, visible, archetype, category_id, id);


--
-- Name: idx_topics_user_id_deleted_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX idx_topics_user_id_deleted_at ON topics USING btree (user_id) WHERE (deleted_at IS NULL);


--
-- Name: idx_unique_actions; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX idx_unique_actions ON post_actions USING btree (user_id, post_action_type_id, post_id, targets_topic) WHERE (((deleted_at IS NULL) AND (disagreed_at IS NULL)) AND (deferred_at IS NULL));


--
-- Name: idx_unique_flags; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX idx_unique_flags ON post_actions USING btree (user_id, post_id, targets_topic) WHERE ((((deleted_at IS NULL) AND (disagreed_at IS NULL)) AND (deferred_at IS NULL)) AND (post_action_type_id = ANY (ARRAY[3, 4, 7, 8])));


--
-- Name: idx_unique_post_uploads; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX idx_unique_post_uploads ON post_uploads USING btree (post_id, upload_id);


--
-- Name: idx_unique_rows; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX idx_unique_rows ON user_actions USING btree (action_type, user_id, target_topic_id, target_post_id, acting_user_id);


--
-- Name: index_api_keys_on_key; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_api_keys_on_key ON api_keys USING btree (key);


--
-- Name: index_api_keys_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_api_keys_on_user_id ON api_keys USING btree (user_id);


--
-- Name: index_badge_types_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_badge_types_on_name ON badge_types USING btree (name);


--
-- Name: index_badges_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_badges_on_name ON badges USING btree (name);


--
-- Name: index_categories_on_email_in; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_categories_on_email_in ON categories USING btree (email_in);


--
-- Name: index_categories_on_topic_count; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_categories_on_topic_count ON categories USING btree (topic_count);


--
-- Name: index_category_custom_fields_on_category_id_and_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_category_custom_fields_on_category_id_and_name ON category_custom_fields USING btree (category_id, name);


--
-- Name: index_category_featured_topics_on_category_id_and_rank; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_category_featured_topics_on_category_id_and_rank ON category_featured_topics USING btree (category_id, rank);


--
-- Name: index_category_featured_users_on_category_id_and_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_category_featured_users_on_category_id_and_user_id ON category_featured_users USING btree (category_id, user_id);


--
-- Name: index_color_scheme_colors_on_color_scheme_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_color_scheme_colors_on_color_scheme_id ON color_scheme_colors USING btree (color_scheme_id);


--
-- Name: index_draft_sequences_on_user_id_and_draft_key; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_draft_sequences_on_user_id_and_draft_key ON draft_sequences USING btree (user_id, draft_key);


--
-- Name: index_drafts_on_user_id_and_draft_key; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_drafts_on_user_id_and_draft_key ON drafts USING btree (user_id, draft_key);


--
-- Name: index_email_logs_on_created_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_email_logs_on_created_at ON email_logs USING btree (created_at DESC);


--
-- Name: index_email_logs_on_reply_key; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_email_logs_on_reply_key ON email_logs USING btree (reply_key);


--
-- Name: index_email_logs_on_skipped_and_created_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_email_logs_on_skipped_and_created_at ON email_logs USING btree (skipped, created_at);


--
-- Name: index_email_logs_on_user_id_and_created_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_email_logs_on_user_id_and_created_at ON email_logs USING btree (user_id, created_at DESC);


--
-- Name: index_email_tokens_on_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_email_tokens_on_token ON email_tokens USING btree (token);


--
-- Name: index_email_tokens_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_email_tokens_on_user_id ON email_tokens USING btree (user_id);


--
-- Name: index_facebook_user_infos_on_facebook_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_facebook_user_infos_on_facebook_user_id ON facebook_user_infos USING btree (facebook_user_id);


--
-- Name: index_facebook_user_infos_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_facebook_user_infos_on_user_id ON facebook_user_infos USING btree (user_id);


--
-- Name: index_github_user_infos_on_github_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_github_user_infos_on_github_user_id ON github_user_infos USING btree (github_user_id);


--
-- Name: index_github_user_infos_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_github_user_infos_on_user_id ON github_user_infos USING btree (user_id);


--
-- Name: index_google_user_infos_on_google_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_google_user_infos_on_google_user_id ON google_user_infos USING btree (google_user_id);


--
-- Name: index_google_user_infos_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_google_user_infos_on_user_id ON google_user_infos USING btree (user_id);


--
-- Name: index_group_custom_fields_on_group_id_and_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_group_custom_fields_on_group_id_and_name ON group_custom_fields USING btree (group_id, name);


--
-- Name: index_group_users_on_group_id_and_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_group_users_on_group_id_and_user_id ON group_users USING btree (group_id, user_id);


--
-- Name: index_groups_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_groups_on_name ON groups USING btree (name);


--
-- Name: index_incoming_domains_on_name_and_https_and_port; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_incoming_domains_on_name_and_https_and_port ON incoming_domains USING btree (name, https, port);


--
-- Name: index_incoming_links_on_created_at_and_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_incoming_links_on_created_at_and_user_id ON incoming_links USING btree (created_at, user_id);


--
-- Name: index_incoming_links_on_post_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_incoming_links_on_post_id ON incoming_links USING btree (post_id);


--
-- Name: index_incoming_referers_on_path_and_incoming_domain_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_incoming_referers_on_path_and_incoming_domain_id ON incoming_referers USING btree (path, incoming_domain_id);


--
-- Name: index_invites_on_email_and_invited_by_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_invites_on_email_and_invited_by_id ON invites USING btree (email, invited_by_id);


--
-- Name: index_invites_on_invite_key; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_invites_on_invite_key ON invites USING btree (invite_key);


--
-- Name: index_message_bus_on_created_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_message_bus_on_created_at ON message_bus USING btree (created_at);


--
-- Name: index_notifications_on_post_action_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_notifications_on_post_action_id ON notifications USING btree (post_action_id);


--
-- Name: index_notifications_on_user_id_and_created_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_notifications_on_user_id_and_created_at ON notifications USING btree (user_id, created_at);


--
-- Name: index_oauth2_user_infos_on_uid_and_provider; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_oauth2_user_infos_on_uid_and_provider ON oauth2_user_infos USING btree (uid, provider);


--
-- Name: index_optimized_images_on_upload_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_optimized_images_on_upload_id ON optimized_images USING btree (upload_id);


--
-- Name: index_optimized_images_on_upload_id_and_width_and_height; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_optimized_images_on_upload_id_and_width_and_height ON optimized_images USING btree (upload_id, width, height);


--
-- Name: index_permalinks_on_url; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_permalinks_on_url ON permalinks USING btree (url);


--
-- Name: index_plugin_store_rows_on_plugin_name_and_key; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_plugin_store_rows_on_plugin_name_and_key ON plugin_store_rows USING btree (plugin_name, key);


--
-- Name: index_post_actions_on_post_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_post_actions_on_post_id ON post_actions USING btree (post_id);


--
-- Name: index_post_custom_fields_on_post_id_and_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_post_custom_fields_on_post_id_and_name ON post_custom_fields USING btree (post_id, name);


--
-- Name: index_post_details_on_post_id_and_key; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_post_details_on_post_id_and_key ON post_details USING btree (post_id, key);


--
-- Name: index_post_replies_on_post_id_and_reply_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_post_replies_on_post_id_and_reply_id ON post_replies USING btree (post_id, reply_id);


--
-- Name: index_post_revisions_on_post_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_post_revisions_on_post_id ON post_revisions USING btree (post_id);


--
-- Name: index_post_revisions_on_post_id_and_number; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_post_revisions_on_post_id_and_number ON post_revisions USING btree (post_id, number);


--
-- Name: index_post_timings_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_post_timings_on_user_id ON post_timings USING btree (user_id);


--
-- Name: index_posts_on_reply_to_post_number; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_posts_on_reply_to_post_number ON posts USING btree (reply_to_post_number);


--
-- Name: index_posts_on_topic_id_and_post_number; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_posts_on_topic_id_and_post_number ON posts USING btree (topic_id, post_number);


--
-- Name: index_quoted_posts_on_post_id_and_quoted_post_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_quoted_posts_on_post_id_and_quoted_post_id ON quoted_posts USING btree (post_id, quoted_post_id);


--
-- Name: index_quoted_posts_on_quoted_post_id_and_post_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_quoted_posts_on_quoted_post_id_and_post_id ON quoted_posts USING btree (quoted_post_id, post_id);


--
-- Name: index_screened_emails_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_screened_emails_on_email ON screened_emails USING btree (email);


--
-- Name: index_screened_emails_on_last_match_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_screened_emails_on_last_match_at ON screened_emails USING btree (last_match_at);


--
-- Name: index_screened_ip_addresses_on_ip_address; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_screened_ip_addresses_on_ip_address ON screened_ip_addresses USING btree (ip_address);


--
-- Name: index_screened_ip_addresses_on_last_match_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_screened_ip_addresses_on_last_match_at ON screened_ip_addresses USING btree (last_match_at);


--
-- Name: index_screened_urls_on_last_match_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_screened_urls_on_last_match_at ON screened_urls USING btree (last_match_at);


--
-- Name: index_screened_urls_on_url; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_screened_urls_on_url ON screened_urls USING btree (url);


--
-- Name: index_single_sign_on_records_on_external_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_single_sign_on_records_on_external_id ON single_sign_on_records USING btree (external_id);


--
-- Name: index_site_customizations_on_key; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_site_customizations_on_key ON site_customizations USING btree (key);


--
-- Name: index_site_texts_on_text_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_site_texts_on_text_type ON site_texts USING btree (text_type);


--
-- Name: index_top_topics_on_daily_likes_count; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_top_topics_on_daily_likes_count ON top_topics USING btree (daily_likes_count DESC);


--
-- Name: index_top_topics_on_daily_posts_count; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_top_topics_on_daily_posts_count ON top_topics USING btree (daily_posts_count DESC);


--
-- Name: index_top_topics_on_daily_views_count; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_top_topics_on_daily_views_count ON top_topics USING btree (daily_views_count DESC);


--
-- Name: index_top_topics_on_monthly_likes_count; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_top_topics_on_monthly_likes_count ON top_topics USING btree (monthly_likes_count DESC);


--
-- Name: index_top_topics_on_monthly_posts_count; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_top_topics_on_monthly_posts_count ON top_topics USING btree (monthly_posts_count DESC);


--
-- Name: index_top_topics_on_monthly_views_count; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_top_topics_on_monthly_views_count ON top_topics USING btree (monthly_views_count DESC);


--
-- Name: index_top_topics_on_topic_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_top_topics_on_topic_id ON top_topics USING btree (topic_id);


--
-- Name: index_top_topics_on_weekly_likes_count; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_top_topics_on_weekly_likes_count ON top_topics USING btree (weekly_likes_count DESC);


--
-- Name: index_top_topics_on_weekly_posts_count; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_top_topics_on_weekly_posts_count ON top_topics USING btree (weekly_posts_count DESC);


--
-- Name: index_top_topics_on_weekly_views_count; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_top_topics_on_weekly_views_count ON top_topics USING btree (weekly_views_count DESC);


--
-- Name: index_top_topics_on_yearly_likes_count; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_top_topics_on_yearly_likes_count ON top_topics USING btree (yearly_likes_count DESC);


--
-- Name: index_top_topics_on_yearly_posts_count; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_top_topics_on_yearly_posts_count ON top_topics USING btree (yearly_posts_count DESC);


--
-- Name: index_top_topics_on_yearly_views_count; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_top_topics_on_yearly_views_count ON top_topics USING btree (yearly_views_count DESC);


--
-- Name: index_topic_allowed_groups_on_group_id_and_topic_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_topic_allowed_groups_on_group_id_and_topic_id ON topic_allowed_groups USING btree (group_id, topic_id);


--
-- Name: index_topic_allowed_groups_on_topic_id_and_group_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_topic_allowed_groups_on_topic_id_and_group_id ON topic_allowed_groups USING btree (topic_id, group_id);


--
-- Name: index_topic_allowed_users_on_topic_id_and_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_topic_allowed_users_on_topic_id_and_user_id ON topic_allowed_users USING btree (topic_id, user_id);


--
-- Name: index_topic_allowed_users_on_user_id_and_topic_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_topic_allowed_users_on_user_id_and_topic_id ON topic_allowed_users USING btree (user_id, topic_id);


--
-- Name: index_topic_custom_fields_on_topic_id_and_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_topic_custom_fields_on_topic_id_and_name ON topic_custom_fields USING btree (topic_id, name);


--
-- Name: index_topic_custom_fields_on_value; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_topic_custom_fields_on_value ON topic_custom_fields USING btree (value);


--
-- Name: index_topic_embeds_on_embed_url; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_topic_embeds_on_embed_url ON topic_embeds USING btree (embed_url);


--
-- Name: index_topic_invites_on_invite_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_topic_invites_on_invite_id ON topic_invites USING btree (invite_id);


--
-- Name: index_topic_invites_on_topic_id_and_invite_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_topic_invites_on_topic_id_and_invite_id ON topic_invites USING btree (topic_id, invite_id);


--
-- Name: index_topic_links_on_post_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_topic_links_on_post_id ON topic_links USING btree (post_id);


--
-- Name: index_topic_links_on_topic_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_topic_links_on_topic_id ON topic_links USING btree (topic_id);


--
-- Name: index_topic_users_on_topic_id_and_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_topic_users_on_topic_id_and_user_id ON topic_users USING btree (topic_id, user_id);


--
-- Name: index_topic_users_on_user_id_and_topic_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_topic_users_on_user_id_and_topic_id ON topic_users USING btree (user_id, topic_id);


--
-- Name: index_topic_views_on_topic_id_and_viewed_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_topic_views_on_topic_id_and_viewed_at ON topic_views USING btree (topic_id, viewed_at);


--
-- Name: index_topic_views_on_viewed_at_and_topic_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_topic_views_on_viewed_at_and_topic_id ON topic_views USING btree (viewed_at, topic_id);


--
-- Name: index_topics_on_bumped_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_topics_on_bumped_at ON topics USING btree (bumped_at DESC);


--
-- Name: index_topics_on_id_and_deleted_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_topics_on_id_and_deleted_at ON topics USING btree (id, deleted_at);


--
-- Name: index_twitter_user_infos_on_twitter_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_twitter_user_infos_on_twitter_user_id ON twitter_user_infos USING btree (twitter_user_id);


--
-- Name: index_twitter_user_infos_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_twitter_user_infos_on_user_id ON twitter_user_infos USING btree (user_id);


--
-- Name: index_uploads_on_id_and_url; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_uploads_on_id_and_url ON uploads USING btree (id, url);


--
-- Name: index_uploads_on_sha1; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_uploads_on_sha1 ON uploads USING btree (sha1);


--
-- Name: index_uploads_on_url; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_uploads_on_url ON uploads USING btree (url);


--
-- Name: index_uploads_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_uploads_on_user_id ON uploads USING btree (user_id);


--
-- Name: index_user_actions_on_acting_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_user_actions_on_acting_user_id ON user_actions USING btree (acting_user_id);


--
-- Name: index_user_actions_on_user_id_and_action_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_user_actions_on_user_id_and_action_type ON user_actions USING btree (user_id, action_type);


--
-- Name: index_user_avatars_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_user_avatars_on_user_id ON user_avatars USING btree (user_id);


--
-- Name: index_user_badges_on_badge_id_and_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_user_badges_on_badge_id_and_user_id ON user_badges USING btree (badge_id, user_id);


--
-- Name: index_user_badges_on_badge_id_and_user_id_and_post_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_user_badges_on_badge_id_and_user_id_and_post_id ON user_badges USING btree (badge_id, user_id, post_id) WHERE (post_id IS NOT NULL);


--
-- Name: index_user_badges_on_badge_id_and_user_id_and_seq; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_user_badges_on_badge_id_and_user_id_and_seq ON user_badges USING btree (badge_id, user_id, seq) WHERE (post_id IS NULL);


--
-- Name: index_user_custom_fields_on_user_id_and_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_user_custom_fields_on_user_id_and_name ON user_custom_fields USING btree (user_id, name);


--
-- Name: index_user_histories_on_acting_user_id_and_action_and_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_user_histories_on_acting_user_id_and_action_and_id ON user_histories USING btree (acting_user_id, action, id);


--
-- Name: index_user_histories_on_action_and_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_user_histories_on_action_and_id ON user_histories USING btree (action, id);


--
-- Name: index_user_histories_on_subject_and_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_user_histories_on_subject_and_id ON user_histories USING btree (subject, id);


--
-- Name: index_user_histories_on_target_user_id_and_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_user_histories_on_target_user_id_and_id ON user_histories USING btree (target_user_id, id);


--
-- Name: index_user_open_ids_on_url; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_user_open_ids_on_url ON user_open_ids USING btree (url);


--
-- Name: index_user_profiles_on_bio_cooked_version; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_user_profiles_on_bio_cooked_version ON user_profiles USING btree (bio_cooked_version);


--
-- Name: index_user_visits_on_user_id_and_visited_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_user_visits_on_user_id_and_visited_at ON user_visits USING btree (user_id, visited_at);


--
-- Name: index_users_on_auth_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_auth_token ON users USING btree (auth_token);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (lower((email)::text));


--
-- Name: index_users_on_last_posted_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_last_posted_at ON users USING btree (last_posted_at);


--
-- Name: index_users_on_last_seen_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_last_seen_at ON users USING btree (last_seen_at);


--
-- Name: index_users_on_username; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_username ON users USING btree (username);


--
-- Name: index_users_on_username_lower; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_username_lower ON users USING btree (username_lower);


--
-- Name: index_versions_on_created_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_versions_on_created_at ON versions USING btree (created_at);


--
-- Name: index_versions_on_number; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_versions_on_number ON versions USING btree (number);


--
-- Name: index_versions_on_tag; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_versions_on_tag ON versions USING btree (tag);


--
-- Name: index_versions_on_user_id_and_user_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_versions_on_user_id_and_user_type ON versions USING btree (user_id, user_type);


--
-- Name: index_versions_on_user_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_versions_on_user_name ON versions USING btree (user_name);


--
-- Name: index_versions_on_versioned_id_and_versioned_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_versions_on_versioned_id_and_versioned_type ON versions USING btree (versioned_id, versioned_type);


--
-- Name: index_warnings_on_topic_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_warnings_on_topic_id ON warnings USING btree (topic_id);


--
-- Name: index_warnings_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_warnings_on_user_id ON warnings USING btree (user_id);


--
-- Name: ip_address_topic_id_topic_views; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX ip_address_topic_id_topic_views ON topic_views USING btree (ip_address, topic_id) WHERE (user_id IS NULL);


--
-- Name: post_timings_summary; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX post_timings_summary ON post_timings USING btree (topic_id, post_number);


--
-- Name: post_timings_unique; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX post_timings_unique ON post_timings USING btree (topic_id, post_number, user_id);


--
-- Name: unique_index_categories_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_index_categories_on_name ON categories USING btree ((COALESCE(parent_category_id, (-1))), name);


--
-- Name: unique_post_links; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_post_links ON topic_links USING btree (topic_id, post_id, url);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: user_id_topic_id_topic_views; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX user_id_topic_id_topic_views ON topic_views USING btree (user_id, topic_id) WHERE (user_id IS NOT NULL);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20120311163914');

INSERT INTO schema_migrations (version) VALUES ('20120311164326');

INSERT INTO schema_migrations (version) VALUES ('20120311170118');

INSERT INTO schema_migrations (version) VALUES ('20120311201341');

INSERT INTO schema_migrations (version) VALUES ('20120311210245');

INSERT INTO schema_migrations (version) VALUES ('20120416201606');

INSERT INTO schema_migrations (version) VALUES ('20120420183447');

INSERT INTO schema_migrations (version) VALUES ('20120423140906');

INSERT INTO schema_migrations (version) VALUES ('20120423142820');

INSERT INTO schema_migrations (version) VALUES ('20120423151548');

INSERT INTO schema_migrations (version) VALUES ('20120425145456');

INSERT INTO schema_migrations (version) VALUES ('20120427150624');

INSERT INTO schema_migrations (version) VALUES ('20120427151452');

INSERT INTO schema_migrations (version) VALUES ('20120427154330');

INSERT INTO schema_migrations (version) VALUES ('20120427172031');

INSERT INTO schema_migrations (version) VALUES ('20120502183240');

INSERT INTO schema_migrations (version) VALUES ('20120502192121');

INSERT INTO schema_migrations (version) VALUES ('20120503205521');

INSERT INTO schema_migrations (version) VALUES ('20120507144132');

INSERT INTO schema_migrations (version) VALUES ('20120507144222');

INSERT INTO schema_migrations (version) VALUES ('20120514144549');

INSERT INTO schema_migrations (version) VALUES ('20120514173920');

INSERT INTO schema_migrations (version) VALUES ('20120514204934');

INSERT INTO schema_migrations (version) VALUES ('20120517200130');

INSERT INTO schema_migrations (version) VALUES ('20120518200115');

INSERT INTO schema_migrations (version) VALUES ('20120519182212');

INSERT INTO schema_migrations (version) VALUES ('20120523180723');

INSERT INTO schema_migrations (version) VALUES ('20120523184307');

INSERT INTO schema_migrations (version) VALUES ('20120523201329');

INSERT INTO schema_migrations (version) VALUES ('20120525194845');

INSERT INTO schema_migrations (version) VALUES ('20120529175956');

INSERT INTO schema_migrations (version) VALUES ('20120529202707');

INSERT INTO schema_migrations (version) VALUES ('20120530150726');

INSERT INTO schema_migrations (version) VALUES ('20120530160745');

INSERT INTO schema_migrations (version) VALUES ('20120530200724');

INSERT INTO schema_migrations (version) VALUES ('20120530212912');

INSERT INTO schema_migrations (version) VALUES ('20120614190726');

INSERT INTO schema_migrations (version) VALUES ('20120614202024');

INSERT INTO schema_migrations (version) VALUES ('20120615180517');

INSERT INTO schema_migrations (version) VALUES ('20120618152946');

INSERT INTO schema_migrations (version) VALUES ('20120618212349');

INSERT INTO schema_migrations (version) VALUES ('20120618214856');

INSERT INTO schema_migrations (version) VALUES ('20120619150807');

INSERT INTO schema_migrations (version) VALUES ('20120619153349');

INSERT INTO schema_migrations (version) VALUES ('20120619172714');

INSERT INTO schema_migrations (version) VALUES ('20120621155351');

INSERT INTO schema_migrations (version) VALUES ('20120621190310');

INSERT INTO schema_migrations (version) VALUES ('20120622200242');

INSERT INTO schema_migrations (version) VALUES ('20120625145714');

INSERT INTO schema_migrations (version) VALUES ('20120625162318');

INSERT INTO schema_migrations (version) VALUES ('20120625174544');

INSERT INTO schema_migrations (version) VALUES ('20120625195326');

INSERT INTO schema_migrations (version) VALUES ('20120629143908');

INSERT INTO schema_migrations (version) VALUES ('20120629150253');

INSERT INTO schema_migrations (version) VALUES ('20120629151243');

INSERT INTO schema_migrations (version) VALUES ('20120629182637');

INSERT INTO schema_migrations (version) VALUES ('20120702211427');

INSERT INTO schema_migrations (version) VALUES ('20120703184734');

INSERT INTO schema_migrations (version) VALUES ('20120703201312');

INSERT INTO schema_migrations (version) VALUES ('20120703203623');

INSERT INTO schema_migrations (version) VALUES ('20120703210004');

INSERT INTO schema_migrations (version) VALUES ('20120704160659');

INSERT INTO schema_migrations (version) VALUES ('20120704201743');

INSERT INTO schema_migrations (version) VALUES ('20120705181724');

INSERT INTO schema_migrations (version) VALUES ('20120708210305');

INSERT INTO schema_migrations (version) VALUES ('20120712150500');

INSERT INTO schema_migrations (version) VALUES ('20120712151934');

INSERT INTO schema_migrations (version) VALUES ('20120713201324');

INSERT INTO schema_migrations (version) VALUES ('20120716020835');

INSERT INTO schema_migrations (version) VALUES ('20120716173544');

INSERT INTO schema_migrations (version) VALUES ('20120718044955');

INSERT INTO schema_migrations (version) VALUES ('20120719004636');

INSERT INTO schema_migrations (version) VALUES ('20120720013733');

INSERT INTO schema_migrations (version) VALUES ('20120720044246');

INSERT INTO schema_migrations (version) VALUES ('20120720162422');

INSERT INTO schema_migrations (version) VALUES ('20120723051512');

INSERT INTO schema_migrations (version) VALUES ('20120724234502');

INSERT INTO schema_migrations (version) VALUES ('20120724234711');

INSERT INTO schema_migrations (version) VALUES ('20120725183347');

INSERT INTO schema_migrations (version) VALUES ('20120726201830');

INSERT INTO schema_migrations (version) VALUES ('20120726235129');

INSERT INTO schema_migrations (version) VALUES ('20120727005556');

INSERT INTO schema_migrations (version) VALUES ('20120727150428');

INSERT INTO schema_migrations (version) VALUES ('20120727213543');

INSERT INTO schema_migrations (version) VALUES ('20120802151210');

INSERT INTO schema_migrations (version) VALUES ('20120803191426');

INSERT INTO schema_migrations (version) VALUES ('20120806030641');

INSERT INTO schema_migrations (version) VALUES ('20120806062617');

INSERT INTO schema_migrations (version) VALUES ('20120807223020');

INSERT INTO schema_migrations (version) VALUES ('20120809020415');

INSERT INTO schema_migrations (version) VALUES ('20120809030647');

INSERT INTO schema_migrations (version) VALUES ('20120809053414');

INSERT INTO schema_migrations (version) VALUES ('20120809154750');

INSERT INTO schema_migrations (version) VALUES ('20120809174649');

INSERT INTO schema_migrations (version) VALUES ('20120809175110');

INSERT INTO schema_migrations (version) VALUES ('20120809201855');

INSERT INTO schema_migrations (version) VALUES ('20120810064839');

INSERT INTO schema_migrations (version) VALUES ('20120812235417');

INSERT INTO schema_migrations (version) VALUES ('20120813004347');

INSERT INTO schema_migrations (version) VALUES ('20120813042912');

INSERT INTO schema_migrations (version) VALUES ('20120813201426');

INSERT INTO schema_migrations (version) VALUES ('20120815004411');

INSERT INTO schema_migrations (version) VALUES ('20120815180106');

INSERT INTO schema_migrations (version) VALUES ('20120815204733');

INSERT INTO schema_migrations (version) VALUES ('20120816050526');

INSERT INTO schema_migrations (version) VALUES ('20120816205537');

INSERT INTO schema_migrations (version) VALUES ('20120816205538');

INSERT INTO schema_migrations (version) VALUES ('20120820191804');

INSERT INTO schema_migrations (version) VALUES ('20120821191616');

INSERT INTO schema_migrations (version) VALUES ('20120823205956');

INSERT INTO schema_migrations (version) VALUES ('20120824171908');

INSERT INTO schema_migrations (version) VALUES ('20120828204209');

INSERT INTO schema_migrations (version) VALUES ('20120828204624');

INSERT INTO schema_migrations (version) VALUES ('20120830182736');

INSERT INTO schema_migrations (version) VALUES ('20120910171504');

INSERT INTO schema_migrations (version) VALUES ('20120918152319');

INSERT INTO schema_migrations (version) VALUES ('20120918205931');

INSERT INTO schema_migrations (version) VALUES ('20120919152846');

INSERT INTO schema_migrations (version) VALUES ('20120921055428');

INSERT INTO schema_migrations (version) VALUES ('20120921155050');

INSERT INTO schema_migrations (version) VALUES ('20120921162512');

INSERT INTO schema_migrations (version) VALUES ('20120921163606');

INSERT INTO schema_migrations (version) VALUES ('20120924182000');

INSERT INTO schema_migrations (version) VALUES ('20120924182031');

INSERT INTO schema_migrations (version) VALUES ('20120925171620');

INSERT INTO schema_migrations (version) VALUES ('20120925190802');

INSERT INTO schema_migrations (version) VALUES ('20120928170023');

INSERT INTO schema_migrations (version) VALUES ('20121009161116');

INSERT INTO schema_migrations (version) VALUES ('20121011155904');

INSERT INTO schema_migrations (version) VALUES ('20121017162924');

INSERT INTO schema_migrations (version) VALUES ('20121018103721');

INSERT INTO schema_migrations (version) VALUES ('20121018133039');

INSERT INTO schema_migrations (version) VALUES ('20121018182709');

INSERT INTO schema_migrations (version) VALUES ('20121106015500');

INSERT INTO schema_migrations (version) VALUES ('20121108193516');

INSERT INTO schema_migrations (version) VALUES ('20121109164630');

INSERT INTO schema_migrations (version) VALUES ('20121113200844');

INSERT INTO schema_migrations (version) VALUES ('20121113200845');

INSERT INTO schema_migrations (version) VALUES ('20121115172544');

INSERT INTO schema_migrations (version) VALUES ('20121116212424');

INSERT INTO schema_migrations (version) VALUES ('20121119190529');

INSERT INTO schema_migrations (version) VALUES ('20121119200843');

INSERT INTO schema_migrations (version) VALUES ('20121121202035');

INSERT INTO schema_migrations (version) VALUES ('20121121205215');

INSERT INTO schema_migrations (version) VALUES ('20121122033316');

INSERT INTO schema_migrations (version) VALUES ('20121123054127');

INSERT INTO schema_migrations (version) VALUES ('20121123063630');

INSERT INTO schema_migrations (version) VALUES ('20121129160035');

INSERT INTO schema_migrations (version) VALUES ('20121129184948');

INSERT INTO schema_migrations (version) VALUES ('20121130010400');

INSERT INTO schema_migrations (version) VALUES ('20121130191818');

INSERT INTO schema_migrations (version) VALUES ('20121202225421');

INSERT INTO schema_migrations (version) VALUES ('20121203181719');

INSERT INTO schema_migrations (version) VALUES ('20121204183855');

INSERT INTO schema_migrations (version) VALUES ('20121204193747');

INSERT INTO schema_migrations (version) VALUES ('20121205162143');

INSERT INTO schema_migrations (version) VALUES ('20121207000741');

INSERT INTO schema_migrations (version) VALUES ('20121211233131');

INSERT INTO schema_migrations (version) VALUES ('20121216230719');

INSERT INTO schema_migrations (version) VALUES ('20121218205642');

INSERT INTO schema_migrations (version) VALUES ('20121224072204');

INSERT INTO schema_migrations (version) VALUES ('20121224095139');

INSERT INTO schema_migrations (version) VALUES ('20121224100650');

INSERT INTO schema_migrations (version) VALUES ('20121228192219');

INSERT INTO schema_migrations (version) VALUES ('20130107165207');

INSERT INTO schema_migrations (version) VALUES ('20130108195847');

INSERT INTO schema_migrations (version) VALUES ('20130115012140');

INSERT INTO schema_migrations (version) VALUES ('20130115021937');

INSERT INTO schema_migrations (version) VALUES ('20130115043603');

INSERT INTO schema_migrations (version) VALUES ('20130116151829');

INSERT INTO schema_migrations (version) VALUES ('20130120222728');

INSERT INTO schema_migrations (version) VALUES ('20130121231352');

INSERT INTO schema_migrations (version) VALUES ('20130122051134');

INSERT INTO schema_migrations (version) VALUES ('20130122232825');

INSERT INTO schema_migrations (version) VALUES ('20130123070909');

INSERT INTO schema_migrations (version) VALUES ('20130125002652');

INSERT INTO schema_migrations (version) VALUES ('20130125030305');

INSERT INTO schema_migrations (version) VALUES ('20130125031122');

INSERT INTO schema_migrations (version) VALUES ('20130127213646');

INSERT INTO schema_migrations (version) VALUES ('20130128182013');

INSERT INTO schema_migrations (version) VALUES ('20130129010625');

INSERT INTO schema_migrations (version) VALUES ('20130129163244');

INSERT INTO schema_migrations (version) VALUES ('20130129174845');

INSERT INTO schema_migrations (version) VALUES ('20130130154611');

INSERT INTO schema_migrations (version) VALUES ('20130131055710');

INSERT INTO schema_migrations (version) VALUES ('20130201000828');

INSERT INTO schema_migrations (version) VALUES ('20130201023409');

INSERT INTO schema_migrations (version) VALUES ('20130203204338');

INSERT INTO schema_migrations (version) VALUES ('20130204000159');

INSERT INTO schema_migrations (version) VALUES ('20130205021905');

INSERT INTO schema_migrations (version) VALUES ('20130207200019');

INSERT INTO schema_migrations (version) VALUES ('20130208220635');

INSERT INTO schema_migrations (version) VALUES ('20130213021450');

INSERT INTO schema_migrations (version) VALUES ('20130213203300');

INSERT INTO schema_migrations (version) VALUES ('20130221215017');

INSERT INTO schema_migrations (version) VALUES ('20130226015336');

INSERT INTO schema_migrations (version) VALUES ('20130306180148');

INSERT INTO schema_migrations (version) VALUES ('20130311181327');

INSERT INTO schema_migrations (version) VALUES ('20130313004922');

INSERT INTO schema_migrations (version) VALUES ('20130314093434');

INSERT INTO schema_migrations (version) VALUES ('20130315180637');

INSERT INTO schema_migrations (version) VALUES ('20130319122248');

INSERT INTO schema_migrations (version) VALUES ('20130320012100');

INSERT INTO schema_migrations (version) VALUES ('20130320024345');

INSERT INTO schema_migrations (version) VALUES ('20130321154905');

INSERT INTO schema_migrations (version) VALUES ('20130322183614');

INSERT INTO schema_migrations (version) VALUES ('20130326210101');

INSERT INTO schema_migrations (version) VALUES ('20130327185852');

INSERT INTO schema_migrations (version) VALUES ('20130328162943');

INSERT INTO schema_migrations (version) VALUES ('20130328182433');

INSERT INTO schema_migrations (version) VALUES ('20130402210723');

INSERT INTO schema_migrations (version) VALUES ('20130404143437');

INSERT INTO schema_migrations (version) VALUES ('20130404232558');

INSERT INTO schema_migrations (version) VALUES ('20130411205132');

INSERT INTO schema_migrations (version) VALUES ('20130412015502');

INSERT INTO schema_migrations (version) VALUES ('20130412020156');

INSERT INTO schema_migrations (version) VALUES ('20130416004607');

INSERT INTO schema_migrations (version) VALUES ('20130416004933');

INSERT INTO schema_migrations (version) VALUES ('20130416170855');

INSERT INTO schema_migrations (version) VALUES ('20130419195746');

INSERT INTO schema_migrations (version) VALUES ('20130422050626');

INSERT INTO schema_migrations (version) VALUES ('20130424015746');

INSERT INTO schema_migrations (version) VALUES ('20130424055025');

INSERT INTO schema_migrations (version) VALUES ('20130426044914');

INSERT INTO schema_migrations (version) VALUES ('20130426052257');

INSERT INTO schema_migrations (version) VALUES ('20130428194335');

INSERT INTO schema_migrations (version) VALUES ('20130429000101');

INSERT INTO schema_migrations (version) VALUES ('20130430052751');

INSERT INTO schema_migrations (version) VALUES ('20130501105651');

INSERT INTO schema_migrations (version) VALUES ('20130506020935');

INSERT INTO schema_migrations (version) VALUES ('20130506185042');

INSERT INTO schema_migrations (version) VALUES ('20130508040235');

INSERT INTO schema_migrations (version) VALUES ('20130509040248');

INSERT INTO schema_migrations (version) VALUES ('20130509041351');

INSERT INTO schema_migrations (version) VALUES ('20130515193551');

INSERT INTO schema_migrations (version) VALUES ('20130521210140');

INSERT INTO schema_migrations (version) VALUES ('20130522193615');

INSERT INTO schema_migrations (version) VALUES ('20130527152648');

INSERT INTO schema_migrations (version) VALUES ('20130528174147');

INSERT INTO schema_migrations (version) VALUES ('20130531210816');

INSERT INTO schema_migrations (version) VALUES ('20130603192412');

INSERT INTO schema_migrations (version) VALUES ('20130606190601');

INSERT INTO schema_migrations (version) VALUES ('20130610201033');

INSERT INTO schema_migrations (version) VALUES ('20130612200846');

INSERT INTO schema_migrations (version) VALUES ('20130613211700');

INSERT INTO schema_migrations (version) VALUES ('20130613212230');

INSERT INTO schema_migrations (version) VALUES ('20130615064344');

INSERT INTO schema_migrations (version) VALUES ('20130615073305');

INSERT INTO schema_migrations (version) VALUES ('20130615075557');

INSERT INTO schema_migrations (version) VALUES ('20130616082327');

INSERT INTO schema_migrations (version) VALUES ('20130617014127');

INSERT INTO schema_migrations (version) VALUES ('20130617180009');

INSERT INTO schema_migrations (version) VALUES ('20130617181804');

INSERT INTO schema_migrations (version) VALUES ('20130619063902');

INSERT INTO schema_migrations (version) VALUES ('20130621042855');

INSERT INTO schema_migrations (version) VALUES ('20130622110348');

INSERT INTO schema_migrations (version) VALUES ('20130624203206');

INSERT INTO schema_migrations (version) VALUES ('20130625022454');

INSERT INTO schema_migrations (version) VALUES ('20130625170842');

INSERT INTO schema_migrations (version) VALUES ('20130625201113');

INSERT INTO schema_migrations (version) VALUES ('20130709184941');

INSERT INTO schema_migrations (version) VALUES ('20130710201248');

INSERT INTO schema_migrations (version) VALUES ('20130712041133');

INSERT INTO schema_migrations (version) VALUES ('20130712163509');

INSERT INTO schema_migrations (version) VALUES ('20130723212758');

INSERT INTO schema_migrations (version) VALUES ('20130724201552');

INSERT INTO schema_migrations (version) VALUES ('20130725213613');

INSERT INTO schema_migrations (version) VALUES ('20130728172550');

INSERT INTO schema_migrations (version) VALUES ('20130731163035');

INSERT INTO schema_migrations (version) VALUES ('20130801155107');

INSERT INTO schema_migrations (version) VALUES ('20130807202516');

INSERT INTO schema_migrations (version) VALUES ('20130809160751');

INSERT INTO schema_migrations (version) VALUES ('20130809204732');

INSERT INTO schema_migrations (version) VALUES ('20130809211409');

INSERT INTO schema_migrations (version) VALUES ('20130813204212');

INSERT INTO schema_migrations (version) VALUES ('20130813224817');

INSERT INTO schema_migrations (version) VALUES ('20130816024250');

INSERT INTO schema_migrations (version) VALUES ('20130819192358');

INSERT INTO schema_migrations (version) VALUES ('20130820174431');

INSERT INTO schema_migrations (version) VALUES ('20130822213513');

INSERT INTO schema_migrations (version) VALUES ('20130823201420');

INSERT INTO schema_migrations (version) VALUES ('20130826011521');

INSERT INTO schema_migrations (version) VALUES ('20130828192526');

INSERT INTO schema_migrations (version) VALUES ('20130903154323');

INSERT INTO schema_migrations (version) VALUES ('20130904181208');

INSERT INTO schema_migrations (version) VALUES ('20130906081326');

INSERT INTO schema_migrations (version) VALUES ('20130906171631');

INSERT INTO schema_migrations (version) VALUES ('20130910040235');

INSERT INTO schema_migrations (version) VALUES ('20130910220317');

INSERT INTO schema_migrations (version) VALUES ('20130911182437');

INSERT INTO schema_migrations (version) VALUES ('20130912185218');

INSERT INTO schema_migrations (version) VALUES ('20130913210454');

INSERT INTO schema_migrations (version) VALUES ('20130917174738');

INSERT INTO schema_migrations (version) VALUES ('20131001060630');

INSERT INTO schema_migrations (version) VALUES ('20131002070347');

INSERT INTO schema_migrations (version) VALUES ('20131003061137');

INSERT INTO schema_migrations (version) VALUES ('20131014203951');

INSERT INTO schema_migrations (version) VALUES ('20131015131652');

INSERT INTO schema_migrations (version) VALUES ('20131017014509');

INSERT INTO schema_migrations (version) VALUES ('20131017030605');

INSERT INTO schema_migrations (version) VALUES ('20131017205954');

INSERT INTO schema_migrations (version) VALUES ('20131018050738');

INSERT INTO schema_migrations (version) VALUES ('20131022045114');

INSERT INTO schema_migrations (version) VALUES ('20131022151218');

INSERT INTO schema_migrations (version) VALUES ('20131023163509');

INSERT INTO schema_migrations (version) VALUES ('20131105101051');

INSERT INTO schema_migrations (version) VALUES ('20131107154900');

INSERT INTO schema_migrations (version) VALUES ('20131114185225');

INSERT INTO schema_migrations (version) VALUES ('20131115165105');

INSERT INTO schema_migrations (version) VALUES ('20131118173159');

INSERT INTO schema_migrations (version) VALUES ('20131120055018');

INSERT INTO schema_migrations (version) VALUES ('20131122064921');

INSERT INTO schema_migrations (version) VALUES ('20131206200009');

INSERT INTO schema_migrations (version) VALUES ('20131209091702');

INSERT INTO schema_migrations (version) VALUES ('20131209091742');

INSERT INTO schema_migrations (version) VALUES ('20131210163702');

INSERT INTO schema_migrations (version) VALUES ('20131210181901');

INSERT INTO schema_migrations (version) VALUES ('20131210234530');

INSERT INTO schema_migrations (version) VALUES ('20131212225511');

INSERT INTO schema_migrations (version) VALUES ('20131216164557');

INSERT INTO schema_migrations (version) VALUES ('20131217174004');

INSERT INTO schema_migrations (version) VALUES ('20131219203905');

INSERT INTO schema_migrations (version) VALUES ('20131223171005');

INSERT INTO schema_migrations (version) VALUES ('20131227164338');

INSERT INTO schema_migrations (version) VALUES ('20131229221725');

INSERT INTO schema_migrations (version) VALUES ('20131230010239');

INSERT INTO schema_migrations (version) VALUES ('20140101235747');

INSERT INTO schema_migrations (version) VALUES ('20140102104229');

INSERT INTO schema_migrations (version) VALUES ('20140102194802');

INSERT INTO schema_migrations (version) VALUES ('20140107220141');

INSERT INTO schema_migrations (version) VALUES ('20140109205940');

INSERT INTO schema_migrations (version) VALUES ('20140116170655');

INSERT INTO schema_migrations (version) VALUES ('20140120155706');

INSERT INTO schema_migrations (version) VALUES ('20140121204628');

INSERT INTO schema_migrations (version) VALUES ('20140122043508');

INSERT INTO schema_migrations (version) VALUES ('20140124202427');

INSERT INTO schema_migrations (version) VALUES ('20140129164541');

INSERT INTO schema_migrations (version) VALUES ('20140206044818');

INSERT INTO schema_migrations (version) VALUES ('20140206195001');

INSERT INTO schema_migrations (version) VALUES ('20140206215029');

INSERT INTO schema_migrations (version) VALUES ('20140210194146');

INSERT INTO schema_migrations (version) VALUES ('20140211230222');

INSERT INTO schema_migrations (version) VALUES ('20140211234523');

INSERT INTO schema_migrations (version) VALUES ('20140214151255');

INSERT INTO schema_migrations (version) VALUES ('20140220160510');

INSERT INTO schema_migrations (version) VALUES ('20140220163213');

INSERT INTO schema_migrations (version) VALUES ('20140224232712');

INSERT INTO schema_migrations (version) VALUES ('20140224232913');

INSERT INTO schema_migrations (version) VALUES ('20140227104930');

INSERT INTO schema_migrations (version) VALUES ('20140227201005');

INSERT INTO schema_migrations (version) VALUES ('20140228005443');

INSERT INTO schema_migrations (version) VALUES ('20140228173431');

INSERT INTO schema_migrations (version) VALUES ('20140228205743');

INSERT INTO schema_migrations (version) VALUES ('20140303185354');

INSERT INTO schema_migrations (version) VALUES ('20140304200606');

INSERT INTO schema_migrations (version) VALUES ('20140304201403');

INSERT INTO schema_migrations (version) VALUES ('20140305100909');

INSERT INTO schema_migrations (version) VALUES ('20140306223522');

INSERT INTO schema_migrations (version) VALUES ('20140318150412');

INSERT INTO schema_migrations (version) VALUES ('20140318203559');

INSERT INTO schema_migrations (version) VALUES ('20140320042653');

INSERT INTO schema_migrations (version) VALUES ('20140402201432');

INSERT INTO schema_migrations (version) VALUES ('20140404143501');

INSERT INTO schema_migrations (version) VALUES ('20140407055830');

INSERT INTO schema_migrations (version) VALUES ('20140407202158');

INSERT INTO schema_migrations (version) VALUES ('20140408061512');

INSERT INTO schema_migrations (version) VALUES ('20140408152401');

INSERT INTO schema_migrations (version) VALUES ('20140415054717');

INSERT INTO schema_migrations (version) VALUES ('20140416202746');

INSERT INTO schema_migrations (version) VALUES ('20140416202801');

INSERT INTO schema_migrations (version) VALUES ('20140416235757');

INSERT INTO schema_migrations (version) VALUES ('20140421235646');

INSERT INTO schema_migrations (version) VALUES ('20140422195623');

INSERT INTO schema_migrations (version) VALUES ('20140425125742');

INSERT INTO schema_migrations (version) VALUES ('20140425135354');

INSERT INTO schema_migrations (version) VALUES ('20140425172618');

INSERT INTO schema_migrations (version) VALUES ('20140429175951');

INSERT INTO schema_migrations (version) VALUES ('20140504174212');

INSERT INTO schema_migrations (version) VALUES ('20140505145918');

INSERT INTO schema_migrations (version) VALUES ('20140506200235');

INSERT INTO schema_migrations (version) VALUES ('20140507173327');

INSERT INTO schema_migrations (version) VALUES ('20140508053815');

INSERT INTO schema_migrations (version) VALUES ('20140515220111');

INSERT INTO schema_migrations (version) VALUES ('20140520062826');

INSERT INTO schema_migrations (version) VALUES ('20140520063859');

INSERT INTO schema_migrations (version) VALUES ('20140521192142');

INSERT INTO schema_migrations (version) VALUES ('20140521220115');

INSERT INTO schema_migrations (version) VALUES ('20140522003151');

INSERT INTO schema_migrations (version) VALUES ('20140525233953');

INSERT INTO schema_migrations (version) VALUES ('20140526185749');

INSERT INTO schema_migrations (version) VALUES ('20140526201939');

INSERT INTO schema_migrations (version) VALUES ('20140527163207');

INSERT INTO schema_migrations (version) VALUES ('20140527233225');

INSERT INTO schema_migrations (version) VALUES ('20140528015354');

INSERT INTO schema_migrations (version) VALUES ('20140529045508');

INSERT INTO schema_migrations (version) VALUES ('20140530002535');

INSERT INTO schema_migrations (version) VALUES ('20140530043913');

INSERT INTO schema_migrations (version) VALUES ('20140604145431');

INSERT INTO schema_migrations (version) VALUES ('20140607035234');

INSERT INTO schema_migrations (version) VALUES ('20140610012414');

INSERT INTO schema_migrations (version) VALUES ('20140610012833');

INSERT INTO schema_migrations (version) VALUES ('20140610034314');

INSERT INTO schema_migrations (version) VALUES ('20140612010718');

INSERT INTO schema_migrations (version) VALUES ('20140617053829');

INSERT INTO schema_migrations (version) VALUES ('20140617080955');

INSERT INTO schema_migrations (version) VALUES ('20140617193351');

INSERT INTO schema_migrations (version) VALUES ('20140618001820');

INSERT INTO schema_migrations (version) VALUES ('20140618163511');

INSERT INTO schema_migrations (version) VALUES ('20140620184031');

INSERT INTO schema_migrations (version) VALUES ('20140623195618');

INSERT INTO schema_migrations (version) VALUES ('20140624044600');

INSERT INTO schema_migrations (version) VALUES ('20140627193814');

INSERT INTO schema_migrations (version) VALUES ('20140703022838');

INSERT INTO schema_migrations (version) VALUES ('20140705081453');

INSERT INTO schema_migrations (version) VALUES ('20140707071913');

INSERT INTO schema_migrations (version) VALUES ('20140710005023');

INSERT INTO schema_migrations (version) VALUES ('20140710224658');

INSERT INTO schema_migrations (version) VALUES ('20140711063215');

INSERT INTO schema_migrations (version) VALUES ('20140711143146');

INSERT INTO schema_migrations (version) VALUES ('20140711193923');

INSERT INTO schema_migrations (version) VALUES ('20140711233329');

INSERT INTO schema_migrations (version) VALUES ('20140714060646');

INSERT INTO schema_migrations (version) VALUES ('20140715013018');

INSERT INTO schema_migrations (version) VALUES ('20140715051412');

INSERT INTO schema_migrations (version) VALUES ('20140715055242');

INSERT INTO schema_migrations (version) VALUES ('20140715160720');

INSERT INTO schema_migrations (version) VALUES ('20140715190552');

INSERT INTO schema_migrations (version) VALUES ('20140716063802');

INSERT INTO schema_migrations (version) VALUES ('20140717024528');

INSERT INTO schema_migrations (version) VALUES ('20140718041445');

INSERT INTO schema_migrations (version) VALUES ('20140721063820');

INSERT INTO schema_migrations (version) VALUES ('20140721161249');

INSERT INTO schema_migrations (version) VALUES ('20140721162307');

INSERT INTO schema_migrations (version) VALUES ('20140723011456');

INSERT INTO schema_migrations (version) VALUES ('20140725050636');

INSERT INTO schema_migrations (version) VALUES ('20140725172830');

INSERT INTO schema_migrations (version) VALUES ('20140727030954');

INSERT INTO schema_migrations (version) VALUES ('20140728120708');

INSERT INTO schema_migrations (version) VALUES ('20140728144308');

INSERT INTO schema_migrations (version) VALUES ('20140728152804');

INSERT INTO schema_migrations (version) VALUES ('20140729092525');

INSERT INTO schema_migrations (version) VALUES ('20140730203029');

INSERT INTO schema_migrations (version) VALUES ('20140731011328');

INSERT INTO schema_migrations (version) VALUES ('20140801052028');

INSERT INTO schema_migrations (version) VALUES ('20140801170444');

INSERT INTO schema_migrations (version) VALUES ('20140804010803');

INSERT INTO schema_migrations (version) VALUES ('20140804030041');

INSERT INTO schema_migrations (version) VALUES ('20140804060439');

INSERT INTO schema_migrations (version) VALUES ('20140804072504');

INSERT INTO schema_migrations (version) VALUES ('20140804075613');

INSERT INTO schema_migrations (version) VALUES ('20140805061612');

INSERT INTO schema_migrations (version) VALUES ('20140806003116');

INSERT INTO schema_migrations (version) VALUES ('20140807033123');

INSERT INTO schema_migrations (version) VALUES ('20140808051823');

INSERT INTO schema_migrations (version) VALUES ('20140809224243');

INSERT INTO schema_migrations (version) VALUES ('20140811094300');

INSERT INTO schema_migrations (version) VALUES ('20140813175357');

INSERT INTO schema_migrations (version) VALUES ('20140815183851');

INSERT INTO schema_migrations (version) VALUES ('20140815191556');

INSERT INTO schema_migrations (version) VALUES ('20140815215618');

INSERT INTO schema_migrations (version) VALUES ('20140817011612');

INSERT INTO schema_migrations (version) VALUES ('20140818023700');

INSERT INTO schema_migrations (version) VALUES ('20140826234625');

INSERT INTO schema_migrations (version) VALUES ('20140827044811');

INSERT INTO schema_migrations (version) VALUES ('20140828172407');

INSERT INTO schema_migrations (version) VALUES ('20140828200231');

INSERT INTO schema_migrations (version) VALUES ('20140831191346');

INSERT INTO schema_migrations (version) VALUES ('20140904055702');

INSERT INTO schema_migrations (version) VALUES ('20140904160015');

INSERT INTO schema_migrations (version) VALUES ('20140904215629');

INSERT INTO schema_migrations (version) VALUES ('20140905055251');

INSERT INTO schema_migrations (version) VALUES ('20140905171733');

INSERT INTO schema_migrations (version) VALUES ('20140908165716');

INSERT INTO schema_migrations (version) VALUES ('20140908191429');

INSERT INTO schema_migrations (version) VALUES ('20140910130155');

INSERT INTO schema_migrations (version) VALUES ('20140911065449');

INSERT INTO schema_migrations (version) VALUES ('20140913192733');

INSERT INTO schema_migrations (version) VALUES ('20140923042349');

INSERT INTO schema_migrations (version) VALUES ('20140924192418');

INSERT INTO schema_migrations (version) VALUES ('20140925173220');

INSERT INTO schema_migrations (version) VALUES ('20140929181930');

INSERT INTO schema_migrations (version) VALUES ('20140929204155');

INSERT INTO schema_migrations (version) VALUES ('20141001101041');

INSERT INTO schema_migrations (version) VALUES ('20141002181613');

INSERT INTO schema_migrations (version) VALUES ('20141007224814');

INSERT INTO schema_migrations (version) VALUES ('20141008152953');

INSERT INTO schema_migrations (version) VALUES ('20141008181228');

INSERT INTO schema_migrations (version) VALUES ('20141008192525');

INSERT INTO schema_migrations (version) VALUES ('20141008192526');

INSERT INTO schema_migrations (version) VALUES ('20141014032859');

INSERT INTO schema_migrations (version) VALUES ('20141014191645');

INSERT INTO schema_migrations (version) VALUES ('20141015060145');

INSERT INTO schema_migrations (version) VALUES ('20141016183307');

INSERT INTO schema_migrations (version) VALUES ('20141020153415');

INSERT INTO schema_migrations (version) VALUES ('20141020154935');

INSERT INTO schema_migrations (version) VALUES ('20141020164816');

INSERT INTO schema_migrations (version) VALUES ('20141020174120');

INSERT INTO schema_migrations (version) VALUES ('20141030222425');

INSERT INTO schema_migrations (version) VALUES ('20141110150304');

INSERT INTO schema_migrations (version) VALUES ('20141118011735');

INSERT INTO schema_migrations (version) VALUES ('20141120035016');

INSERT INTO schema_migrations (version) VALUES ('20141120043401');

INSERT INTO schema_migrations (version) VALUES ('20141211114517');

INSERT INTO schema_migrations (version) VALUES ('20141216112341');

INSERT INTO schema_migrations (version) VALUES ('20141222051622');

INSERT INTO schema_migrations (version) VALUES ('20141222224220');

INSERT INTO schema_migrations (version) VALUES ('20141222230707');

INSERT INTO schema_migrations (version) VALUES ('20141223145058');

INSERT INTO schema_migrations (version) VALUES ('20141228151019');

INSERT INTO schema_migrations (version) VALUES ('20150102113309');

INSERT INTO schema_migrations (version) VALUES ('20150106215342');

INSERT INTO schema_migrations (version) VALUES ('20150108002354');

INSERT INTO schema_migrations (version) VALUES ('20150108202057');

INSERT INTO schema_migrations (version) VALUES ('20150108211557');

INSERT INTO schema_migrations (version) VALUES ('20150112172258');

INSERT INTO schema_migrations (version) VALUES ('20150112172259');

