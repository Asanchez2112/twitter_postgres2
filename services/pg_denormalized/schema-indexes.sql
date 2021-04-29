\set ON_ERROR_STOP on

BEGIN;

CREATE INDEX tweets_short_hashtag ON tweets_jsonb USING GIN((data->'entities'->'hashtags'));

CREATE INDEX tweets_long_hashtag ON tweets_jsonb USING GIN((data->'extended_tweet'->'entities'->'hashtags'));

CREATE INDEX tweets_short_text ON tweets_jsonb USING GIN((to_tsvector('english',data->>'text')));

CREATE INDEX tweets_long_text ON tweets_jsonb USING GIN((to_tsvector('english',data->'extended_tweet'->>'full_text')));

CREATE INDEX tweets_long_text2 ON tweets_jsonb USING GIN((to_tsvector('english',coalesce(data->'extended_tweet'->>'full_text'))));

CREATE INDEX tweets_lang ON tweets_jsonb USING GIN((data->'lang'));


COMMIT;
