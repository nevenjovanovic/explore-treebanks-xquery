(: which parts of speech can take on a specific role? :)

(: for codes return full grammatical terms :)
declare variable $posnames := map {
  "v" : "verb (v)",
  "n" : "noun (n)",
  "l" : "article (l)",
  "a" : "adjective (a)",
  "p" : "pronoun (p)",
  "d" : "adverb (d)",
  "r" : "adposition (r)",
  "c" : "conjunction (c)",
  "i" : "interjection (i)",
  "m" : "numeral (m)",
  "u" : "punctuation (u)",
  "x" : "irregular (x)"
  
};


let $db := "grc-tb-g"
(: one or more of PRED SBJ OBJ ATR ADV ATV ATvV PNOM OCOMP COORD APOS MWE AuxP AuxC AuxR AuxV AuxX AuxG AuxK AuxY AuxZ ExD:)
(: See https://github.com/alpheios-project/arethusa-configs/blob/master/configs/arethusa.relation/relations2.json for explanation :)
let $relation := "SBJ"
let $result :=
for $s in collection($db)//*:sentence[not(*:word/@postag=(""))]/*:word[starts-with(@relation,$relation)]
let $postag := substring($s/@postag/string(), 1, 1)
group by $postag
order by count($s) descending
let $name := if (map:get($posnames , $postag)) then map:get($posnames , $postag) else if ($postag="") then "0" else $postag
return (
  $name || " | " || count($s))
return (
  "# Parts of speech in the role of " || $relation || "
  ",
  "POS | Word count",
  "----- | -----",
  $result
)