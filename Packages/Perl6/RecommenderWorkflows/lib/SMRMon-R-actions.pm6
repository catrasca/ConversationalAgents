#==============================================================================
#
#   SMRMon-R actions in Raku Perl 6
#   Copyright (C) 2019  Anton Antonov
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#   Written by Anton Antonov,
#   antononcube @ gmai l . c om,
#   Windermere, Florida, USA.
#
#==============================================================================
#
#   For more details about Raku Perl6 see https://perl6.org/ .
#
#==============================================================================
#
#   The actions are implemented for the grammar:
#
#     RecommenderWorkflowsGrammar::Recommender-workflow-commmand
#
#   and the software monad SMRMon-R:
#
#
#==============================================================================


use v6;
#use lib ".";
#use lib "../../../EBNF/English/RakuPerl6/";
use RecommenderWorkflowsGrammar;

unit module SMRMon-R-actions;

class SMRMon-R-actions::SMRMon-R-actions {

  # Top
  method TOP($/) { make $/.values[0].made; }

  # General
  method variable-name($/) { make $/.Str; }
  method list-separator($/) { make ','; }
  method variable-names-list($/) { make 'c(' ~ $<variable-name>>>.made.join(', ') ~ ')'; }

  # (Scored) item lists
  method item-id($/) { make '\"' ~ $/.Str ~ '\"'; }
  method item-ids-list($/) { make 'c(' ~ $<item-id>>>.made.join(', ') ~ ')'; }
  method scored-item-id($/) { make '\"' ~ $<item-id> ~ '\"' ~ '=' ~ $<number-value>; }
  method scored-item-ids-list($/) { make 'c(' ~ $<scored-item-id>>>.made.join(', ') ~ ')'; }

  # (Scored) tag lists
  method tag-id($/) { make '\"' ~ $/.Str ~ '\"'; }
  method tag-ids-list($/) { make 'c(' ~ $<tag-id>>>.made.join(', ') ~ ')'; }
  method scored-tag-id($/) { make '\"' ~ $<tag-id> ~ '\"' ~ '=' ~ $<number-value>; }
  method scored-tag-ids-list($/) { make 'c(' ~ $<scored-tag-id>>>.made.join(', ') ~ ')'; }

  # Data load commands
  method data-load-command($/) { make $/.values[0].made; }
  method load-data($/) { make 'SMRMonSetData( data = ' ~ $<data-location-spec>.made ~ ')'; }
  method data-location-spec($/) { make $<dataset-name>.made; }
  method use-recommender($/) { make $<variable-name>.made; }
  method dataset-name($/) { make $/.Str; }

  # Create commands
  method create-command($/) { make $/.values[0].made; }
  method create-simple($/) { make 'SMRMonCreate()'; }
  method create-by-dataset($/) { make 'SMRMonCreate( data = ' ~ $<dataset-name>.made ~ ')'; }
  method create-by-matrices($/) { make 'SMRMonCreateFromMatrices( matrices = ' ~ $<variable-names-list>.made ~ ')'; }

  # Data statistics command
  method statistics-command($/) { make $/.values[0].made; }
  method show-data-summary($/) { make 'SMRMonEchoDataSummary()'; }
  method summarize-data($/) { make 'SMRMonEchoDataSummary()'; }
  method items-per-tag($/) { make 'SMRMonItemsPerTagDistribution()'; }
  method tags-per-items($/) { make 'SMRMonTagsPerItemDistribution()'; }

  # Recommend by history command
  method recommend-by-history-command($/) { make 'SMRMonRecommend( history = ' ~ $<history-spec>.made ~ ')'; }
  method history-spec($/) { make $/.values[0].made; }

  # Recommend by profile command
  method recommend-by-profile-command($/) { make 'SMRMonRecommendByProfile( profile = ' ~ $<profile-spec>.made ~ ')'; }
  method profile-spec($/) { make $/.values[0].made; }

  # Process recommendations command
  method extend-recommendations-command($/) { make 'SMRMonJoinAcross( data = ' ~ $<dataset-name>.made ~ ')' }

  # Plot command
  method plot-command($/) { make $/.values[0].made; }
  method plot-recommendation-scores($/) { make 'SMRPlotScores()'; }

  # SMR query command
  method smr-query-command($/) { make $<smr-property-spec>.made; }
  method smr-property-spec($/) { make $/.values[0].made; }
  method smr-context-property-spec($/) { make 'SMRMonGetProperty(' ~ $/.values[0].made ~ ') %>% SMRMonEchoValue()'; }
  method smr-recommendation-matrix($/) { make '\"sparseMatrix\"'; }
  method smr-tag-types($/) { make '\"tagTypes\"'; }
  method smr-item-column-name($/) { make '\"itemColumnName\"'; }
  method smr-sub-matrices($/) { make '\"subMatrices\"'; }
  method smr-matrix-property-spec($/) { make 'SMRMonGetMatrixProperty(' ~ $/.values[0].made ~ ') %>% SMRMonEchoValue()'; }
  method smr-matrix-property($/) { make '\"' ~ $/.values[0].made() ~ '\"'; }
  method number-of-columns($/) { make '\"numberOfColumns\"'; }
  method number-of-rows($/) { make '\"numberOfRows\"'; }
  method rows($/) { make '\"rows\"'; }
  method columns($/) { make '\"columns\"'; }
  method dimensions($/) { make '\"dimensions\"'; }
  method density($/) { make '\"density\"'; }

  # Pipeline command
  method pipeline-command($/) { make  $/.values[0].made; }
  method get-pipeline-value($/) { make 'SMRMonEchoValue()'; }

}
