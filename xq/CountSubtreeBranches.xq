let $db := "grc-tb-g-tree"
let $subcount := 4
let $result :=
for $s in collection($db)//*:sentence
where $s/*:word[*:word[$subcount]]
return $s
return "Sentences with " || $subcount || " branches below the first level: " || count($result)