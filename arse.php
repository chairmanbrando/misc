<?php

/**
 * (AR)ray (S)lash (E)valuation
 *
 * Swiped this idea from GForms. It's not that useful unless you regularly need to dive deep into
 * multi-dimensional arrays. If you do then it eliminates the clunky-to-type normal notation.
 *
 * Before: `$array['settings']['typography']['fontSizes']['default']`
 * After:  `arse($array, 'settings/typography/fontSizes/default');
 *
 * No, the raw character savings aren't much, but the latter is much easier to type, and I'd say
 * it's a bit clearer to read as well.
 *
 * Is needing something like this kind of a smell? A clue that you should be using better data
 * objects instead of arrays? Yeah, perhaps, but sometimes you gotta array things. 🤷‍♀️
 */
function arse($array, $key, $default = null) {
	if (! is_array($array)) return $default;

	// Bail early for one-dimensional array access sans slashes.
	if (! str_contains($key, '/')) {
		return (array_key_exists($key, $array)) ? $array[$key] : $default;
	}

	$keys  = explode('/', $key);
	$value = $array;

	// Recurse into the array until we hit a single dimension.
	foreach ($keys as $key) {
		$value = arse($value, $key, $default);
	}

	return $value;
}
