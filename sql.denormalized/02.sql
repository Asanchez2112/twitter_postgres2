/*
 * Calculates the hashtags that are commonly used with the hashtag #coronavirus
 */

SELECT
    tag AS tag,
    count(*) AS count
    FROM (SELECT DISTINCT data->>'id' AS id_tweets,
          '#'||(jsonb_array_elements(COALESCE(data->'entities'->'hashtags','[]')||  COALESCE(data->'extended_tweet'->'entities'->'hashtags','[]'))->>'text')::TEXT AS tag
          FROM tweets_jsonb
          WHERE data-> 'extended_tweet' -> 'entities' -> 'hashtags' @>'[{"text":"coronavirus"}]'
      OR data->'entities'->'hashtags'@> '[{"text":"coronavirus"}]'  
        ) t
    GROUP BY (1)
    ORDER BY count DESC,tag
    LIMIT 1000;

