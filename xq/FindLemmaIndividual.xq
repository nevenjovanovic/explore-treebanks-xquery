(: find an individual lemma :)
let $lemma1 := "‘Θεμιστοκλῆς"
let $db := "grc-tb-g"
let $result :=
for $occ in collection($db)//*:word[@lemma=$lemma1]
return ( db:path($occ) , $occ )
return $result