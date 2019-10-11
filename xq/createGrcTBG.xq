let $parent := replace(file:parent(static-base-uri()), '/xq/', '') 
let $path := $parent || "/xml/" 
return  db:create("grc-tb-g", $path, (), map { 'attrindex': true(), 'intparse' : true(), 'autooptimize' : true(), 'updindex' : true() })