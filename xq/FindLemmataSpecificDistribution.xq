(: find a specific lemma in the collection :)
(: return distribution by document name :)

let $db := "grc-tb-g"
let $query := "γάρ"
let $result :=
for $occ in collection($db)//*:word[@lemma[normalize-unicode(string())=$query]]
let $docname := db:path($occ)
group by $docname
let $ratio := round(count($occ) div count(db:open($db , $docname)//*:word) * 100 , 3)
order by $ratio descending
return ($docname || " | " || count($occ) || " | " || $ratio  )
return ( 
"# Statistics on Vanessa Gorman's Greek treebank collection: lemma " || $query || ", " || fn:current-date()  || "

Script name: FindLemmataSpecificDistribution.xq
",
$result
)