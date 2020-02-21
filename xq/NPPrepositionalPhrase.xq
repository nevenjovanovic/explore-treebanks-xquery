(: noun phrase: prepositional phrase, always with the article :)
(: retrieve as fragment :)
(: article is head :)
for $frag in db:open("grc-tb-g-tree")//word[matches(@postag,"l........") and word[@postag="r--------"]]
order by $frag/@relation
return $frag