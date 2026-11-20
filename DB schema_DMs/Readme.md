# Direct Messaging System (DMS)

This project is based on a Direct Messaging System where users
can have individual or group conversations and exchange messages.

The database is designed using PostgreSQL.

ER Diagram:
https://dbdiagram.io/d/6afff91b5cb51eed074bc2e7

## Tables
- users
- conversations
- conversation_participants
- messages
- message_receipts

## Running the schema

psql -f schema.sql