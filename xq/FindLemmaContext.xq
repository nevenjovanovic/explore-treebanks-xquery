(: find an individual lemma, return its context :)
let $lemma1 := "γε"
let $db := "grc-tb-g"
let $result :=
for $occ in collection($db)//*:word[@lemma=$lemma1]
let $sent := $occ/../*:word/@form/string()
return element r { db:path($occ) , $occ , $sent }
return $result