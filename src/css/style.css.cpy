body {
	margin: 0 auto;
	padding: 0 0.5rem;
	max-width: 45rem;
	float: none;
	text-align: left;
}

ul.navbar {
	list-style-type: none;
	margin: 0;
	padding: 0;
	overflow: hidden;
	border-bottom-style: solid;
	border-width: 0.1rem;
}

ul.navbar li a {
	display: block;
	text-align: center;
	padding: 0.4rem 0.4rem;
	text-decoration: none;
	border-left-style: dotted;
	border-width: 0.1rem;
	border-radius: 0.7rem;
}

ul.navbar li { float: left; }

ul.navbar li.right { float: right; }

header {
	border-bottom-style: solid;
	border-width: 0.1rem;
}

header img { float:right; }

header p.end { clear:right; }

header h1,
header p { margin: 0.7rem 0; }

img {
	max-width: 90%;
	height: auto;
	display: block;
	margin-left: auto;
	margin-right: auto;
}

img.half {
	max-width: 44%;
	display: inline-block;
	padding: 0.25rem;
}

code {
	background-color: lightgrey;
	border: 0.1rem solid;
	display: block;
	overflow-x: auto;
	padding: 0.5rem;
	word-wrap: normal;
}

footer {
	border-top-style: solid;
	border-width: 0.1rem;
	margin: 0.5rem auto;
}

@media print {
	img {
		break-before: auto;
		break-after: auto;
		break-inside: avoid;
	}
}
