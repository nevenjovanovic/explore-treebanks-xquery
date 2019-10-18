(: how many subtrees per sentence? :)
(: a subtree is word with head=0 :)
( "SUB | SENT",
" --- | ---",
let $db := "grc-tb-g-tree"
let $sentsubtrees := 
for $s in collection($db)//*:sentence
let $subtree := count($s/*:word)
group by $subtree
order by $subtree descending
return ($subtree || " | " || count($s))
return $sentsubtrees
)
