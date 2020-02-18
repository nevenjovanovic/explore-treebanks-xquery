(: calculate degree of node for each word element :)
(: group word elements by degree of node :)
let $title := "# Words in Gorman's collection by degree of node, " || fn:current-date()
let $header := ( "Degree of node | Word count" ,  " ---- | ---- " )
let $db := "grc-tb-g-tree"
let $counts := element count {
for $w in db:open($db)//word
let $children := $w/word
let $wDegree := count($children)
order by $wDegree descending
return element d { $wDegree }
}
let $result :=
for $c in $counts/*
let $value := $c/string()
group by $value
return ( $value  || " | "||  count($c) )
return ( $title , $header , $result )