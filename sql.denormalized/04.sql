/*
 * Calculates the hashtags that are commonly used for English tweets containing the word "coronavirus"
 */



SELECT count(*)
FROM (SELECT DISTINCT data->>'id' as id_tweets
      FROM tweets_jsonb
      WHERE (to_tsvector('english',data->>'text')@@to_tsquery('english','coronavirus')  
      OR to_tsvector('english',data->'extended_tweet'->>'full_text')@@to_tsquery('english','coronavirus'))
      AND data->>'lang'='en') subquery ;
