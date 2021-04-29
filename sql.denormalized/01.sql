/*
 * Count the number of tweets that use #coronavirus
 */

SELECT count(DISTINCT data->'id' )
FROM tweets_jsonb
WHERE data-> 'extended_tweet' -> 'entities' -> 'hashtags' @>'[{"text":"coronavirus"}]' 
OR data->'entities'->'hashtags'@> '[{"text":"coronavirus"}]';
