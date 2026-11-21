-- K.N.O.T. Production Database Schema
-- Enables pgvector extension for sub-10ms nearest-neighbor matching

CREATE EXTENSION IF NOT EXISTS vector;

-- 1. Users Table (Core Auth & Legal Verification)
CREATE TABLE IF NOT EXISTS users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email VARCHAR(255) UNIQUE NOT NULL,
    full_name VARCHAR(255) NOT NULL,
    phone_hash VARCHAR(128),
    is_linkedin_verified BOOLEAN DEFAULT FALSE,
    is_digilocker_verified BOOLEAN DEFAULT FALSE,
    marital_status VARCHAR(64) DEFAULT 'never_married',
    legal_affidavit_hash VARCHAR(128),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 2. Candidate Profiles (Ephemeris & High-Dimensional Value Vectors)
CREATE TABLE IF NOT EXISTS candidate_profiles (
    user_id UUID PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
    birth_timestamp TIMESTAMP WITH TIME ZONE NOT NULL,
    birth_city VARCHAR(128) NOT NULL,
    has_exact_birth_time BOOLEAN DEFAULT FALSE,
    
    -- Astrological Sidereal Markers
    moon_rashi VARCHAR(64) NOT NULL,
    nakshatra VARCHAR(64) NOT NULL,
    nakshatra_pada INT CHECK (nakshatra_pada BETWEEN 1 AND 4),
    is_cusp_birth BOOLEAN DEFAULT FALSE,
    active_dasha_lord VARCHAR(32),

    -- High-Dimensional Values Vector (Finances, Career, Family, Conflict)
    -- Stored as pgvector for instantaneous cosine similarity queries
    value_embedding vector(4) NOT NULL,

    -- Career & Location
    role_title VARCHAR(128),
    company_name VARCHAR(128),
    metro_corridor VARCHAR(64) DEFAULT 'Bengaluru',
    is_incognito_active BOOLEAN DEFAULT FALSE,

    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Index for sub-millisecond Cosine Nearest Neighbor similarity search
CREATE INDEX IF NOT EXISTS value_vector_idx ON candidate_profiles USING hnsw (value_embedding vector_cosine_ops);

-- 3. High-Intent Matches & Concurrency Manager
CREATE TABLE IF NOT EXISTS matches (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user1_id UUID REFERENCES users(id),
    user2_id UUID REFERENCES users(id),
    kmva_composite_score FLOAT NOT NULL,
    celestial_score FLOAT NOT NULL,
    values_score FLOAT NOT NULL,
    status VARCHAR(32) DEFAULT 'dropped', -- 'dropped', 'connected', 'grace_expired', 'closed'
    matched_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    first_message_at TIMESTAMP WITH TIME ZONE,
    is_48h_grace_expired BOOLEAN DEFAULT FALSE
);

-- 4. Cryptographic Family Vault Dossiers
CREATE TABLE IF NOT EXISTS cryptographic_dossiers (
    verification_id VARCHAR(64) PRIMARY KEY,
    user1_id UUID REFERENCES users(id),
    user2_id UUID REFERENCES users(id),
    guna_milan_score INT NOT NULL,
    dosha_status VARCHAR(128) NOT NULL,
    tamper_proof_sha256 VARCHAR(128) NOT NULL,
    issued_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);
