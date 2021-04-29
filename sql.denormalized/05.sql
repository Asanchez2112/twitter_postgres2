/*
 * Calculates the hashtags that are commonly used for English tweets containing the word "coronavirus"
 */



SELECT 
    '#' || tag AS tag,
    count(*) AS count
    FROM (SELECT DISTINCT data->>'id' AS id_tweets,
         (jsonb_array_elements(COALESCE(data->'entities'->'hashtags','[]')||  COALESCE(data->'extended_tweet'->'entities'->'hashtags','[]'))->>'text')::TEXT AS tag
       FROM tweets_jsonb
       WHERE  (to_tsvector('english',data->>'text')@@to_tsquery('english','coronavirus') OR to_tsvector('english',data->'extended_tweet'->>'full_text')@@to_tsquery('english','coronavirus')) 
        AND data-> 'lang'='"en"'::jsonb
          ) t
    GROUP BY tag
    ORDER BY count DESC,tag
    LIMIT 1000;

