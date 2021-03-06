plot(1)

# NAME

plot - line graphs on the command line

# SYNOPSIS

_plot_ [OPTIONS]

# DESCRIPTION

plot reads sequences of numbers and outputs a line graph.

# OPTIONS

*-i* (<filename> | -)
	add filename (or stdin) as a data source.  see *INPUT*

*-a* <n>
	average n inputs per data point.  For example, given -a 5, every 5
	numbers read will be averaged together to produce one output

*-f*
	"follow" input, e.g. continuously monitor inputs for new data and
	redraw the plot every time a new number is read.  Additionally, when
	the length of the plot reaches the maximum width, begin scrolling to
	the left.

*-d* [height]:[width]
	set plot dimensions (not including axis labels)

*-x* [every]:[offset]:[mod]:[side]:[color]
	set x label format.  You may omit fields, in which case the default is
	used.  e.g. 4::3 will only set every=4 and mod=3, leaving the rest of
	the parameters unchanged.

	*every* - display "every" nth number.
		e.g., if *every* = 2, display every 2 numbers:
			0 2 4 6 8...

	*offset* - start counting at this number.
		e.g., if *every* = 2 and *offset* = -2:
			\-2 0 2 4 6 8...

	*mod* - perform modulo *mod* on the number before printing.
		e.g., if *every* = 2 and *offset* = -2 and *mod* = 4:
			2 0 2 0 2 0...

	*side* - specify label position, default: bottom
		*0*: hide, *1*: bottom, *2*: top, *3*: top and bottom

	*color* - color of zeroes.  see *COLORS*

	ex: Label hourly data, indicating every four hours
	```
	plot -x4::24::
	```

*-y* [width]:[prec]:[side]
	set y label format

	*width* - the width of the label

	*prec* - the precision of the label

	*side* - specify label position
		*0*: hide, *1*: left, *2*: right, *3*: left and right

	*width* and *prec* are used to generate a format string that is
	subsequently used to format and print the label using *printf*(3).  The
	format string template looks something like this: "%<width>.<prec>f"

*-c* <color>
	color of next data source.  see *COLORS*

*-m*
	visually merge overlapping lines
		e.g. ╯ and ╰ form ┴

*-s* %<charset> | ascii | unicode
	set the output charset.  The default is *unicode*.  *ascii* uses only
	ascii characters.  Finally, you can specify a custom charset by passing
	an argument in the form of %<charset> where <charset> is a string
	containing 12 utf8 codepoints.

	For example, to get the default unicode charset:
	```
	-s "% ╭│╰├╮─┬╯┤┴┼"
	```
	(note the space right after the %).

	Here's another example to try:
	```
	-s "% ╔║╚╠╗═╦╝╣╩╬".
	```

	If you pass an insufficient number of codepoints, the missing ones will
	show up as '?'.

*-h*
	Show usage

# INPUT

Multiple inputs can be specified with *-i*.  If no inputs are specified, stdin
is read. Invalid (not 0-9, or -) characters in the input are skipped.  Numbers
are parsed using *strtod*(3).  The sequence "1, 2 3aaaaa4" would be interpreted
the same as the sequence "1 2.0 3 4". This allows plot to read a list of
numbers delimited in almost any way.

# COLORS

A color is specified using a character.  The available characters are:

*b*lack, *r*ed, *g*reen, *y*ellow, b*l*ue, *m*agenta, *c*yan, *w*hite

Additionally, the character may be capitalized to get the "bright" version of
the color. E.g. R == bright red.

# EXAMPLE

With a little shell scripting, you can use plot to monitor your network usage.

```
#!/bin/sh

count_packets() {
	ifconfig "$1" | grep "$2 packets" | awk '{print $3}' 
}

monitor_net() {
	op=$(count_packets $1 $2)
	while true; do
		p=$(count_packets $1 $2)
		echo $((p-op))
		op=$p
		sleep 1
	done
}

random=$RANDOM
monitor_net $1 RX > /tmp/${random}rx&
monitor_net $1 TX > /tmp/${random}tx&

plot -f -cr -i /tmp/${random}rx -cl -i /tmp/${random}tx
```

# AUTHORS

Maintained by Stone Tickle <lattis@mochiro.moe>
