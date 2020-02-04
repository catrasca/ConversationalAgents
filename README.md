# ConversationalAgents

Articles, designs, and code for making conversational agents.

## Conversational agents for Machine Learning workflows

Currently the primary focus in this repository is the making of grammars for 
the generation of programming code for Machine Learning (ML) workflows.

The generation is done through dedicated grammar parsers and ML software monads.

### Example 

The following example shows a monadic pipeline generation of a Latent Semantic Analysis (LSA) workflows
in both R and Wolfram Language (WL) using: 

- the Raku (Perl 6) package [LatentSemanticAnalysisWorkflows](./Packages/Perl6/LatentSemanticAnalysisWorkflows),

- the R package [LSAMon-R](https://github.com/antononcube/R-packages/tree/master/LSAMon-R), and

- the WL package [MonadicLatentSemanticAnalysis.m](https://github.com/antononcube/MathematicaForPrediction/blob/master/MonadicProgramming/MonadicLatentSemanticAnalysis.m).

Note that:

- the sequences of natural commands are the same;

- the generated R and WL code pipelines are similar because the corresponding packages have similar implementations.

---

This Raku (Perl 6) command:

```perl6
say to_LSAMon_R('
create from aText;
make document term matrix with no stemming and automatic stop words;
echo data summary;
apply lsi functions global weight function idf, local term weight function none, normalizer function cosine;
extract 12 topics using method NNMF and max steps 12;
show topics table with 12 columns and 10 terms;
show thesaurus table for sing, left, home;
');
```

generates this R code:

```r
LSAMonUnit(aText) %>%
LSAMonMakeDocumentTermMatrix( stemWordsQ = NA, stopWords = NULL) %>%
LSAMonEchoDocumentTermMatrixStatistics( ) %>%
LSAMonApplyTermWeightFunctions(globalWeightFunction = "IDF", localWeightFunction = "None", normalizerFunction = "Cosine") %>%
LSAMonExtractTopics( numberOfTopics = 12, method = "NNMF",  maxSteps = 12) %>%
LSAMonEchoTopicsTable(numberOfTableColumns = 12, numberOfTerms = 10) %>%
LSAMonEchoStatisticalThesaurus( words = c("sing", "left", "home"))
```

---

This Raku (Perl 6) command:

```perl6
say to_LSAMon_WL('
create from aText;
make document term matrix with no stemming and automatic stop words;
echo data summary;
apply lsi functions global weight function idf, local term weight function none, normalizer function cosine;
extract 12 topics using method NNMF and max steps 12;
show topics table with 12 columns and 10 terms;
show thesaurus table for sing, left, home;
');
```

generates this WL code:

```mathematica
LSAMonUnit[aText] ⟹
LSAMonMakeDocumentTermMatrix[ "StemmingRules" -> None, "StopWords" -> Automatic] ⟹
LSAMonEchoDocumentTermMatrixStatistics[ ] ⟹
LSAMonApplyTermWeightFunctions["GlobalWeightFunction" -> "IDF", "LocalWeightFunction" -> "None", "NormalizerFunction" -> "Cosine"] ⟹
LSAMonExtractTopics["NumberOfTopics" -> 12, Method -> "NNMF", "MaxSteps" -> 12] ⟹
LSAMonEchoTopicsTable["NumberOfTableColumns" -> 12, "NumberOfTerms" -> 10] ⟹
LSAMonEchoStatisticalThesaurus[ "Words" -> { "sing", "left", "home" }]
```
