use v6;

# This role class has common command parts.
role EpidemiologyModelingWorkflows::Grammar::CommonParts {
    # Speech parts
    token a-determiner { 'a' | 'an'}
    token and-conjunction { 'and' }
    token apply-verb { 'apply' }
    token assign { 'assign' | 'set' }
    token by-preposition { 'by' | 'with' | 'using' }
    token calculation { 'calculation' }
    token create { 'create' }
    token do-verb { 'do' }
    token for-preposition { 'for' | 'with' }
    token from-preposition { 'from' }
    token get-verb { 'obtain' | 'get' | 'take' }
    token histogram { 'histogram' }
    token histograms { 'histograms' }
    token in-preposition { 'in' }
    token is-verb { 'is' }
    token model { 'model' }
    token object { 'object' }
    token of-preposition { 'of' }
    token over-preposition { 'over' }
    token per { 'per' }
    token plot { 'plot' }
    token plots { 'plot' | 'plots' }
    token results { 'results' }
    token run-verb { 'run' | 'runs' }
    token running-verb { 'running' }
    token simple { 'simple' | 'direct' }
    token simulate { 'simulate' }
    token simulation { 'simulation' }
    token that-pronoun { 'that' }
    token the-determiner { 'the' }
    token this-pronoun { 'this' }
    token to-preposition { 'to' | 'into' }
    token transform-verb { 'transform' }
    token use-verb { 'use' | 'utilize' }
    token using-preposition { 'using' | 'with' | 'over' }
    token with-preposition { 'using' | 'with' | 'by' }

    rule for-which-phrase { 'for' 'which' | 'that' 'adhere' 'to' }
    rule number-of { [ 'number' | 'count' ] 'of' }
    rule simple-way-phrase { 'simple' [ 'way' | 'manner' ] }

    # Data
    token dataset-name { ([ \w | '_' | '-' | '.' | \d ]+) <!{ $0 eq 'and' || $0 eq 'max' || $0 eq 'min' }> }
    token records { 'rows' | 'records' }
    token variable-name { ([ \w | '_' | '-' | '.' | \d ]+) <!{ $0 eq 'and' || $0 eq 'max' || $0 eq 'min' }> }

    rule data { <data-frame> | 'data' | 'dataset' }
    rule data-frame { 'data' 'frame' }
    rule time-series-data { 'time' 'series' 'data'? }

    # Directives
    token assign-directive { 'assign' }
    token compute-directive { 'compute' | 'find' | 'calculate' }
    token create-directive { <create> | 'make' }
    token diagram { 'plot' | 'plots' | 'graph' | 'chart' }
    token display-directive { 'display' | 'show' | 'echo' }
    token generate-directive { 'generate' | 'create' | 'make' }
    token represent-directive { <represent> | 'render' | 'reflect' }
    token set-directive { 'set' }
    token simulate-directive { <simulate> }

    rule compute-and-display { <compute-directive> [ 'and' <display-directive> ]? }
    rule simulate-and-display { <simulate-directive> [ 'and' <display-directive> ]? }
    rule load-data-directive { ( 'load' | 'ingest' ) <.the-determiner>? <data> }
    rule plot-directive { 'plot' | 'chart' | <display-directive> <diagram> }
    rule use-directive { [ <get-verb> <and-conjunction>? ]? <use-verb> }

    # Named values
    token maximum { 'max' | 'maximum' }
    token minimum { 'min' | 'minimum' }
    token step { 'step' }

    # Value types
    token number-value { (\d+ ['.' \d*]?  [ [e|E] \d+]?) }
    token integer-value { \d+ }
    token percent { '%' | 'percent' }
    token percent-value { <number-value> <.percent> }
    token boolean-value { 'True' | 'False' | 'true' | 'false' | 'TRUE' | 'FALSE' }

    # Lists of things
    token list-separator-symbol { ',' | '&' | 'and' | ',' \h* 'and' }
    token list-separator { <.ws>? <list-separator-symbol> <.ws>? }
    token list { 'list' }

    # Number list
    rule number-value-list { <number-value>+ % <list-separator>? }

    # Range spec
    rule range-spec { <range-spec-from> <range-spec-to> <range-spec-step>? }
    rule range-spec-from { <.from-preposition> <number-value> }
    rule range-spec-to { <.to-preposition> <number-value> }
    rule range-spec-step { <.range-spec-step-phrase> <number-value> }
    rule range-spec-step-phrase { <with-preposition>? 'step' | <with-preposition> }

    # Programming languages ranges
    rule wl-range-spec { [ 'Range' '[' | 'Range[' ] <number-value-list> ']' }
    rule r-range-spec { [ 'seq' '(' | 'seq(' ] <number-value-list> ')' }
    rule wl-numeric-list-spec { '{' <number-value-list> '}' }
    rule r-numeric-list-spec { [ [ 'c' | 'list' ] '(' | 'c(' | 'list(' ] <number-value-list> ')' }

    # Operators
    token equal-symbol { '=' }
    token equal2-symbol { '==' }
    token assign-to-operator { ':=' | '<-' }

    # Expressions
    token wl-expr { \S+ }
}