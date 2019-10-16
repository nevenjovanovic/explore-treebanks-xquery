(: run this after createGrcTBGTree.xq :)
(: transform ALDT XML to nested word nodes :)
(: add transformed trees to database :)
(: takes about 22sec on 123 files without empty @head attrs :)
declare function local:makenode ($nodes, $id, $head, $attrs){
  element word { 
  $id , 
  $attrs ,
  $head, 
  for $n in $nodes/../*[@head=$id]
  return local:makenode($n, $n/@id , $n/@head , $n/@*[not(name()=("id", "head"))] ) }
};
let $db := "grc-tb-g"
for $node in collection($db)//*:treebank[not(*:sentence/*:word[@head=""])]
let $docname := db:path($node)
let $newdoc := element treebank {
  $node/@*,
  $node/*[not(name()="sentence")],
  
for $s in $node/*:sentence
return element sentence {
  $s/@* ,
for $w in $s/*:word
let $id := $w/@id
let $attrs := $w/@*[not(name()=("id", "head"))]
let $head := $w/@head
return if ($head=0) then local:makenode($w, $id ,$head, $attrs)
}
}
return db:add("grc-tb-g-tree", $newdoc, $docname)