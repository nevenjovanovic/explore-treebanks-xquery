# Explore dependency tree morphosyntactic annotations with XQuery

[Neven Jovanović](orcid.org/0000-0002-9119-399X), Department of Classical Philology, Faculty of Humanities and Social Sciences, University of Zagreb

## Summary

Import a set of treebanks (for example, from [Vanessa Gorman's](https://history.unl.edu/vanessa-b-gorman) Greek collection, freely available through [Github](https://github.com/vgorman1/Greek-Dependency-Trees/tree/master/xml%20versions) and [Perseids Publications](https://perseids-publications.github.io/gorman-trees/)) into an XML database, and use XQuery scripts (for example, from BaseX) to analyze the set.

## How to get started

1. [Clone](https://help.github.com/en/articles/cloning-a-repository) this repository
2. Install [BaseX](http://basex.org/)
3. From BaseX, open and 
   1. download the XML files from Gorman's repository or [clone](https://help.github.com/en/articles/cloning-a-repository) the repository
   2. run the script [createGrcTBG.xq](https://github.com/nevenjovanovic/explore-treebanks-xquery/blob/master/xq/createGrcTBG.xq)
   3. alternatively, run the script [createGrcTBGpull.xq](https://github.com/nevenjovanovic/explore-treebanks-xquery/blob/master/xq/createGrcTBGpull.xq), and then [populateGrcTBGfromGit.xq](https://github.com/nevenjovanovic/explore-treebanks-xquery/blob/master/xq/populateGrcTBGfromGit.xq); the second script pulls the files directly from Github and adds them to the database created by the first script
4. Run other XQuery scripts

# Some basic queries

# A note on the XML source repositories

[Gorman's Github repo](https://github.com/vgorman1/Greek-Dependency-Trees/tree/master/xml%20versions) and [Perseids Publications](https://perseids-publications.github.io/gorman-trees/) differ slightly in filenames and stability. Gorman's is the working repo, more up to date; Perseids contains more stable versions and might not be synchronized immediately.

# License

[CC-BY](LICENSE.md)
