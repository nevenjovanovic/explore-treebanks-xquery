(: how many different wordforms in the collection? :)

let $db := "grc-tb-g"
let $result :=
for $l in distinct-values(
  collection($db)//*:word[not(@lemma="")]/@lemma/string()
)
for $occ in collection($db)//*:word[@lemma=$l]
let $lemma := $occ/@lemma
group by $lemma
order by count($occ) descending , $lemma collation "?lang=el"
return ($lemma || " | " || count($occ) )
let $n := count($result)
return ( 
"# Statistics on Vanessa Gorman's Greek treebank collection: lemmata ordered by count of occurrences, " || fn:current-date()  || "

Script name: FindLemmata.xq
", 
"Total lemmata: " || $n || "
", 
"Lemma | Count" ,
" ---- | ---- ",
$result
)