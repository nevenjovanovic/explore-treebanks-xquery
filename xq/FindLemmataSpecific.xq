(: find a specific lemma in the collection :)
(: just return all occurrences :)

let $db := "grc-tb-g"
let $query := "γε"
let $result :=
for $occ in collection($db)//*:word[@lemma[normalize-unicode(string())=$query]]
return $occ
return ( 
"# Statistics on Vanessa Gorman's Greek treebank collection: lemma " || $query || ", " || fn:current-date()  || "

Script name: FindLemmataSpecific.xq
",
$result
)