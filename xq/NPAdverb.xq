(: noun phrase: adverb, always with the article :)
(: retrieve as fragment :)
(: article is head :)
for $frag in db:open("grc-tb-g-tree")//word[matches(@postag,"l........") and word[matches(@postag,"d........") and @relation="ATR"]]
order by $frag/@relation
return $frag