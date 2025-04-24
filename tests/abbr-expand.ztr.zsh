#!/usr/bin/env zsh

main() {
	emulate -LR zsh

	{
		ZTR_TEARDOWN_FN() {
			emulate -LR zsh

			abbr erase $test_abbr_abbreviation
			abbr erase $test_abbr_single_quotes
			abbr erase $test_abbr_double_quotes
			abbr erase $test_abbr_unpaired_quotes
			abbr erase $test_abbr_leading_space
			abbr erase $test_abbr_trailing_space
			abbr erase $test_abbr_leading_and_trailing_space
		}

		abbr add $test_abbr_abbreviation=$test_abbr_expansion
		ztr test '[[ $(abbr expand $test_abbr_abbreviation) == $test_abbr_expansion ]]' \
			"Can expand an abbreviation in a script" \
			"Dependencies: erase"

		abbr -g add $test_abbr_abbreviation=$test_abbr_expansion
		ztr test '[[ $(abbr expand $test_abbr_abbreviation) == $test_abbr_expansion ]]' \
			"Can expand a global abbreviation in a script with the flag before the command" \
			"Dependencies: erase"

		abbr add $test_abbr_abbreviation=$test_abbr_expansion -g
		ztr test '[[ $(abbr expand $test_abbr_abbreviation) == $test_abbr_expansion ]]' \
			"Can expand a global abbreviation in a script with the flag after the command args" \
			"Dependencies: erase"

		abbr add -g $test_abbr_abbreviation=$test_abbr_expansion
		ztr test '[[ $(abbr expand $test_abbr_abbreviation) == $test_abbr_expansion ]]' \
			"Can expand a global abbreviation in a script with the flag between the command and its args" \
			"Dependencies: erase"

		abbr add -S $test_abbr_abbreviation=$test_abbr_expansion
		ztr test '[[ $(abbr expand $test_abbr_abbreviation) == $test_abbr_expansion ]]' \
			"Can expand a session abbreviation in a script" \
			"Dependencies: erase"

		abbr add -S -g $test_abbr_abbreviation=$test_abbr_expansion
		ztr test '[[ $(abbr expand $test_abbr_abbreviation) == $test_abbr_expansion ]]' \
			"Can expand a global session abbreviation in a script" \
			"Dependencies: erase"

		abbr add $test_abbr_abbreviation=$test_abbr_expansion
		ztr test '[[ $(abbr expand "$prefix_one_word$test_abbr_abbreviation") == "$prefix_one_word$test_abbr_expansion" ]]' \
			"Can expand an abbreviation, prefixed with one word, in a script" \
			"Dependencies: erase"

		abbr add -S $test_abbr_abbreviation=$test_abbr_expansion
		ztr test '[[ $(abbr expand "$prefix_one_word$test_abbr_abbreviation") == "$prefix_one_word$test_abbr_expansion" ]]' \
			"Can expand a session abbreviation, prefixed with one word, in a script" \
			"Dependencies: erase"

		abbr add $test_abbr_abbreviation=$test_abbr_expansion
		ztr test '[[ $(abbr expand "$prefix_multi_word$test_abbr_abbreviation") == "$prefix_multi_word$test_abbr_expansion" ]]' \
			"Can expand an abbreviation, prefixed with multiple words, in a script" \
			"Dependencies: erase"

		abbr add -S $test_abbr_abbreviation=$test_abbr_expansion
		ztr test '[[ $(abbr expand "$prefix_multi_word$test_abbr_abbreviation") == "$prefix_multi_word$test_abbr_expansion" ]]' \
			"Can expand a session abbreviation, prefixed with multiple words, in a script" \
			"Dependencies: erase"

		abbr add $test_abbr_abbreviation=$test_abbr_expansion
		ztr test '[[ $(abbr expand "$prefix_double_quotes$test_abbr_abbreviation") == "$prefix_double_quotes$test_abbr_expansion" ]]' \
			"Can expand an abbreviation, prefixed with a prefix containing single-quoted double quotes, in a script" \
			"Dependencies: erase"

		abbr add -S $test_abbr_abbreviation=$test_abbr_expansion
		ztr test '[[ $(abbr expand "$prefix_double_quotes$test_abbr_abbreviation") == "$prefix_double_quotes$test_abbr_expansion" ]]' \
			"Can expand a session abbreviation, prefixed with a prefix containing single-quoted double quotes, in a script" \
			"Dependencies: erase"

		abbr add $test_abbr_abbreviation=$test_abbr_expansion
		ztr test '[[ $(abbr expand "$prefix_single_quotes$test_abbr_abbreviation") == "$prefix_single_quotes$test_abbr_expansion" ]]' \
			"Can expand an abbreviation, prefixed with a prefix containing double-quoted single quotes, in a script" \
			"Dependencies: erase"

		abbr add -S $test_abbr_abbreviation=$test_abbr_expansion
		ztr test '[[ $(abbr expand "$prefix_single_quotes$test_abbr_abbreviation") == "$prefix_single_quotes$test_abbr_expansion" ]]' \
			"Can expand a session abbreviation, prefixed with a prefix containing double-quoted single quotes, in a script" \
			"Dependencies: erase"

		abbr add $test_abbr_abbreviation=$test_abbr_expansion
		ztr test '[[ $(abbr expand "$prefix_glob_1_match_1$test_abbr_abbreviation") == "$prefix_glob_1_match_1$test_abbr_expansion" ]]' \
			"Can expand an abbreviation, prefixed with a glob, in a script — 1/n" \
			"Dependencies: erase"

		abbr add $test_abbr_abbreviation=$test_abbr_expansion
		ztr test '[[ $(abbr expand "$prefix_glob_1_match_2$test_abbr_abbreviation") == "$prefix_glob_1_match_2$test_abbr_expansion" ]]' \
			"Can expand an abbreviation, prefixed with a glob, in a script — 2/n" \
			"Dependencies: erase"

		abbr add $test_abbr_abbreviation=$test_abbr_expansion
		ztr test '[[ -z $(abbr expand "$prefix_glob_1_mismatch$test_abbr_abbreviation") ]]' \
			"Can expand an abbreviation, prefixed with a glob, in a script — 3/n" \
			"Dependencies: erase"

		abbr add $test_abbr_abbreviation=$test_abbr_expansion
		ztr test '[[ $(abbr expand "$prefix_multi_word$prefix_double_quotes$test_abbr_abbreviation") == "$prefix_multi_word$prefix_double_quotes$test_abbr_expansion" ]]' \
			"Can expand an abbreviation, prefixed with a linear combination of scalar prefixes, in a script" \
			"Dependencies: erase"

		abbr add -S $test_abbr_abbreviation=$test_abbr_expansion
		ztr test '[[ $(abbr expand "$prefix_glob_1_match_1$prefix_glob_2_match$test_abbr_abbreviation") == "$prefix_glob_1_match_1$prefix_glob_2_match$test_abbr_expansion" ]]' \
			"Can expand a session abbreviation, prefixed with a linear combination of glob prefixes, in a script" \
			"Dependencies: erase"

		abbr add -S $test_abbr_abbreviation=$test_abbr_expansion
		ztr test '[[ $(abbr expand "$prefix_double_quotes$prefix_glob_2_match$test_abbr_abbreviation") == "$prefix_double_quotes$prefix_glob_2_match$test_abbr_expansion" ]]' \
			"Can expand a session abbreviation, prefixed with a scalar prefix followed by a glob prefix, in a script" \
			"Dependencies: erase"

		abbr add -S $test_abbr_abbreviation=$test_abbr_expansion
		ztr test '[[ $(abbr expand "$prefix_glob_2_match$prefix_double_quotes$test_abbr_abbreviation") == "$prefix_glob_2_match$prefix_double_quotes$test_abbr_expansion" ]]' \
			"Can expand a session abbreviation, prefixed with a glob prefix followed by a scalar prefix, in a script" \
			"Dependencies: erase"

		abbr add -S $test_abbr_abbreviation=$test_abbr_expansion
		ztr test '[[ $(abbr expand "$prefix_glob_1_match_1$prefix_glob_2_match$prefix_double_quotes$prefix_multi_word$test_abbr_abbreviation") == "$prefix_glob_1_match_1$prefix_glob_2_match$prefix_double_quotes$prefix_multi_word$test_abbr_expansion" ]]' \
			"Can expand a session abbreviation, prefixed with mixed glob and scalar prefixes, in a script" \
			"Dependencies: erase"

		abbr $test_abbr_abbreviation_multiword=$test_abbr_expansion
		ztr test '[[ $(abbr expand $test_abbr_abbreviation_multiword) == $test_abbr_expansion ]]' \
			"Can expand a two-word abbreviation in a script" \
			"Dependencies: erase"
		abbr erase $test_abbr_abbreviation_multiword

		abbr "a b c"=$test_abbr_expansion
		ztr test '[[ $(abbr expand "a b c") == $test_abbr_expansion ]]' \
			"Can expand a three-word abbreviation in a script" \
			"Dependencies: erase"
		abbr erase "a b c"

		abbr -g $test_abbr_abbreviation=$test_abbr_expansion
		ztr test '[[ $(abbr expand "$prefix_for_global_test $test_abbr_abbreviation") == $test_abbr_expansion ]]' \
			"Can expand a global abbreviation when is preceded by other text in a script" \
			"Dependencies: erase"

		abbr -g $test_abbr_single_quotes=$test_abbr_expansion
		ztr test '[[ $(abbr expand "$prefix_for_global_test $test_abbr_single_quotes") == $test_abbr_expansion ]]' \
			"Can expand a global abbreviation with single quotes when is preceded by other text in a script" \
			"Dependencies: erase"

		abbr -g $test_abbr_double_quotes=$test_abbr_expansion
		ztr test '[[ $(abbr expand "$prefix_for_global_test $test_abbr_double_quotes") == $test_abbr_expansion ]]' \
			"Can expand a global abbreviation with double quotes when is preceded by other text in a script" \
			"Dependencies: erase"

		abbr -g $test_abbr_unpaired_quotes=$test_abbr_expansion
		ztr test '[[ $(abbr expand "$prefix_for_global_test $test_abbr_unpaired_quotes") == $test_abbr_expansion ]]' \
			"Can expand a global abbreviation with unpaired quotes when is preceded by other text in a script" \
			"Dependencies: erase"

		abbr -g $test_abbr_leading_space=$test_abbr_expansion
		ztr test '[[ $(abbr expand "$prefix_for_global_test $test_abbr_leading_space") == $test_abbr_expansion ]]' \
			"Can expand a global abbreviation with leading space when is preceded by other text in a script" \
			"Dependencies: erase"

		abbr -g $test_abbr_trailing_space=$test_abbr_expansion
		ztr test '[[ $(abbr expand "$prefix_for_global_test $test_abbr_trailing_space") == $test_abbr_expansion ]]' \
			"Can expand a global abbreviation with trailing space when is preceded by other text in a script" \
			"Dependencies: erase"

		abbr -g $test_abbr_leading_and_trailing_space=$test_abbr_expansion
		ztr test '[[ $(abbr expand "$prefix_for_global_test $test_abbr_leading_and_trailing_space") == $test_abbr_expansion ]]' \
			"Can expand a global abbreviation with leading space and trailing space when is preceded by other text in a script" \
			"Dependencies: erase"
	} always {
		unfunction -m ZTR_TEARDOWN_FN
	}
}

main
