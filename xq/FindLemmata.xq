(: how many different wordforms in the collection? :)

let $db := "grc-tb-g"
let $result :=
for $occ in collection($db)//*:word/@lemma/string()
let $lemma := normalize-unicode($occ)
group by $lemma
order by count($occ) descending , $lemma collation "?lang=el"
return ($lemma || " | " || count($occ) )
let $n := count($result)
return ( 
"# Statistics on Vanessa Gorman's Greek treebank collection: lemmata ordered by count of occurrences, " || fn:current-date()  || "

Script name: FindLemmata.xq
", 
"Total lemmata (Unicode NFC normalized): " || $n || "
", 
"Lemma | Count" ,
" ---- | ---- ",
$result
)