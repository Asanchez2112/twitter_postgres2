/*
 * Calculates the languages that commonly use the hashtag #coronavirus
 */

SELECT
    lang,
    count(*) as count
    FROM (SELECT DISTINCT data ->> 'id' AS id_tweets,
          data->>'lang' AS lang
          FROM tweets_jsonb
          WHERE data-> 'extended_tweet' -> 'entities' -> 'hashtags' @>'[{"text":"coronavirus"}]'
          OR data->'entities'->'hashtags'@> '[{"text":"coronavirus"}]'
          ) t
    GROUP BY lang
    ORDER BY count DESC,lang;

