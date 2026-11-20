CREATE TABLE users (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    display_name VARCHAR(100) NOT NULL,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE conversations (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    conversation_type VARCHAR(10) NOT NULL
        CHECK (conversation_type IN ('direct', 'group')),
    title VARCHAR(120),
    created_by BIGINT NOT NULL REFERENCES users(id),
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE conversation_participants (
    conversation_id BIGINT NOT NULL REFERENCES conversations(id),
    user_id BIGINT NOT NULL REFERENCES users(id),
    role VARCHAR(20) DEFAULT 'member'
        CHECK (role IN ('member', 'admin')),
    joined_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    left_at TIMESTAMPTZ,
    last_read_at TIMESTAMPTZ,
    PRIMARY KEY (conversation_id, user_id),
    CHECK (left_at IS NULL OR left_at >= joined_at)
);

CREATE TABLE messages (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    conversation_id BIGINT NOT NULL REFERENCES conversations(id),
    sender_id BIGINT NOT NULL,
    body TEXT NOT NULL CHECK (LENGTH(TRIM(body)) > 0),
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    edited_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,

    FOREIGN KEY (conversation_id, sender_id)
        REFERENCES conversation_participants(conversation_id, user_id),

    UNIQUE (conversation_id, id)
);

CREATE TABLE message_receipts (
    conversation_id BIGINT NOT NULL,
    message_id BIGINT NOT NULL,
    recipient_id BIGINT NOT NULL,
    delivered_at TIMESTAMPTZ,
    read_at TIMESTAMPTZ,

    PRIMARY KEY (message_id, recipient_id),

    FOREIGN KEY (conversation_id, message_id)
        REFERENCES messages(conversation_id, id),

    FOREIGN KEY (conversation_id, recipient_id)
        REFERENCES conversation_participants(conversation_id, user_id),

    CHECK (read_at IS NULL OR delivered_at IS NOT NULL),
    CHECK (read_at IS NULL OR read_at >= delivered_at)
);

-- Indexes

CREATE INDEX conversations_created_by_idx
ON conversations(created_by);

CREATE INDEX participants_user_id_idx
ON conversation_participants(user_id);

CREATE INDEX messages_conversation_created_idx
ON messages(conversation_id, created_at DESC);

CREATE INDEX messages_sender_id_idx
ON messages(sender_id);

CREATE INDEX receipts_conversation_recipient_idx
ON message_receipts(conversation_id, recipient_id);

CREATE INDEX receipts_conversation_message_idx
ON message_receipts(conversation_id, message_id);