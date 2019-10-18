(: how many branches? how are they distributed by length? :)
( ("Levels | Count of branches"),
let $db := "grc-tb-g-tree"
let $branchtypes := 
for $w in collection($db)//*:sentence/*:word
(: let $doc := db:path($w) :)
let $branch := $w//@relation/string()
let $branchstring := string-join($branch,"-")
return $branchstring
for $b in $branchtypes
let $c := count(tokenize($b, "-"))
group by $c
order by $c descending
return
$c || " | " || count($b) )
