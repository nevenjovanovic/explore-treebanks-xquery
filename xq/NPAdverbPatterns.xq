(: noun phrase: article with the AuxP complement :)
(: retrieve as fragment :)
(: article is head :)
for $frag in db:open("grc-tb-g-tree")//word[matches(@postag,"l........") and word[starts-with(@postag, "r")]]
order by $frag/@relation , count($frag//word) , $frag/word[1]/@relation
return element word { $frag/@relation ,
for $f in $frag//word return element word { $f/@relation }
}