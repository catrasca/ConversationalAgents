#==============================================================================
#
#   Data transformation workflows grammar in Raku Perl 6
#   Copyright (C) 2018  Anton Antonov
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

use v6;
unit module DataTransformationWorkflowsGrammar;

# This role class has common command parts.
role DataTransformationWorkflowsGrammar::CommonParts {

  rule load-data-directive { 'load' 'data' }
  token create-directive { 'create' | 'make' }
  token compute-directive { 'compute' | 'find' | 'calculate' }
  token display-directive { 'display' | 'show' }
  token using-preposition { 'using' | 'with' | 'over' }
  token by-preposition { 'by' | 'with' | 'using' }
  token for-preposition { 'for' | 'with' }
  token assign { 'assign' | 'set' }
  token a-determiner { 'a' | 'an'}
  token the-determiner { 'the' }
  token rows { 'rows' | 'records' }
  rule for-which-phrase { 'for' 'which' | 'that' 'adhere' 'to' }

  # True dplyr; see comments below.
  rule data { 'the'? 'data' }
  rule select { 'select' | 'keep' 'only'? }
  rule filter { 'filter' | <select> }
  token mutate { 'mutate' }
  rule group-by { 'group' ( <by-preposition> | <using-preposition> ) }
  rule arrange { ( 'arrange' | 'order' | 'sort' ) ( <by-preposition> | <using-preposition> )? }
  token ascending { 'ascending' | 'asc' }
  token descending { 'descending' | 'desc' }
  token variables { 'variable' | 'variables' }

  # Variable list
  token list-separator-symbol { ',' | '&' | 'and' }
  token list-separator { <.ws>? <list-separator-symbol> <.ws>? }
  token variable-name { ([\w | '_' | '.']+) <!{ $0 eq 'and' }> }
  rule variable-names-list { <variable-name>+ % <list-separator> }
  token assign-to-symbol { '=' | ':=' | '<-' }

  # Predicates
  rule predicates-list { <predicate>+ % <list-separator> }
  rule predicate { <variable-name> <predicate-symbol> <predicate-value> }
  token predicate-symbol { "==" | "<" | "<=" | ">" | ">=" }
  rule predicate-value { <variable-name> }
  # rule predicate-value { <number> | <string> | <variable-name> }
  # token number { (\d*) }
  # token string { "'" \w* "'" }
}

# Here we model the transformation natural language commands after R/RStudio's library "dplyr".
# For more details see: https://dplyr.tidyverse.org/ .
grammar DataTransformationWorkflowsGrammar::Spoken-dplyr-command does CommonParts {

  # TOP
  rule TOP { <load-data> | <select-command> | <filter-command> | <mutate-command> |
             <group-command> | <statistics-command> | <arrange-command> }

  # Load data
  rule load-data { <.load-data-directive> <data-location-spec> }
  rule data-location-spec { .* }

  # Select command
  rule select-command { <select> <.the-determiner>? <.variables>? <variable-names-list> }

  # Filter command
  rule filter-command { <filter> <.the-determiner>? <.rows>? ( <.for-which-phrase>? | <by-preposition> )  <filter-spec> }
  rule filter-spec { <predicates-list> }

  # Mutate command
  rule mutate-command { ( <mutate> | <assign> ) <.by-preposition>? <assign-pairs-list> }
  rule assign-pair { <variable-name> <.assign-to-symbol> <variable-name> }
  rule assign-pairs-list { <assign-pair>+ % <.list-separator> }

  # Group command
  rule group-command { <group-by> <variable-names-list> }

  # Arrange command
  rule arrange-command { <arrange-command-descending> | <arrange-command-ascending> }
  rule arrange-command-simple { <arrange> <.the-determiner>? <.variables>? <variable-names-list> }
  rule arrange-command-ascending { <arrange-command-simple> <.ascending>? }
  rule arrange-command-descending { <arrange-command-simple> <descending> }

  # Statistics command
  rule statistics-command { <count-command> | <summarize-all-command> }
  rule count-command { <compute-directive> <.the-determiner>? ( 'count' | 'counts' ) }
  rule summarize-all-command { ( 'summarize' | 'summarise' ) 'them'? 'all'? }
}
