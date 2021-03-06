# Explore dependency tree morphosyntactic annotations with XQuery

[Neven Jovanović](orcid.org/0000-0002-9119-399X), Department of Classical Philology, Faculty of Humanities and Social Sciences, University of Zagreb

## Summary

Import a set of treebanks (for example, from [Vanessa Gorman's](https://history.unl.edu/vanessa-b-gorman) Greek collection, freely available through [Github](https://github.com/vgorman1/Greek-Dependency-Trees/tree/master/xml%20versions) and [Perseids Publications](https://perseids-publications.github.io/gorman-trees/)) into an XML database. Use XQuery scripts (for example, from the [BaseX GUI](http://docs.basex.org/wiki/Graphical_User_Interface)) to analyze the set.

## How to get started

1. [Clone](https://help.github.com/en/articles/cloning-a-repository) this repository
2. Install [BaseX](http://basex.org/)
3. From BaseX, open and 
   1. download the XML files from Gorman's repository or [clone](https://help.github.com/en/articles/cloning-a-repository) the repository
   2. run the script [createGrcTBG.xq](https://github.com/nevenjovanovic/explore-treebanks-xquery/blob/master/xq/createGrcTBG.xq)
4. alternatively to 3, without cloning Gorman's repo 
   1. run the script [createGrcTBGpull.xq](https://github.com/nevenjovanovic/explore-treebanks-xquery/blob/master/xq/createGrcTBGpull.xq),
   2. then run  [populateGrcTBGfromGit.xq](https://github.com/nevenjovanovic/explore-treebanks-xquery/blob/master/xq/populateGrcTBGfromGit.xq); the second script pulls the files directly from Github and adds them to the database created by the first script (it takes about a minute)
4. Run other XQuery scripts (see the [project wiki](https://github.com/nevenjovanovic/explore-treebanks-xquery/wiki))

# Some basic queries

1. retrieve some statistics on the collection and its annotations (for results, see the [wiki](https://github.com/nevenjovanovic/explore-treebanks-xquery/wiki)): 
   1. how many sentences and words (also excluding punctuation): [GrcTBStatsGeneral.xq](https://github.com/nevenjovanovic/explore-treebanks-xquery/blob/master/xq/GrcTBStatsGeneral.xq)
   2. how many ellipses, words without annotations or with undefined annotations: [GrcTBStatsGeneral.xq](https://github.com/nevenjovanovic/explore-treebanks-xquery/blob/master/xq/GrcTBStatsGeneral.xq)
   3. sentences grouped by word count: [GrcTBStatsGeneral.xq](https://github.com/nevenjovanovic/explore-treebanks-xquery/blob/master/xq/GrcTBStatsGeneral.xq)
   4. how many instances of certain syntactic relations: [GrcTBStatsRelations-1.xq](https://github.com/nevenjovanovic/explore-treebanks-xquery/blob/master/xq/GrcTBStatsRelations-1.xq); current results on a [dedicated wiki page](https://github.com/nevenjovanovic/explore-treebanks-xquery/wiki/StatsRelations)
   5. how many instances of certain parts of speech – how many nouns, verbs, adverbs...? [GrcTBStatsPOS-1.xq](https://github.com/nevenjovanovic/explore-treebanks-xquery/blob/master/xq/GrcTBStatsPOS-1.xq); current results on a [wiki page](https://github.com/nevenjovanovic/explore-treebanks-xquery/wiki/StatsPOS)
   6. how many wordforms: script [FindWordforms1.xq](https://github.com/nevenjovanovic/explore-treebanks-xquery/blob/master/xq/FindWordforms1.xq), report on the wiki page [WordformsList](https://github.com/nevenjovanovic/explore-treebanks-xquery/wiki/WordformsList) (66,313 wordforms) – how many lemmata: script [FindLemmata.xq](https://github.com/nevenjovanovic/explore-treebanks-xquery/blob/master/xq/FindLemmata.xq), report on the wiki page [LemmataList](https://github.com/nevenjovanovic/explore-treebanks-xquery/wiki/LemmataList) (18,056 lemmata)
   7. how many lemmata per parts of speech
2. retrieve sentences of a certain type, or configuration
3. retrieve a list of all parts of speech in a specific syntactic relation: [FindPOStag.xq](https://github.com/nevenjovanovic/explore-treebanks-xquery/blob/master/xq/FindPOStag.xq); what POS can take on the role of subject? – for example, report for AuxZ, emphasizing particle: [POStagAuxZ](https://github.com/nevenjovanovic/explore-treebanks-xquery/wiki/POStagAuxZ)
4. retrieve a set of treebank fragments – a specific syntactic relation, its parent, and all its children [traverseTree1-levels-all.xq)](https://github.com/nevenjovanovic/explore-treebanks-xquery/blob/master/xq/traverseTree1-levels-all.xq) (what is dependent on a subject?); but [it can be achieved more easily and efficiently](https://github.com/nevenjovanovic/explore-treebanks-xquery/wiki/TransformListToTree) following [Bozia 2018](https://nbn-resolving.org/urn:nbn:de:bsz:15-qucosa2-319358)
5. transform the "flat" ALDT XML into nested tree structures, as proposed by [Bozia 2018](https://nbn-resolving.org/urn:nbn:de:bsz:15-qucosa2-319358), for easier retrieving of children and parent nodes: [ListToTree.xq](https://github.com/nevenjovanovic/explore-treebanks-xquery/blob/master/xq/ListToTree.xq)

# A note on the XML source repositories

[Gorman's Github repo](https://github.com/vgorman1/Greek-Dependency-Trees/tree/master/xml%20versions) and [Perseids Publications](https://perseids-publications.github.io/gorman-trees/) differ slightly in filenames and stability. Gorman's is the working repo, more up to date; Perseids contains more stable versions and might not be synchronized immediately.

# License

[CC-BY](LICENSE.md)
