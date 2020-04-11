(: retrieve all POS descriptions for a lemma :)
declare function local:getlemma($db , $query){
   collection($db)//*:word[@lemma[normalize-unicode(string())=$query]]
};

declare function local:header($query){
  "# Statistics on Vanessa Gorman's Greek treebank collection: relations of lemma " || $query || ", " || fn:current-date()  || "

Script name: analyzeSpecificLemmaRelation.xq

Relation | Count
---- | ----"
};

let $lemma := ("γάρ", "γε")
let $db := "grc-tb-g"
(: get wordlist :)
for $lem in $lemma
return (local:header($lem) , 
for $w in local:getlemma($db, $lem)
let $r := $w/@relation
group by $r
order by $r
return ( $r || " | " || count($w) )
)