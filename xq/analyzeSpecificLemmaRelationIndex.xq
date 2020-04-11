(: retrieve all minority, n < 100, relation descriptions for a lemma :)
(: list names of documents where such descriptions appear :)
declare function local:getlemma($db , $query){
   collection($db)//*:word[@lemma[normalize-unicode(string())=$query]]
};

declare function local:header($query){
  "# Analysis of Vanessa Gorman's Greek treebank collection: relations of the lemma " || $query || " with less than 100 occurrences, " || fn:current-date()  || "

Script name: analyzeSpecificLemmaRelationIndex.xq

Relation | Count | Documents
---- | ---- | ---- "
};

let $lemma := ("γάρ", "γε")
let $db := "grc-tb-g"
(: get wordlist :)
for $lem in $lemma
return (local:header($lem) , 
for $w in local:getlemma($db, $lem)
let $p := db:path($w)
let $r := $w/@relation
group by $r
order by $r
return  if ( count($w) < 100 ) then ( $r || " | " || count($w) || " | " || string-join($p, "; ") )  else()
)