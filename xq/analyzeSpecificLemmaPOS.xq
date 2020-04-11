(: retrieve all POS descriptions for a lemma :)
declare function local:getlemma($db , $query){
   collection($db)//*:word[@lemma[normalize-unicode(string())=$query]]
};

declare function local:header($query){
  "# Statistics on Vanessa Gorman's Greek treebank collection: lemma " || $query || ", " || fn:current-date()  || "

Script name: analyzeSpecificLemmaRelation.xq
"
};

let $lemma := ("γάρ", "γε")
let $db := "grc-tb-g"
(: get wordlist :)
for $lem in $lemma
return ($lem , distinct-values(
for $w in local:getlemma($db, $lem)
let $r := $w/@relation
order by $r
return $r ) )
